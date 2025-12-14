#!/usr/bin/env pwsh
# Generate manifest.json from all PKGINFO files in packages/

param(
    [string]$OutputPath = "manifest.json"
)

Write-Host "🔍 Scanning for PKGINFO files..." -ForegroundColor Cyan

# Find all PKGINFO files
$pkginfoFiles = Get-ChildItem -Path "packages" -Filter "PKGINFO" -Recurse -File

if ($pkginfoFiles.Count -eq 0) {
    Write-Host "❌ No PKGINFO files found!" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Found $($pkginfoFiles.Count) package(s)" -ForegroundColor Green

# Parse PKGINFO files
$packages = @()
$errors = 0

foreach ($file in $pkginfoFiles) {
    Write-Host "📦 Processing: $($file.Directory.Name)..." -ForegroundColor Yellow
    
    try {
        # Read PKGINFO content
        $content = Get-Content $file.FullName -Raw
        
        # Initialize package object
        $package = @{}
        
        # Parse bash-style variables
        $lines = $content -split "`n"
        foreach ($line in $lines) {
            $line = $line.Trim()
            
            # Skip comments and empty lines
            if ($line -match '^\s*#' -or $line -eq '') { continue }
            
            # Match simple variables: pkgname="value"
            if ($line -match '^(\w+)="([^"]*)"') {
                $key = $matches[1]
                $value = $matches[2]
                $package[$key] = $value
            }
            # Match simple variables: pkgname='value'
            elseif ($line -match "^(\w+)='([^']*)'") {
                $key = $matches[1]
                $value = $matches[2]
                $package[$key] = $value
            }
            # Match unquoted variables: pkgname=value
            elseif ($line -match '^(\w+)=([^\s()]+)') {
                $key = $matches[1]
                $value = $matches[2]
                $package[$key] = $value
            }
            # Match arrays: license=('MIT' 'Apache-2.0')
            elseif ($line -match '^(\w+)=\(([^)]*)\)') {
                $key = $matches[1]
                $arrayContent = $matches[2]
                if ($arrayContent.Trim() -eq '') {
                    # Empty array
                    $package[$key] = @()
                } else {
                    # Extract quoted values
                    $values = [regex]::Matches($arrayContent, "['""]([^'""]+)['""]") | ForEach-Object { $_.Groups[1].Value }
                    $package[$key] = $values
                }
            }
        }
        
        # Validate required fields
        $requiredFields = @('pkgname', 'pkgver', 'pkgdesc', 'pkgtype', 'downloadUrl', 'icon')
        $missingFields = @()
        
        foreach ($field in $requiredFields) {
            if (-not $package.ContainsKey($field) -or [string]::IsNullOrEmpty($package[$field])) {
                $missingFields += $field
            }
        }
        
        if ($missingFields.Count -gt 0) {
            Write-Host "  ❌ Missing required fields: $($missingFields -join ', ')" -ForegroundColor Red
            $errors++
            continue
        }
        
        # Build manifest entry
        $manifestEntry = @{
            id = $package['pkgname']
            name = $package['pkgname']
            version = $package['pkgver']
            description = $package['pkgdesc']
            type = $package['pkgtype']
            downloadUrl = $package['downloadUrl']
            icon = $package['icon']
        }
        
        # Add optional fields if present
        if ($package.ContainsKey('category') -and -not [string]::IsNullOrEmpty($package['category'])) {
            $manifestEntry['category'] = $package['category']
        }
        if ($package.ContainsKey('url') -and -not [string]::IsNullOrEmpty($package['url'])) {
            $manifestEntry['url'] = $package['url']
        }
        if ($package.ContainsKey('author') -and -not [string]::IsNullOrEmpty($package['author'])) {
            $manifestEntry['author'] = $package['author']
        }
        if ($package.ContainsKey('maintainer') -and -not [string]::IsNullOrEmpty($package['maintainer'])) {
            $manifestEntry['maintainer'] = $package['maintainer']
        }
        if ($package.ContainsKey('license')) {
            if ($package['license'] -is [array]) {
                $manifestEntry['license'] = $package['license'][0]  # Take first license
            } else {
                $manifestEntry['license'] = $package['license']
            }
        }
        if ($package.ContainsKey('size') -and -not [string]::IsNullOrEmpty($package['size'])) {
            $manifestEntry['size'] = $package['size']
        }
        if ($package.ContainsKey('tags')) {
            $manifestEntry['tags'] = $package['tags']
        }
        if ($package.ContainsKey('depends')) {
            $manifestEntry['dependencies'] = $package['depends']
        }
        if ($package.ContainsKey('permissions')) {
            $manifestEntry['permissions'] = $package['permissions']
        }
        
        $packages += $manifestEntry
        Write-Host "  ✅ $($package['pkgname']) v$($package['pkgver'])" -ForegroundColor Green
        
    } catch {
        Write-Host "  ❌ Error parsing PKGINFO: $_" -ForegroundColor Red
        $errors++
    }
}

# Generate manifest
$manifest = @{
    name = "ZynqOS User Repository"
    description = "Community-maintained WebAssembly packages for ZynqOS"
    version = "1.0"
    lastUpdated = (Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ")
    packages = $packages
} | ConvertTo-Json -Depth 10

# Write manifest.json
try {
    $manifest | Out-File -FilePath $OutputPath -Encoding UTF8 -NoNewline
    Write-Host ""
    Write-Host "✨ Generated manifest.json with $($packages.Count) package(s)" -ForegroundColor Green
    Write-Host "📁 Output: $OutputPath" -ForegroundColor Cyan
    
    if ($errors -gt 0) {
        Write-Host "⚠️  $errors error(s) encountered" -ForegroundColor Yellow
    }
} catch {
    Write-Host "❌ Failed to write manifest.json: $_" -ForegroundColor Red
    exit 1
}

# Display summary
Write-Host ""
Write-Host "📊 Summary:" -ForegroundColor Cyan
Write-Host "  Total packages: $($packages.Count)"
Write-Host "  Package types:"
$typeGroups = $packages | Group-Object -Property type
foreach ($group in $typeGroups) {
    Write-Host "    - $($group.Name): $($group.Count)"
}
Write-Host "  Categories:"
$catGroups = $packages | Where-Object { $_.category } | Group-Object -Property category
foreach ($group in $catGroups) {
    Write-Host "    - $($group.Name): $($group.Count)"
}

Write-Host ""
Write-Host "🚀 Upload manifest.json to your repository to make packages available!" -ForegroundColor Green
