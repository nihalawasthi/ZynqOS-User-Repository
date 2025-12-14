# Package Guidelines

This document provides detailed guidelines for creating and maintaining packages in the ZynqOS User Repository.

## Table of Contents

- [Package Naming](#package-naming)
- [Directory Structure](#directory-structure)
- [PKGINFO Specification](#pkginfo-specification)
- [Build Script Requirements](#build-script-requirements)
- [Testing](#testing)
- [Security](#security)
- [Best Practices](#best-practices)

## Package Naming

### General Rules

1. **Lowercase Only**: Package names must be all lowercase
2. **Hyphens**: Use hyphens to separate words (e.g., `my-package`)
3. **No Special Characters**: Only alphanumeric characters and hyphens
4. **Descriptive**: Name should clearly indicate what the package does
5. **Unique**: Check that the name doesn't conflict with existing packages

### Naming Conventions

- **Libraries**: Use `lib` prefix (e.g., `libexample`)
- **Python packages**: Use `python-` prefix (e.g., `python-requests`)
- **GUI applications**: Use descriptive name (e.g., `text-editor`)
- **CLI tools**: Use command name (e.g., `file-converter`)

### Examples

✅ Good names:
- `web-browser`
- `python-numpy`
- `libpng`
- `video-player`

❌ Bad names:
- `WebBrowser` (not lowercase)
- `my_package` (uses underscore)
- `app123` (not descriptive)
- `super@tool` (special character)

## Directory Structure

### Required Structure

```
packages/CATEGORY/package-name/
├── PKGINFO              # Package metadata
├── build.sh             # Build script
└── README.md            # Documentation
```

### Optional Files

```
packages/CATEGORY/package-name/
├── PKGINFO
├── build.sh
├── README.md
├── package-name.patch   # Patches
├── package-name.service # Systemd service files
├── LICENSE              # License text if different from source
└── files/               # Additional files
    ├── config.conf
    └── icons/
```

## PKGINFO Specification

### Required Fields

```bash
pkgname="package-name"      # Package name
pkgver="1.0.0"              # Version number
pkgrel="1"                  # Release number
pkgdesc="Description"       # Short description
arch=('arch1' 'arch2')      # Supported architectures
url="https://..."           # Project homepage
license=('LICENSE')         # License
maintainer="Name <email>"   # Package maintainer
```

### Optional Fields

```bash
depends=('dep1' 'dep2')     # Runtime dependencies
makedepends=('tool1')       # Build dependencies
optdepends=('opt1: desc')   # Optional dependencies
provides=('provides1')      # Virtual packages provided
conflicts=('conflict1')     # Conflicting packages
replaces=('old-package')    # Packages replaced by this one
source=('url1' 'file1')     # Source files
sha256sums=('hash1')        # Source checksums
backup=('etc/config')       # Config files to backup
notes="Important info"      # Additional notes
```

### Version Numbering

Follow [Semantic Versioning](https://semver.org/):
- **MAJOR.MINOR.PATCH** (e.g., 1.2.3)
- MAJOR: Breaking changes
- MINOR: New features (backward compatible)
- PATCH: Bug fixes

### Release Number (pkgrel)

- Start at `1` for new package versions
- Increment when rebuilding same version
- Reset to `1` when `pkgver` changes

Examples:
- `1.0.0-1` - Initial release
- `1.0.0-2` - Rebuild with packaging fixes
- `1.0.1-1` - New upstream version

## Build Script Requirements

### Basic Structure

```bash
#!/bin/bash
set -e  # Exit on error

source ./PKGINFO

prepare() {
    # Download and prepare sources
}

build() {
    # Compile the software
}

check() {
    # Run tests (optional)
}

package() {
    # Install files to ${pkgdir}
}

# Main execution
main() {
    export pkgdir="pkg/${pkgname}"
    prepare
    build
    package
}

main "$@"
```

### Important Rules

1. **Error Handling**: Use `set -e` to exit on errors
2. **Source PKGINFO**: Load package metadata
3. **Use $pkgdir**: Install to package directory, not system
4. **Permissions**: Ensure script is executable
5. **Output**: Provide clear progress messages

### Standard Directories

```bash
# Binary executables
"${pkgdir}/usr/bin"

# Libraries
"${pkgdir}/usr/lib"

# Headers
"${pkgdir}/usr/include"

# Documentation
"${pkgdir}/usr/share/doc/${pkgname}"

# Man pages
"${pkgdir}/usr/share/man/man1"

# Desktop files
"${pkgdir}/usr/share/applications"

# Icons
"${pkgdir}/usr/share/icons"

# Configuration
"${pkgdir}/etc/${pkgname}"
```

### Common Build Patterns

#### Makefile-based

```bash
build() {
    make PREFIX=/usr
}

package() {
    make PREFIX=/usr DESTDIR="${pkgdir}" install
}
```

#### Autotools

```bash
build() {
    ./configure --prefix=/usr
    make
}

package() {
    make DESTDIR="${pkgdir}" install
}
```

#### CMake

```bash
build() {
    cmake -B build \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_BUILD_TYPE=Release
    cmake --build build
}

package() {
    DESTDIR="${pkgdir}" cmake --install build
}
```

#### Python

```bash
build() {
    python setup.py build
}

package() {
    python setup.py install --root="${pkgdir}" --optimize=1
}
```

## Testing

### Pre-submission Testing

1. **Syntax Check**: Verify PKGINFO syntax
2. **Build Test**: Run build script in clean environment
3. **Installation Test**: Verify files install correctly
4. **Runtime Test**: Test the application works
5. **Dependency Check**: Verify all dependencies are listed

### Test Checklist

- [ ] Package builds without errors
- [ ] All dependencies are available
- [ ] Files install to correct locations
- [ ] Application runs correctly
- [ ] No conflicts with existing packages
- [ ] Documentation is complete
- [ ] Checksums are correct

## Security

### Source Verification

1. **Use HTTPS**: Always use HTTPS URLs for sources
2. **Verify Checksums**: Provide SHA256 checksums
3. **GPG Signatures**: Include GPG verification if available
4. **Trusted Sources**: Download from official sources only

### Code Review

1. **Inspect Sources**: Review source code for issues
2. **Known Vulnerabilities**: Check CVE databases
3. **Minimal Permissions**: Don't request unnecessary permissions
4. **Secure Defaults**: Use secure configuration defaults

### Update Policy

1. **Security Updates**: Apply security patches promptly
2. **Monitor Upstream**: Watch for security advisories
3. **Notify Users**: Document security updates in changelog

## Best Practices

### Documentation

- Write clear, concise README
- Include usage examples
- Document configuration options
- List known issues
- Provide troubleshooting guide

### Code Quality

- Follow shell scripting best practices
- Use shellcheck for linting
- Add comments for complex logic
- Handle edge cases
- Provide meaningful error messages

### Maintenance

- Respond to issues promptly
- Keep package updated
- Test before pushing updates
- Document changes in changelog
- Monitor upstream releases

### Performance

- Minimize build time
- Reduce package size
- Avoid unnecessary dependencies
- Use parallel builds when possible

### Compatibility

- Test on multiple architectures
- Consider backward compatibility
- Document architecture-specific issues
- Provide alternatives when needed

## Common Mistakes

### Avoid These

❌ Installing directly to system during build
❌ Hardcoding paths without PREFIX
❌ Missing or incorrect dependencies
❌ No error handling in build script
❌ Incomplete or missing documentation
❌ Not testing before submission
❌ Ignoring security best practices

### Do These Instead

✅ Install to ${pkgdir} directory
✅ Use configurable PREFIX
✅ List all dependencies explicitly
✅ Use `set -e` and check return codes
✅ Complete README with examples
✅ Test thoroughly in clean environment
✅ Verify sources and use checksums

## Getting Help

- Review existing packages for examples
- Ask in issues for clarification
- Consult the CONTRIBUTING.md file
- Check documentation in `docs/`

## References

- [Semantic Versioning](https://semver.org/)
- [Arch Linux PKGBUILD](https://wiki.archlinux.org/title/PKGBUILD)
- [Filesystem Hierarchy Standard](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html)
- [ShellCheck](https://www.shellcheck.net/)

---

These guidelines help maintain consistency and quality across all packages in the ZynqOS User Repository. Thank you for following them!
