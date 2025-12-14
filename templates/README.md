# Package Templates

This directory contains templates to help you create new packages for the ZynqOS User Repository.

## Available Templates

### [package-template/](package-template/)
A complete template for creating a new package. This template includes:

- **PKGINFO**: Template with all standard metadata fields
- **build.sh**: Build script template with common functions
- **README.md**: Documentation template

## Using the Template

### Quick Start

```bash
# Copy the template to your new package location
cp -r templates/package-template packages/CATEGORY/your-package-name

# Navigate to your new package
cd packages/CATEGORY/your-package-name

# Customize the files for your package
# 1. Edit PKGINFO with your package metadata
# 2. Edit build.sh with your build commands
# 3. Edit README.md with your documentation
# 4. Add any additional files needed (source code, patches, etc.)
```

### Detailed Steps

1. **Choose a category** for your package from:
   - development
   - games
   - multimedia
   - network
   - productivity
   - system
   - utilities

2. **Copy the template**:
   ```bash
   cp -r templates/package-template packages/CATEGORY/package-name
   ```

3. **Customize PKGINFO**:
   - Update `pkgname` with your package name
   - Set the correct `pkgver` (version number)
   - Write a clear `pkgdesc` (description)
   - Specify supported architectures in `arch`
   - Add the project `url`
   - Set the correct `license`
   - List all `depends` (dependencies)
   - Add `source` URLs
   - Calculate and add `sha256sums`
   - Update `maintainer` with your information

4. **Customize build.sh**:
   - Implement the `prepare()` function if needed
   - Add build commands to `build()`
   - Add installation commands to `package()`
   - Make the script executable: `chmod +x build.sh`

5. **Customize README.md**:
   - Update the package name and description
   - Add installation instructions
   - Document dependencies
   - Provide usage examples
   - Include configuration details
   - List known issues if any
   - Update maintainer information

6. **Add source files** if including them:
   - Place source code in the package directory
   - Or reference external URLs in PKGINFO source array

7. **Test thoroughly**:
   ```bash
   ./build.sh
   ```

## Template Structure

```
package-template/
├── PKGINFO      # Package metadata template
├── build.sh     # Build script template
└── README.md    # Documentation template
```

## Best Practices

- **Don't modify the template directly** - always copy it first
- **Remove example/placeholder content** in your package
- **Test your build script** before submitting
- **Follow naming conventions** (lowercase, hyphens)
- **Document everything** clearly in README.md
- **Include all dependencies** in PKGINFO

## Getting Help

- See [PACKAGE_GUIDELINES.md](../docs/PACKAGE_GUIDELINES.md) for detailed guidelines
- Check [CONTRIBUTING.md](../CONTRIBUTING.md) for contribution process
- Look at [example packages](../packages/) for reference
- Review the [hello-zynq](../packages/utilities/hello-zynq/) example

## Additional Resources

- [Quick Start Guide](../docs/QUICK_START.md) - Getting started with ZUR
- [Package Guidelines](../docs/PACKAGE_GUIDELINES.md) - Detailed package standards
- [Main README](../README.md) - Repository overview

---

Ready to create your first package? Start by copying the template and following the customization steps above!
