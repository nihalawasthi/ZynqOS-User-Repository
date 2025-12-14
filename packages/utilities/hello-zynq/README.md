# hello-zynq

A simple "Hello World" application demonstrating the ZynqOS User Repository package structure.

## Description

This is an example package that demonstrates how to create and structure packages for the ZynqOS User Repository (ZUR). It's a simple C program that displays a welcome message and the current time.

## Installation

### Building from Source

```bash
# Navigate to the package directory
cd packages/utilities/hello-zynq

# Make the build script executable
chmod +x build.sh

# Run the build script
./build.sh
```

### Testing

After building, test the application:

```bash
# Run the built binary
./pkg/hello-zynq/usr/bin/hello-zynq

# Run with a name argument
./pkg/hello-zynq/usr/bin/hello-zynq YourName
```

## Dependencies

This package has no runtime dependencies. It only requires:
- GCC compiler (build-time only)
- Standard C library

## Usage

```bash
hello-zynq [name]
```

### Examples

```bash
# Basic usage
hello-zynq

# Greet a specific person
hello-zynq Alice
```

### Output

```
╔════════════════════════════════════════╗
║     Welcome to ZynqOS!                 ║
║     Hello from ZynqOS User Repository  ║
╚════════════════════════════════════════╝

Current time: Sat Dec 14 12:00:00 2024

This is an example package from ZUR (ZynqOS User Repository)
Similar to AUR (Arch User Repository)
```

## Purpose

This package serves as:
1. **Example**: Demonstrates proper package structure
2. **Template**: Shows how to write PKGINFO and build.sh
3. **Test**: Validates the ZUR infrastructure works correctly

## Package Structure

```
hello-zynq/
├── PKGINFO         # Package metadata
├── build.sh        # Build script
├── README.md       # This file
└── hello-zynq.c    # Source code
```

## Contributing

This is an example package. For guidelines on creating your own packages, see:
- [CONTRIBUTING.md](../../../CONTRIBUTING.md)
- [PACKAGE_GUIDELINES.md](../../../docs/PACKAGE_GUIDELINES.md)

## License

This package is released under the MIT License.

## Maintainer

- Organization: ZynqOS Community
- Email: community@zynqos.org

## Links

- Repository: https://github.com/nihalawasthi/ZynqOS-User-Repository
- Documentation: See docs/ directory in the repository root

## Changelog

### Version 1.0.0 (2024)
- Initial release
- Simple hello world functionality
- Demonstrates ZUR package structure
