# Quick Start Guide

Welcome to the ZynqOS User Repository (ZUR)! This guide will help you get started with using and contributing packages.

## For Users

### Finding Packages

1. **Browse Categories**: Navigate to the `packages/` directory
2. **Choose a Category**: Select from development, games, multimedia, network, productivity, system, or utilities
3. **Find a Package**: Look through the available packages in that category

### Installing a Package

```bash
# Clone the repository
git clone https://github.com/nihalawasthi/ZynqOS-User-Repository.git
cd ZynqOS-User-Repository

# Navigate to the package you want
cd packages/utilities/hello-zynq

# Make the build script executable
chmod +x build.sh

# Build and install the package
./build.sh
```

### Understanding Package Files

Each package contains:
- **PKGINFO**: Metadata about the package (version, dependencies, etc.)
- **build.sh**: Script that builds and packages the software
- **README.md**: Documentation and usage instructions

## For Contributors

### Creating Your First Package

#### Step 1: Set Up Your Environment

```bash
# Fork the repository on GitHub, then clone your fork
git clone https://github.com/YOUR_USERNAME/ZynqOS-User-Repository.git
cd ZynqOS-User-Repository

# Create a new branch
git checkout -b add-my-package
```

#### Step 2: Use the Template

```bash
# Copy the template to your package location
cp -r templates/package-template packages/CATEGORY/my-package
cd packages/CATEGORY/my-package
```

#### Step 3: Customize Your Package

1. **Edit PKGINFO**:
   ```bash
   # Update package metadata
   pkgname=my-package
   pkgver=1.0.0
   pkgdesc="Description of my package"
   # ... update other fields
   ```

2. **Edit build.sh**:
   - Add your build commands to the `build()` function
   - Add installation commands to the `package()` function
   - Make it executable: `chmod +x build.sh`

3. **Edit README.md**:
   - Describe your package
   - Add installation and usage instructions
   - Document dependencies and known issues

#### Step 4: Test Your Package

```bash
# Test the build script
./build.sh

# Verify it created the package correctly
ls -la pkg/my-package/

# Test the installed application
./pkg/my-package/usr/bin/my-app
```

#### Step 5: Submit Your Package

```bash
# Add your package
git add packages/CATEGORY/my-package

# Commit with a clear message
git commit -m "Add package: my-package"

# Push to your fork
git push origin add-my-package
```

Then open a Pull Request on GitHub!

### Package Categories

Choose the right category:

| Category | Use For |
|----------|---------|
| **development** | Compilers, IDEs, debuggers, version control |
| **games** | Games and entertainment |
| **multimedia** | Audio, video, graphics applications |
| **network** | Browsers, network tools, communication |
| **productivity** | Office apps, note-taking, documents |
| **system** | System utilities, file managers, monitors |
| **utilities** | General utilities that don't fit elsewhere |

### Quick Tips

#### Do's ✅
- Follow the package template structure
- Use descriptive package names
- Test thoroughly before submitting
- Include all dependencies in PKGINFO
- Write clear documentation
- Use semantic versioning

#### Don'ts ❌
- Don't use uppercase in package names
- Don't install directly to system during build
- Don't forget to make build.sh executable
- Don't skip the README documentation
- Don't submit untested packages

## Common Tasks

### Updating a Package

```bash
# Navigate to the package
cd packages/CATEGORY/package-name

# Update PKGINFO with new version
# Edit: pkgver=1.1.0

# Update build.sh if needed
# Test the new version
./build.sh

# Commit and submit PR
git commit -am "Update package-name to version 1.1.0"
git push origin update-package-name
```

### Reporting Issues

Found a problem with a package?

1. Go to the [Issues page](https://github.com/nihalawasthi/ZynqOS-User-Repository/issues)
2. Click "New Issue"
3. Choose the appropriate template (Bug Report, Package Request, etc.)
4. Fill in the details
5. Submit

### Getting Help

- 📖 Read the [CONTRIBUTING.md](../CONTRIBUTING.md) for detailed guidelines
- 📚 Check [PACKAGE_GUIDELINES.md](PACKAGE_GUIDELINES.md) for package standards
- 👀 Look at existing packages for examples (especially `packages/utilities/hello-zynq`)
- 💬 Open an issue if you have questions

## Example: Installing hello-zynq

Let's install the example package to see how it works:

```bash
# Navigate to the example package
cd packages/utilities/hello-zynq

# Build it
chmod +x build.sh
./build.sh

# Run it
./pkg/hello-zynq/usr/bin/hello-zynq

# Try with a name
./pkg/hello-zynq/usr/bin/hello-zynq YourName
```

Expected output:
```
╔════════════════════════════════════════╗
║     Welcome to ZynqOS!                 ║
║     Hello from ZynqOS User Repository  ║
╚════════════════════════════════════════╝

Current time: [current time]

This is an example package from ZUR (ZynqOS User Repository)
Similar to AUR (Arch User Repository)

Hello, YourName!
```

## Next Steps

- Explore existing packages in `packages/`
- Try building the example package
- Read the full documentation in `docs/`
- Create your first package!
- Join the community and contribute

## Resources

- [Main README](../README.md) - Repository overview
- [CONTRIBUTING.md](../CONTRIBUTING.md) - Contribution guidelines
- [PACKAGE_GUIDELINES.md](PACKAGE_GUIDELINES.md) - Package standards
- [Package Template](../templates/package-template/) - Starting point for new packages

Happy packaging! 🚀
