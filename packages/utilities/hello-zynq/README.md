# hello-zynq

A simple "Hello World" WebAssembly application demonstrating the ZynqOS User Repository package structure.

## Description

This is an example WASI package that demonstrates how to create and structure WebAssembly packages for the ZynqOS User Repository (ZUR). It's a simple Rust program compiled to WASM that displays a welcome message.

## Installation

Install from ZynqOS App Store:
1. Open ZynqOS
2. Click Start Menu → App Store
3. Browse to Utilities → hello-zynq
4. Click "Install"
5. Find it in your Start Menu

## Usage

Once installed, run from the Start Menu or execute via terminal:

```bash
# Basic usage
hello-zynq

# Expected output:
# Hello from ZynqOS!
# Welcome to the WebAssembly world.
```

## Building from Source

### Prerequisites

- Rust toolchain
- wasm32-wasi target

### Build Instructions

```bash
# Clone the source
git clone https://github.com/yourusername/hello-zynq.git
cd hello-zynq

# Add WASI target if not already added
rustup target add wasm32-wasi

# Build
cargo build --target wasm32-wasi --release

# The WASM binary is at:
# target/wasm32-wasi/release/hello-zynq.wasm
```

### Creating a Release

```bash
# Copy the wasm file
cp target/wasm32-wasi/release/hello-zynq.wasm hello-zynq-v1.0.0.wasm

# Create GitHub release and upload hello-zynq-v1.0.0.wasm
# Update PKGINFO downloadUrl with the release URL
```

## Package Structure

This package follows ZUR standards:

```
packages/utilities/hello-zynq/
├── PKGINFO              # Package metadata
├── README.md            # This file
└── LICENSE              # MIT License
```

The actual `.wasm` binary is hosted on GitHub Releases, referenced in the `PKGINFO` file via the `downloadUrl` field.

## Source Code Example

```rust
// src/main.rs
fn main() {
    println!("Hello from ZynqOS!");
    println!("Welcome to the WebAssembly world.");
    println!();
    println!("This is a WASI application running in your browser.");
    println!("Pretty cool, right?");
}
```

**Cargo.toml**:
```toml
[package]
name = "hello-zynq"
version = "1.0.0"
edition = "2021"

[dependencies]
# No dependencies needed for this simple example
```

## Features

- ✅ Lightweight (~50 KB compiled)
- ✅ Pure WASI - no external dependencies
- ✅ Runs in browser sandbox
- ✅ Instant startup
- ✅ Example of basic WASI I/O

## Technical Details

- **Type**: WASI (WebAssembly System Interface)
- **Language**: Rust
- **Size**: ~50 KB
- **Startup**: <10ms
- **Permissions**: None required (stdio only)

## Use as a Template

This package serves as a template for creating WASI packages:

1. Copy the structure
2. Replace source code with your application
3. Update PKGINFO with your details
4. Build and release
5. Submit to ZUR

## Contributing

Found an issue or want to improve this example? Contributions welcome!

1. Fork the repository
2. Make your changes
3. Submit a Pull Request

## Resources

- [ZUR Package Guidelines](https://github.com/nihalawasthi/ZynqOS-User-Repository/blob/main/docs/PACKAGE_GUIDELINES.md)
- [WASI Documentation](https://wasi.dev/)
- [Rust WASM Book](https://rustwasm.github.io/docs/book/)
- [wasm-pack Guide](https://rustwasm.github.io/docs/wasm-pack/)

## License

MIT License - see LICENSE file for details.

## Author

**Maintainer**: ZynqOS Team  
**Repository**: [ZynqOS-User-Repository](https://github.com/nihalawasthi/ZynqOS-User-Repository)

---

**Note**: This is an example package to demonstrate ZUR package structure. Actual binary not included in repository - would be hosted on GitHub Releases in production use.
