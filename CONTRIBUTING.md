# Contributing to ZynqOS User Repository

Thank you for your interest in contributing to the ZynqOS User Repository! This document provides guidelines and instructions for contributing packages.

## Table of Contents

- [Getting Started](#getting-started)
- [Package Guidelines](#package-guidelines)
- [Submission Process](#submission-process)
- [Package Maintenance](#package-maintenance)
- [Code of Conduct](#code-of-conduct)

## Getting Started

### Prerequisites

- A GitHub account
- Git installed on your system
- Familiarity with ZynqOS
- Basic understanding of shell scripting

### Setting Up

1. Fork the repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/ZynqOS-User-Repository.git
   cd ZynqOS-User-Repository
   ```
3. Add upstream remote:
   ```bash
   git remote add upstream https://github.com/nihalawasthi/ZynqOS-User-Repository.git
   ```

## Package Guidelines

### Package Structure

Each package must be placed in the appropriate category under `packages/` and contain:

```
packages/CATEGORY/package-name/
├── PKGINFO              # Required: Package metadata
├── build.sh             # Required: Build/installation script
├── README.md            # Required: Package documentation
├── package-name.patch   # Optional: Patches if needed
└── additional-files/    # Optional: Additional resources
```

### PKGINFO Format

The `PKGINFO` file contains package metadata in a simple key-value format:

```bash
pkgname=example-app
pkgver=1.0.0
pkgrel=1
pkgdesc="A short description of the package"
arch=('armv7' 'aarch64' 'x86_64')
url="https://example.com/project"
license=('GPL')
depends=('dependency1' 'dependency2')
makedepends=('build-dependency1')
source=('https://example.com/source.tar.gz')
sha256sums=('checksum-here')
maintainer="Your Name <your.email@example.com>"
```

### build.sh Requirements

The build script should:
- Be executable (`chmod +x build.sh`)
- Handle errors gracefully
- Provide clear output messages
- Include a build() function for compilation
- Include a package() function for installation

Example:
```bash
#!/bin/bash
set -e

build() {
    echo "Building ${pkgname}..."
    # Add build commands here
}

package() {
    echo "Packaging ${pkgname}..."
    # Add installation commands here
}

# Execute functions
build
package
```

### Naming Conventions

- Package names should be lowercase
- Use hyphens to separate words (e.g., `my-package`)
- Keep names descriptive but concise
- Avoid special characters except hyphens

### Categories

Choose the appropriate category for your package:

- **development**: IDEs, compilers, debuggers, version control tools
- **games**: Games and entertainment software
- **multimedia**: Audio/video players, editors, graphics tools
- **network**: Web browsers, download managers, network utilities
- **productivity**: Office suites, document editors, note-taking apps
- **system**: System utilities, monitoring tools, file managers
- **utilities**: General-purpose utilities that don't fit other categories

## Submission Process

### 1. Create Your Package

1. Use the template from `templates/package-template/`:
   ```bash
   cp -r templates/package-template packages/CATEGORY/your-package-name
   cd packages/CATEGORY/your-package-name
   ```

2. Edit the files to match your package
3. Test your package thoroughly

### 2. Test Your Package

Before submitting:
- Verify all metadata is correct
- Test the build script on a clean ZynqOS system
- Check for dependency issues
- Ensure the package installs correctly
- Verify the application runs as expected

### 3. Create a Pull Request

1. Create a new branch:
   ```bash
   git checkout -b add-package-name
   ```

2. Add and commit your changes:
   ```bash
   git add packages/CATEGORY/your-package-name
   git commit -m "Add package: your-package-name"
   ```

3. Push to your fork:
   ```bash
   git push origin add-package-name
   ```

4. Open a Pull Request on GitHub with:
   - Clear title: "Add package: your-package-name"
   - Description of what the package does
   - Testing information
   - Any special notes or dependencies

### 4. Review Process

- Maintainers will review your submission
- Address any feedback or requested changes
- Once approved, your package will be merged

## Package Maintenance

### Updating Packages

When updating a package:
1. Update `pkgver` or `pkgrel` in PKGINFO
2. Update checksums if source changed
3. Test the updated package
4. Submit a PR with clear changelog

### Responsibilities

As a package maintainer, you should:
- Keep packages up to date
- Respond to issues related to your package
- Fix bugs and security issues promptly
- Update dependencies as needed

### Orphaning Packages

If you can no longer maintain a package:
1. Open an issue indicating you want to orphan it
2. Update the PKGINFO to mark it as orphaned
3. Someone else can adopt it

## Best Practices

### Security

- Verify source checksums
- Scan sources for security issues
- Keep dependencies updated
- Report vulnerabilities responsibly

### Quality

- Follow ZynqOS packaging standards
- Write clear documentation
- Include helpful error messages
- Test on multiple architectures if supported

### Documentation

- Write clear README.md files
- Document installation steps
- Include usage examples
- List known issues

## Code of Conduct

### Our Standards

- Be respectful and inclusive
- Accept constructive criticism
- Focus on what's best for the community
- Show empathy towards others

### Unacceptable Behavior

- Harassment or discriminatory language
- Trolling or insulting comments
- Spam or promotional content
- Publishing others' private information

## Questions?

- Open an issue for general questions
- Check existing packages for examples
- Review the documentation in `docs/`

## License

By contributing, you agree that your contributions will be licensed under the same license as the repository (Apache License 2.0), unless the specific package you're contributing has a different license clearly stated.

---

Thank you for contributing to ZynqOS User Repository! Your contributions help make ZynqOS better for everyone.
