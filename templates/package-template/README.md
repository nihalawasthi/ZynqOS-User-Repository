# Package Name

Brief description of what your WASM package does.

## Features

- Feature 1
- Feature 2
- Feature 3

## Installation

Install from ZynqOS App Store:
1. Open ZynqOS
2. Click App Store
3. Find your package
4. Click Install

## Usage

1. Open from Start Menu
2. Basic instructions...

## Building from Source

```bash
# For wasm-bindgen packages
wasm-pack build --target web --release
cd pkg && zip -r ../package-name-v1.0.0.zip *

# For WASI packages
cargo build --target wasm32-wasi --release
```

## License

MIT
