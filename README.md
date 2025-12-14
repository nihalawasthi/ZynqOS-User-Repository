# ZynqOS User Repository (ZUR)

Welcome to the ZynqOS User Repository! This is a community-driven repository where anyone can contribute custom WebAssembly applications and packages for ZynqOS, similar to how the Arch User Repository (AUR) functions for Arch Linux.

## What is ZUR?

The ZynqOS User Repository (ZUR) is a collection of WebAssembly packages (WASM, WASI, wasm-bindgen) maintained by the ZynqOS community. It enables users to easily share, discover, and install custom applications that run in the browser through ZynqOS.

**Key Features of ZynqOS Packages:**
- 🦀 Built with Rust, C, C++, or AssemblyScript
- 🌐 Runs entirely in the browser (no server needed)
- 🔒 Sandboxed execution for security
- 📦 Distributed as WebAssembly binaries
- ⚡ Near-native performance

## Features

- **Community-Driven**: Anyone can contribute packages
- **Easy to Use**: Simple package format and structure
- **Organized**: Clean directory structure with categorized applications
- **Well-Documented**: Clear guidelines and templates for contributors
- **Quality Focused**: Package review process ensures quality and security

## Repository Structure

```
ZynqOS-User-Repository/
├── packages/               # All user-contributed packages
│   ├── development/       # Development tools and IDEs
│   ├── games/            # Games and entertainment
│   ├── multimedia/       # Audio, video, and graphics applications
│   ├── network/          # Network utilities and tools
│   ├── productivity/     # Office and productivity applications
│   ├── system/           # System utilities and tools
│   └── utilities/        # General utilities
├── templates/            # Package templates and examples
├── docs/                 # Additional documentation
└── CONTRIBUTING.md       # Contribution guidelines
```

## Quick Start

### For Users

**Install from ZynqOS App Store:**
1. Open ZynqOS in your browser
2. Launch **App Store** from Start Menu
3. Browse available packages from ZUR
4. Click Install on any package
5. Find it in your Start Menu after installation

**Manual Installation:**
1. Browse the `packages/` directory to find applications
2. Download the package release (`.wasm` or `.zip` file)
3. In ZynqOS, open **App Store** → **Upload** tab
4. Select the downloaded file and click Upload

### For Contributors

**Quick Package Submission:**
1. Fork this repository
2. Build your WASM package: `wasm-pack build --target web`
3. Create GitHub release and upload your binary
4. Create package directory: `packages/<category>/<your-package>/`
5. Add required files:
   - `PKGINFO` - Package metadata (with downloadUrl to your release)
   - `README.md` - Usage instructions
   - `LICENSE` - License file
6. Submit a pull request
6. See [CONTRIBUTING.md](CONTRIBUTING.md) and [Package Guidelines](docs/PACKAGE_GUIDELINES.md)

**Build Tools Required:**
- Rust + wasm-pack (recommended)
- Or: Emscripten (C/C++), AssemblyScript, etc.
- See [Package Creation Guide](https://github.com/nihalawasthi/MicroOs/blob/main/docs/PACKAGE_CREATION_GUIDE.md)

## Package Format

ZUR packages are WebAssembly binaries hosted on GitHub Releases with metadata in this repository:

Each package directory should contain:

- `PKGINFO` - Package metadata (name, version, description, downloadUrl, etc.)
- `README.md` - Usage instructions and build guide
- `LICENSE` - License file

The actual `.wasm` or `.zip` binary is hosted on your GitHub release and referenced in PKGINFO's `downloadUrl` field.

## Getting Help

- Check the [documentation](docs/) for detailed guides
- Open an issue for questions or problems
- Review existing packages for examples

## Community Guidelines

- Be respectful and welcoming to all contributors
- Follow the package guidelines and naming conventions
- Test your packages before submitting
- Maintain your contributed packages
- Report security issues responsibly

## License

Individual packages may have their own licenses. Please check each package directory for licensing information. The repository infrastructure is licensed under Apache License 2.0.

## Contributors

Thanks to all the amazing people who contribute to ZUR!

<a href="https://github.com/nihalawasthi/ZynqOS-User-Repository/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=nihalawasthi/ZynqOS-User-Repository" />
</a>

## ZynqOS Founder

  <img src="" />


## Acknowledgments

Inspired by the Arch User Repository (AUR) and designed to serve the ZynqOS community.