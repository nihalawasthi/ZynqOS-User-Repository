# ZynqOS Package Guidelines

This document provides detailed guidelines for creating and maintaining WebAssembly packages in the ZynqOS User Repository (ZUR).

## Table of Contents

- [Quick Start](#quick-start)
- [Package Types](#package-types)
- [Package Naming](#package-naming)
- [Directory Structure](#directory-structure)
- [PKGINFO Specification](#pkginfo-specification)
- [Building Packages](#building-packages)
- [Testing](#testing)
- [Security](#security)
- [Publishing](#publishing)
- [Best Practices](#best-practices)

## Quick Start

**Minimum requirements for a ZUR package:**
1. Working WebAssembly binary (`.wasm` or `.zip`)
2. `PKGINFO` file with complete metadata
3. `README.md` explaining what it does
4. `LICENSE` file
5. GitHub release with downloadable binary

**Workflow:**
```bash
# 1. Build your WASM package
wasm-pack build --target web

# 2. Create release archive
cd pkg && zip -r ../myapp-v1.0.0.zip *

# 3. Create GitHub release and upload the zip
# 4. Fork ZUR and create package directory
# 5. Add PKGINFO with downloadUrl pointing to release
# 6. Submit PR
```

## Package Types

ZynqOS supports three types of WebAssembly packages:

### 1. **Simple WASM** (`pkgtype=wasm`)

Pure WebAssembly binary with no external dependencies.

**File format**: Single `.wasm` file

**Use cases**:
- Mathematical libraries
- Data processing
- Algorithms
- No DOM access needed

**Example**:
```rust
// Pure computation
#[no_mangle]
pub extern "C" fn fibonacci(n: i32) -> i32 {
    if n <= 1 { n } else { fibonacci(n-1) + fibonacci(n-2) }
}
```

---

### 2. **WASI** (`pkgtype=wasi`)

WebAssembly System Interface for filesystem and system calls.

**File format**: Single `.wasm` file compiled with WASI target

**Use cases**:
- Command-line tools
- File processors
- System utilities
- Terminal applications

**Example**:
```rust
fn main() {
    println!("Hello from WASI!");
    // Can use std::fs, std::env, etc.
}
```

**Build**: `cargo build --target wasm32-wasi --release`

---

### 3. **wasm-bindgen** (`pkgtype=wasm-bindgen`)  ⭐ RECOMMENDED

Full JavaScript/DOM interop with Rust using wasm-bindgen.

**File format**: `.zip` containing `.wasm`, `.js`, and optional `.d.ts` files

**Use cases**:
- Interactive applications
- Games
- UI components
- DOM manipulation
- Web APIs access

**Example**:
```rust
use wasm_bindgen::prelude::*;

#[wasm_bindgen]
pub fn render_ui() {
    let window = web_sys::window().unwrap();
    let document = window.document().unwrap();
    // Full DOM access!
}
```

**Build**: `wasm-pack build --target web`

---

## Package Naming

### Rules

1. **Lowercase only**: `my-package` not `MyPackage`
2. **Use hyphens**: `file-manager` not `file_manager`
3. **Descriptive**: Name should indicate purpose
4. **Unique**: Check existing packages first
5. **No special chars**: Only `a-z`, `0-9`, and `-`

### Naming Conventions

| Type | Prefix/Format | Example |
|------|---------------|---------|
| Applications | descriptive-name | `text-editor`, `calculator` |
| Games | game-name | `tetris`, `snake-game` |
| Libraries | lib-name | `lib-json`, `lib-crypto` |
| Tools/Utilities | tool-name | `file-converter`, `image-optimizer` |
| Language-specific | lang-package | `rust-analyzer`, `wasm-tools` |

### Examples

✅ **Good names**:
- `markdown-editor`
- `image-viewer`
- `wasm-calculator`
- `music-player`

❌ **Bad names**:
- `MyApp` (not lowercase)
- `app_123` (uses underscore, not descriptive)
- `super@tool` (special character)
- `a` (too short, not descriptive)

---

## Directory Structure

### Required Structure

```
packages/<category>/<package-name>/
├── PKGINFO              # Package metadata (REQUIRED)
├── README.md            # Usage docs (REQUIRED)
├── LICENSE              # License file (REQUIRED)
└── screenshots/         # Optional: preview images
    ├── screenshot1.png
    └── screenshot2.png
```

**Note**: The actual `.wasm` or `.zip` binary should be hosted on GitHub Releases, not in the repository. The `PKGINFO` file contains the `downloadUrl` pointing to the release.

### Categories

Place package in the appropriate category directory:

- **development**: Compilers, debuggers, IDEs, dev tools
- **games**: Games and entertainment
- **multimedia**: Audio, video, image editors
- **network**: Web browsers, chat clients, download managers
- **productivity**: Office suites, note-taking, document editors
- **system**: System utilities, monitors, file managers
- **utilities**: General purpose tools

---

## PKGINFO Specification

### Required Fields

All packages **MUST** include these fields:

```bash
pkgname="my-package"                    # Package name (lowercase, hyphens)
pkgver="1.0.0"                          # Semantic version (MAJOR.MINOR.PATCH)
pkgrel="1"                              # Build number (reset to 1 on version bump)
pkgdesc="Short description"             # One-line description (max 80 chars)
pkgtype="wasm-bindgen"                  # Package type: wasm, wasi, or wasm-bindgen
url="https://github.com/user/repo"     # Project homepage
license=('MIT')                         # License (MIT, GPL-3.0, Apache-2.0, etc.)
maintainer="Name <email@domain.com>"    # Your contact info
icon="https://cdn.../icon.png"          # 512x512 PNG icon URL
downloadUrl="https://github.com/user/repo/releases/download/v1.0.0/my-package.zip"
```

### Optional Fields

```bash
category="productivity"                 # Category for organization
author="Original Author"                # Original software author
depends=('lib-sdl2' 'lib-opengl')      # Runtime dependencies (other packages)
optdepends=('lib-music: for sound')    # Optional enhancements
size="2.5 MB"                          # Package size
tags=('editor' 'markdown' 'wysiwyg')   # Search tags

# Permissions (request what you need)
permissions=(
    'filesystem:read'    # Read files
    'filesystem:write'   # Write files
    'network:fetch'      # HTTP requests
    'storage:local'      # LocalStorage access
    'wasi:stdio'         # Standard I/O (WASI only)
)

notes="Additional information or warnings"
```

### Version Numbering

Use [Semantic Versioning](https://semver.org/):

**Format**: `MAJOR.MINOR.PATCH`

- **MAJOR** (1.0.0): Breaking changes, incompatible API
- **MINOR** (0.1.0): New features, backward compatible
- **PATCH** (0.0.1): Bug fixes only

**Examples**:
- `1.0.0` - Initial stable release
- `1.1.0` - Added new feature
- `1.1.1` - Fixed bug
- `2.0.0` - Breaking API change

### Release Number (pkgrel)

Package rebuild counter:

- Start at `1` for new versions
- Increment for packaging fixes (not code changes)
- Reset to `1` when `pkgver` changes

**Examples**:
```
calculator-1.0.0-1   # Initial release
calculator-1.0.0-2   # Fixed PKGINFO metadata
calculator-1.0.1-1   # New version, reset pkgrel
```

### Download URLs

Must point to GitHub releases or permanent URLs:

```bash
# ✅ Good - GitHub release
downloadUrl="https://github.com/user/repo/releases/download/v1.0.0/app.zip"

# ✅ Good - Permanent CDN
downloadUrl="https://cdn.example.com/packages/app-1.0.0.zip"

# ❌ Bad - Will move/change
downloadUrl="https://mywebsite.com/latest.zip"
```

**Requirements**:
- HTTPS only (no HTTP)
- Permanent, versioned URLs
- Direct download (no redirects to login pages)
- CORS-enabled for browser access

---

## Building Packages

### 1. Install Build Tools

```bash
# Rust + wasm-pack (RECOMMENDED)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install wasm-pack

# Add WASM target for WASI
rustup target add wasm32-wasi
```

### 2. Create Your Project

**For wasm-bindgen (with DOM access)**:
```bash
cargo new --lib my-package
cd my-package

# Add to Cargo.toml:
[lib]
crate-type = ["cdylib"]

[dependencies]
wasm-bindgen = "0.2"
web-sys = { version = "0.3", features = ["Window", "Document"] }

# Build
wasm-pack build --target web --release
```

**For WASI (command-line tools)**:
```bash
cargo new my-cli-tool
cd my-cli-tool

# Build
cargo build --target wasm32-wasi --release
```

### 3. Package for Distribution

**wasm-bindgen packages** (recommended):
```bash
cd pkg
zip -r ../my-package-v1.0.0.zip *
# Upload to GitHub Releases
```

**Simple WASM/WASI**:
```bash
# Just upload the .wasm file to GitHub Releases
cp target/wasm32-wasi/release/my-tool.wasm my-tool-v1.0.0.wasm
```

### 4. Create GitHub Release

1. Tag your code: `git tag v1.0.0 && git push --tags`
2. Go to GitHub → Releases → "Create new release"
3. Upload your `.zip` or `.wasm` file
4. Copy the download URL

### 5. Create ZUR Package Entry

Fork ZUR and create:
```
packages/<category>/<pkgname>/
├── PKGINFO          # Use downloadUrl from step 4
├── README.md        # Usage instructions
└── LICENSE          # Copy from your repo
```

---

## Testing

### Local Testing (Before Submitting)

**Test in ZynqOS directly:**

1. Open ZynqOS App Store
2. Click "Upload" tab
3. Upload your `.wasm` or `.zip` file
4. Click "Execute" to test
5. Check console for errors

**Validate PKGINFO**:
```bash
# Check for required fields
grep -E "pkgname|pkgver|pkgtype|downloadUrl|icon" PKGINFO

# Verify no syntax errors
bash -n PKGINFO
```

### Pre-Submission Checklist

- [ ] Package builds without errors
- [ ] Package executes in ZynqOS successfully
- [ ] PKGINFO has all required fields
- [ ] downloadUrl is permanent and accessible
- [ ] Icon is 512x512 PNG and loads
- [ ] README.md explains what it does
- [ ] LICENSE file is included
- [ ] No hardcoded paths or assumptions about filesystem
- [ ] Tested on fresh ZynqOS install

---

## Security

### Sandboxing

All WASM packages run in browser sandbox:

✅ **Allowed**:
- Memory operations (within WASM)
- Computation
- Canvas/WebGL rendering
- Web APIs (via wasm-bindgen)

❌ **Blocked**:
- Native system calls
- Direct filesystem access (except virtual FS)
- Network sockets (use Fetch API)
- Reading arbitrary memory

### Permissions

Request minimum permissions needed:

```bash
# Only request what you need
permissions=(
    'filesystem:read'    # If you read files
    'network:fetch'      # If you make HTTP requests
)

# Don't request unnecessary permissions
# permissions=('filesystem:write')  # If you don't write files
```

### Best Practices

1. **No secrets in code**: Don't embed API keys, passwords
2. **Validate inputs**: Check user-provided data
3. **Use HTTPS**: All downloadUrls must use HTTPS
4. **Limit dependencies**: Fewer deps = smaller attack surface
5. **Keep updated**: Update wasm-bindgen, dependencies regularly

---

## Publishing

### Submission Process

1. **Fork** [ZynqOS-User-Repository](https://github.com/ZynqOS/ZynqOS-User-Repository)
2. **Create** package directory: `packages/<category>/<pkgname>/`
3. **Add** PKGINFO, README.md, LICENSE
4. **Test** package locally
5. **Commit** with message: `Add <pkgname> v<version>`
6. **Push** to your fork
7. **Open** Pull Request to main repo

### PR Requirements

Your PR must include:

- ✅ Complete PKGINFO with all required fields
- ✅ README.md with usage instructions
- ✅ LICENSE file
- ✅ Working downloadUrl (tested)
- ✅ Valid icon URL (512x512 PNG)

Maintainers will:
- Review PKGINFO format
- Test download URL
- Verify icon loads
- Check for conflicts
- Merge if approved

### Updates

To update an existing package:

1. Bump `pkgver` in PKGINFO
2. Update `downloadUrl` to new release
3. Update README if needed
4. Submit PR with title: `Update <pkgname> to v<version>`

---

## Best Practices

### Performance

**Optimize WASM size**:
```bash
# Use wasm-opt
wasm-opt -Oz input.wasm -o output.wasm

# Strip debug info
wasm-strip output.wasm

# Enable LTO in Cargo.toml
[profile.release]
lto = true
opt-level = "z"
```

**Typical sizes**:
- Simple WASM: 10-100 KB
- WASI tool: 100-500 KB  
- wasm-bindgen app: 200 KB - 2 MB
- Game with assets: 2-10 MB

### Documentation

**README.md should include**:
```markdown
# Package Name

Short description

## Features
- Feature 1
- Feature 2

## Usage
1. Open from Start Menu
2. Click button to...

## Screenshots
![Screenshot](screenshots/screenshot1.png)

## Building
\```bash
wasm-pack build --target web --release
\```

## License
MIT
```

**Clear error messages**:
```rust
#[wasm_bindgen]
pub fn process_file(data: &[u8]) -> Result<String, JsValue> {
    if data.is_empty() {
        return Err(JsValue::from_str("File is empty"));
    }
    // Process...
}
```

### Maintenance

- **Keep updated**: Update when upstream releases new versions
- **Fix bugs**: Respond to issue reports
- **Test updates**: Verify updates work before pushing
- **Deprecation**: If abandoning, mark as deprecated in PKGINFO
- **Handoff**: Transfer maintainership if you can't continue

---

## Quick Reference

### Minimal PKGINFO Template

```bash
pkgname="my-app"
pkgver="1.0.0"
pkgrel="1"
pkgdesc="Short description"
pkgtype="wasm-bindgen"
url="https://github.com/user/repo"
license=('MIT')
maintainer="Your Name <email@example.com>"
icon="https://cdn.example.com/icon.png"
downloadUrl="https://github.com/user/repo/releases/download/v1.0.0/my-app.zip"
category="productivity"
```

### Build Commands

```bash
# wasm-bindgen (with DOM)
wasm-pack build --target web --release
cd pkg && zip -r ../app.zip *

# WASI (CLI tool)
cargo build --target wasm32-wasi --release
cp target/wasm32-wasi/release/app.wasm app-v1.0.0.wasm

# Optimize
wasm-opt -Oz input.wasm -o output.wasm
```

### File Checklist

- [ ] `PKGINFO` - Complete metadata
- [ ] `README.md` - Usage docs
- [ ] `LICENSE` - License file
- [ ] Binary on GitHub Releases (`.wasm` or `.zip`)
- [ ] `screenshots/` (optional) - Preview images

---

## Need Help?

- 📖 [Quick Start Guide](../README.md)
- 🎯 [Example Packages](../packages/)
- 💬 [GitHub Discussions](https://github.com/ZynqOS/ZynqOS-User-Repository/discussions)
- 🐛 [Report Issues](https://github.com/ZynqOS/ZynqOS-User-Repository/issues)

---

**Last updated**: 2024  
**ZUR Version**: 1.0
