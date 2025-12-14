#!/bin/bash
# Build script for package
# This script handles building and packaging

set -e  # Exit on error

# Source the PKGINFO file
source ./PKGINFO

# Color output for better readability
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info() {
    echo -e "${GREEN}==>${NC} $1"
}

warn() {
    echo -e "${YELLOW}==>${NC} $1"
}

error() {
    echo -e "${RED}==>${NC} $1"
    exit 1
}

# Prepare build environment
prepare() {
    info "Preparing build environment for ${pkgname} ${pkgver}-${pkgrel}"
    
    # Create build directory
    mkdir -p build
    cd build
    
    # Download and extract sources
    # Implement your download logic here
    info "Downloading sources..."
}

# Build the package
build() {
    info "Building ${pkgname}..."
    
    # Add your build commands here
    # Example:
    # ./configure --prefix=/usr
    # make
    
    warn "Build function not implemented - add your build commands"
}

# Run tests (optional)
check() {
    info "Running tests..."
    
    # Add test commands here
    # Example:
    # make test
}

# Package the built files
package() {
    info "Packaging ${pkgname}..."
    
    # Create package directory structure
    mkdir -p "${pkgdir}/usr/bin"
    mkdir -p "${pkgdir}/usr/share/doc/${pkgname}"
    
    # Install files to package directory
    # Example:
    # make DESTDIR="${pkgdir}" install
    
    # Install documentation
    # cp README.md "${pkgdir}/usr/share/doc/${pkgname}/"
    
    warn "Package function not implemented - add your installation commands"
}

# Cleanup function
cleanup() {
    info "Cleaning up..."
    cd ..
    rm -rf build
}

# Main execution
main() {
    # Set package directory
    export pkgdir="pkg/${pkgname}"
    mkdir -p "${pkgdir}"
    
    # Execute build phases
    prepare
    build
    # check  # Uncomment to run tests
    package
    
    info "Package ${pkgname} built successfully!"
    info "Package contents in: ${pkgdir}"
}

# Trap errors and cleanup
trap cleanup EXIT

# Run main function
main "$@"
