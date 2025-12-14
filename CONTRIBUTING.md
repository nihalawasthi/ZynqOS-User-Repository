# Contributing to ZynqOS User Repository

Thank you for your interest in contributing WebAssembly packages to the ZynqOS User Repository (ZUR)! This document provides guidelines for submitting and maintaining packages.

## Table of Contents

- [Quick Start](#quick-start)
- [Requirements](#requirements)
- [Development Setup](#development-setup)
- [Creating a Package](#creating-a-package)
- [Submission Process](#submission-process)
- [Package Maintenance](#package-maintenance)
- [Code of Conduct](#code-of-conduct)

## Quick Start

**TL;DR - To add a package to ZUR:**

1. Build your WASM app with `wasm-pack build --target web --release`
2. Create GitHub release with the `.zip` or `.wasm` file
3. Fork this repository
4. Create `packages/<category>/<pkgname>/` with PKGINFO, README.md, LICENSE
5. Submit Pull Request

**Example**:
```bash
# Build your package
cd my-wasm-app
wasm-pack build --target web --release
cd pkg && zip -r ../my-app-v1.0.0.zip *

# Create GitHub release and upload the zip
# Then fork ZUR and add package metadata
git clone https://github.com/YOUR_USERNAME/ZynqOS-User-Repository.git
cd ZynqOS-User-Repository
mkdir -p packages/productivity/my-app
cd packages/productivity/my-app

# Create PKGINFO
cat > PKGINFO << 'EOF'
pkgname="my-app"
pkgver="1.0.0"
pkgrel="1"
pkgdesc="My awesome WebAssembly app"
pkgtype="wasm-bindgen"
url="https://github.com/user/my-app"
license=('MIT')
maintainer="Your Name <email@example.com>"
icon="https://example.com/icon.png"
downloadUrl="https://github.com/user/my-app/releases/download/v1.0.0/my-app-v1.0.0.zip"
category="productivity"
EOF

# Add README and LICENSE, then submit PR
```

---

## Requirements

### Technical Requirements

**To contribute packages, you need:**

- ✅ GitHub account
- ✅ Git installed
- ✅ Rust + wasm-pack (for building WASM packages)
- ✅ Basic understanding of WebAssembly
- ✅ Package hosted on GitHub with releases

**Your package must:**

- ✅ Be a valid WebAssembly binary (`.wasm` or `.zip` with wasm-bindgen)
- ✅ Execute successfully in ZynqOS
- ✅ Have a permanent downloadUrl (GitHub Releases recommended)
- ✅ Include a 512x512 PNG icon
- ✅ Have a valid open-source license
- ✅ Not contain malware, tracking, or malicious code

### Supported Package Types

| Type | File Format | Use Case |
|------|-------------|----------|
| **wasm-bindgen** | `.zip` (wasm + js) | Interactive apps, games, DOM access ⭐ |
| **WASI** | `.wasm` | CLI tools, file processing |
| **Simple WASM** | `.wasm` | Pure computation, no I/O |

---

## Development Setup

### 1. Install Rust and wasm-pack

```bash
# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install wasm-pack
cargo install wasm-pack

# Add WASI target (optional, for CLI tools)
rustup target add wasm32-wasi
```

### 2. Fork and Clone ZUR

```bash
# Fork via GitHub UI, then clone
git clone https://github.com/YOUR_USERNAME/ZynqOS-User-Repository.git
cd ZynqOS-User-Repository

# Add upstream remote
git remote add upstream https://github.com/nihalawasthi/ZynqOS-User-Repository.git

# Create a branch for your package
git checkout -b add-my-package
```

### 3. Test in ZynqOS

Before submitting, **always test your package**:

1. Build your WASM package
2. Open ZynqOS at https://zynqos.vercel.app (or run locally)
3. Go to App Store → Upload tab
4. Upload your `.wasm` or `.zip` file
5. Click "Execute" and verify it works
6. Check browser console for any errors

---

## Creating a Package

### Step 1: Build Your WebAssembly Package

**For interactive apps (wasm-bindgen)**:

```bash
# Create a new project
cargo new --lib my-app
cd my-app

# Edit Cargo.toml
cat >> Cargo.toml << 'EOF'

[lib]
crate-type = ["cdylib"]

[dependencies]
wasm-bindgen = "0.2"
web-sys = { version = "0.3", features = ["Window", "Document", "HtmlElement"] }
EOF

# Build
wasm-pack build --target web --release

# Package
cd pkg && zip -r ../my-app-v1.0.0.zip *
```

**For CLI tools (WASI)**:

```bash
# Create a new project
cargo new my-cli-tool
cd my-cli-tool

# Build
cargo build --target wasm32-wasi --release

# The .wasm file is your package
cp target/wasm32-wasi/release/my-cli-tool.wasm my-cli-tool-v1.0.0.wasm
```

### Step 2: Create GitHub Release

1. Push your code to GitHub
2. Create a git tag: `git tag v1.0.0 && git push --tags`
3. Go to your repo → Releases → "Create new release"
4. Upload your `.zip` or `.wasm` file as a release asset
5. **Copy the download URL** - you'll need this for PKGINFO

Example download URL:
```
https://github.com/username/my-app/releases/download/v1.0.0/my-app-v1.0.0.zip
```

### Step 3: Create Package Entry in ZUR

In your ZUR fork, create the package directory:

```bash
mkdir -p packages/<category>/<pkgname>
cd packages/<category>/<pkgname>
```

**Choose the right category**:
- `development` - Compilers, debuggers, IDEs
- `games` - Games and entertainment
- `multimedia` - Audio, video, image editors
- `network` - Browsers, chat clients
- `productivity` - Office, note-taking, document editors
- `system` - File managers, system monitors
- `utilities` - General tools

### Step 4: Create PKGINFO

Create a `PKGINFO` file with your package metadata:

```bash
pkgname="my-app"
pkgver="1.0.0"
pkgrel="1"
pkgdesc="Short description (max 80 characters)"
pkgtype="wasm-bindgen"
url="https://github.com/username/my-app"
license=('MIT')
maintainer="Your Name <email@example.com>"
icon="https://example.com/icon.png"
downloadUrl="https://github.com/username/my-app/releases/download/v1.0.0/my-app-v1.0.0.zip"
category="productivity"

# Optional but recommended
author="Original Author"
tags=('editor' 'productivity' 'markdown')
size="1.2 MB"

# Optional: permissions
permissions=(
    'filesystem:read'
    'filesystem:write'
    'network:fetch'
)
```

**Required fields:**
- `pkgname` - Lowercase, hyphens only
- `pkgver` - Semantic version (1.0.0)
- `pkgrel` - Build number (start at 1)
- `pkgdesc` - Short description
- `pkgtype` - wasm, wasi, or wasm-bindgen
- `url` - Project homepage
- `license` - OSI-approved license
- `maintainer` - Your contact info
- `icon` - 512x512 PNG URL
- `downloadUrl` - Permanent HTTPS URL to binary

### Step 5: Create README.md

Explain what your package does and how to use it:

```markdown
# My App

Short description of what your app does.

## Features

- Feature 1
- Feature 2
- Feature 3

## Usage

1. Open from ZynqOS Start Menu
2. Click the button to...
3. Your work is saved automatically

## Screenshots

![Screenshot 1](screenshots/screenshot1.png)

## Building from Source

\```bash
wasm-pack build --target web --release
cd pkg && zip -r ../my-app.zip *
\```

## License

MIT License - see LICENSE file for details

## Author

**Maintainer**: Your Name (@username)  
**Original Author**: Someone Else
```

### Step 6: Add LICENSE

Copy the license file from your project:

```bash
cp /path/to/your/project/LICENSE ./LICENSE
```

Common licenses: MIT, Apache-2.0, GPL-3.0, BSD-3-Clause

### Step 7: (Optional) Add Screenshots

```bash
mkdir screenshots
# Add PNG images showing your app in action
cp screenshot1.png screenshots/
```

---

## Submission Process

### Pre-Submission Checklist

Before submitting your Pull Request, verify:

- [ ] Package builds successfully
- [ ] Package tested in ZynqOS (uploaded via App Store)
- [ ] PKGINFO has all required fields
- [ ] downloadUrl is accessible (test in incognito browser)
- [ ] Icon URL loads (512x512 PNG)
- [ ] README.md explains usage
- [ ] LICENSE file included
- [ ] Package name doesn't conflict with existing packages
- [ ] No syntax errors in PKGINFO (`bash -n PKGINFO`)

### Submitting the Pull Request

1. **Commit your changes**:
   ```bash
   git add packages/<category>/<pkgname>/
   git commit -m "Add <pkgname> v<version>"
   ```

2. **Push to your fork**:
   ```bash
   git push origin add-my-package
   ```

3. **Open Pull Request**:
   - Go to your fork on GitHub
   - Click "Pull Request"
   - Base: `upstream/main` ← Head: `your-fork/add-my-package`
   - Title: `Add <pkgname> v<version>`
   - Description: Brief explanation of what the package does

4. **PR Description Template**:
   ```markdown
   ## Package Information
   
   **Name**: my-app  
   **Version**: 1.0.0  
   **Type**: wasm-bindgen  
   **Category**: productivity  
   
   ## Description
   
   My App is a WebAssembly-based text editor with markdown support.
   
   ## Testing
   
   - [x] Built successfully with wasm-pack
   - [x] Tested in ZynqOS App Store
   - [x] Download URL verified
   - [x] Icon loads correctly
   
   ## Checklist
   
   - [x] PKGINFO complete
   - [x] README.md included
   - [x] LICENSE included
   - [x] No conflicts with existing packages
   ```

### Review Process

Maintainers will:
1. Check PKGINFO format and required fields
2. Verify downloadUrl is accessible
3. Test icon URL
4. Review README and LICENSE
5. Check for naming conflicts
6. Verify package category is appropriate
7. Test package in ZynqOS (if possible)

**Approval criteria:**
- ✅ All required files present
- ✅ PKGINFO format valid
- ✅ Download URL works
- ✅ Icon loads
- ✅ No malicious code
- ✅ License is OSI-approved

---

## Package Maintenance

### Updating Your Package

When you release a new version:

1. **Update your package source and create new GitHub release**
2. **Update PKGINFO** in ZUR:
   ```bash
   pkgver="1.1.0"  # New version
   pkgrel="1"      # Reset to 1
   downloadUrl="https://github.com/user/my-app/releases/download/v1.1.0/my-app-v1.1.0.zip"
   ```
3. **Update README.md** if needed (new features, changed usage)
4. **Submit PR** with title: `Update <pkgname> to v<version>`

### Responding to Issues

- Monitor issues for your packages
- Respond within reasonable time (1-2 weeks)
- Fix critical bugs quickly (security, crashes)
- Update documentation if users report confusion

### Transferring Maintainership

If you can't maintain a package anymore:

1. Open an issue: "Looking for new maintainer for <pkgname>"
2. Wait for volunteer
3. Update `maintainer` field in PKGINFO
4. Submit PR with title: "Transfer <pkgname> maintainership to @newmaintainer"

### Deprecating Packages

If abandoning without replacement:

1. Add to PKGINFO: `deprecated="true"`
2. Add to PKGINFO: `notes="This package is no longer maintained"`
3. Update README.md with deprecation notice
4. Submit PR with title: "Deprecate <pkgname>"

---

## Code of Conduct

### Be Respectful

- Treat all contributors with respect
- Provide constructive feedback
- Be patient with newcomers
- Assume good intentions

### Package Quality

- Test thoroughly before submitting
- Write clear documentation
- Follow naming conventions
- Keep packages updated
- Respond to issues promptly

### Security

- No malware, tracking, or malicious code
- Report vulnerabilities privately
- Update packages with security fixes quickly
- Don't embed secrets/API keys in code

### Licensing

- Only submit packages with OSI-approved licenses
- Respect upstream licenses
- Include proper attribution
- Don't submit proprietary software

---

## Getting Help

### Documentation

- 📖 [Package Guidelines](docs/PACKAGE_GUIDELINES.md) - Detailed specifications
- 📖 [Quick Start Guide](README.md) - Getting started with ZUR
- 📖 [WASM Package Creation](../MicroOs/docs/PACKAGE_CREATION_GUIDE.md) - Building WASM packages

### Community

- 💬 [GitHub Discussions](https://github.com/nihalawasthi/ZynqOS-User-Repository/discussions) - Ask questions
- 🐛 [GitHub Issues](https://github.com/nihalawasthi/ZynqOS-User-Repository/issues) - Report problems
- 📧 Email: maintainer contact from README

### Examples

Look at existing packages for reference:
```bash
# Browse example packages
ls packages/utilities/
ls packages/productivity/

# Study a complete package
cat packages/utilities/hello-zynq/PKGINFO
cat packages/utilities/hello-zynq/README.md
```

---

## Tips for Success

### Optimize Your WASM

```bash
# Use wasm-opt to reduce size 50-70%
wasm-opt -Oz input.wasm -o output.wasm

# Enable LTO in Cargo.toml
[profile.release]
lto = true
opt-level = "z"
strip = true
```

### Create Good Icons

- **Size**: 512x512 pixels
- **Format**: PNG with transparency
- **Style**: Simple, recognizable, works at small sizes
- **Tools**: Figma, Inkscape, GIMP
- **Free icons**: [Iconify](https://iconify.design/), [Flaticon](https://www.flaticon.com/)

### Write Clear READMEs

- Start with one-sentence description
- Add screenshots (users love visuals)
- Explain key features
- Show usage examples
- Document keyboard shortcuts
- Include troubleshooting section

### Test Thoroughly

```bash
# Test in ZynqOS before submitting
# Try these scenarios:
1. Fresh install (first time user)
2. Update from previous version
3. Run alongside other apps
4. Test on different browsers (Chrome, Firefox, Safari)
5. Check console for warnings/errors
```

---

## Common Mistakes to Avoid

❌ **Don't do this:**
- Using non-permanent download URLs
- Forgetting to test in ZynqOS
- Missing required PKGINFO fields
- Using low-resolution icons (<512px)
- Hardcoding file paths
- Submitting without LICENSE file
- Using non-descriptive package names

✅ **Do this instead:**
- Use GitHub Releases for permanent URLs
- Test locally before submitting PR
- Double-check all required fields
- Create proper 512x512 icon
- Use ZynqOS virtual filesystem
- Include LICENSE file
- Choose clear, descriptive names

---

## Thank You!

Your contributions make ZynqOS better for everyone. We appreciate your effort in creating and maintaining quality WebAssembly packages.

Happy coding! 🚀

---

**Questions?** Open a discussion or issue on GitHub.

**Last updated**: 2024
