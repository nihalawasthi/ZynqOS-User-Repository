# ZynqOS User Repository (ZUR)

Welcome to the ZynqOS User Repository! This is a community-driven repository where anyone can contribute custom applications and packages for ZynqOS, similar to how the Arch User Repository (AUR) functions for Arch Linux.

## What is ZUR?

The ZynqOS User Repository (ZUR) is a collection of package build scripts and metadata maintained by the ZynqOS community. It enables users to easily share, discover, and install custom applications that are not part of the official ZynqOS repositories.

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

1. Browse the `packages/` directory to find applications
2. Navigate to the package directory you want to install
3. Follow the instructions in the package's README.md

### For Contributors

1. Fork this repository
2. Create your package following the [Package Guidelines](docs/PACKAGE_GUIDELINES.md)
3. Use the provided [template](templates/package-template/) as a starting point
4. Submit a pull request
5. See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines

## Package Format

Each package should contain:

- `PKGINFO` - Package metadata (name, version, description, dependencies, etc.)
- `build.sh` - Build/installation script
- `README.md` - Package-specific documentation
- Source files or links to source code

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

## Acknowledgments

Inspired by the Arch User Repository (AUR) and designed to serve the ZynqOS community.