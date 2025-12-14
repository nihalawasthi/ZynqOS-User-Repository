#!/bin/bash
# Build script for hello-zynq package

set -e

# Source the PKGINFO file
source ./PKGINFO

# Color codes for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() {
    echo -e "${GREEN}==>${NC} $1"
}

warn() {
    echo -e "${YELLOW}==>${NC} $1"
}

# Prepare build environment
prepare() {
    info "Preparing build environment for ${pkgname} ${pkgver}-${pkgrel}"
    mkdir -p build
}

# Build the package
build() {
    info "Building ${pkgname}..."
    
    # Compile the C program
    gcc -o build/hello-zynq hello-zynq.c -Wall -Wextra
    
    info "Build completed successfully"
}

# Package the built files
package() {
    info "Packaging ${pkgname}..."
    
    # Create directory structure
    mkdir -p "${pkgdir}/usr/bin"
    mkdir -p "${pkgdir}/usr/share/doc/${pkgname}"
    
    # Install the binary
    install -Dm755 build/hello-zynq "${pkgdir}/usr/bin/hello-zynq"
    
    # Install documentation
    install -Dm644 README.md "${pkgdir}/usr/share/doc/${pkgname}/README.md"
    
    info "Packaging completed successfully"
}

# Main execution
main() {
    export pkgdir="pkg/${pkgname}"
    mkdir -p "${pkgdir}"
    
    prepare
    build
    package
    
    info "Package ${pkgname} built successfully!"
    info "Package contents in: ${pkgdir}"
    info ""
    info "To test the application, run:"
    info "  ${pkgdir}/usr/bin/hello-zynq"
}

# Run main function
main "$@"
