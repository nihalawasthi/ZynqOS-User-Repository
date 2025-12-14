# Packages Directory

This directory contains all user-contributed packages organized by category.

## Categories

### [development/](development/)
Development tools, IDEs, compilers, debuggers, and version control systems.

Examples: text editors, compilers, debuggers, build tools, version control clients

### [games/](games/)
Games and entertainment applications.

Examples: arcade games, puzzle games, board games, emulators

### [multimedia/](multimedia/)
Audio, video, and graphics applications.

Examples: media players, audio/video editors, image viewers, graphics tools

### [network/](network/)
Network utilities, web browsers, and communication tools.

Examples: web browsers, download managers, FTP clients, network monitors, chat clients

### [productivity/](productivity/)
Office and productivity applications.

Examples: office suites, note-taking apps, document editors, PDF readers, calculators

### [system/](system/)
System utilities, monitoring tools, and administrative applications.

Examples: file managers, system monitors, backup tools, disk utilities

### [utilities/](utilities/)
General-purpose utilities that don't fit other categories.

Examples: archive managers, text processors, conversion tools, general utilities

## Adding a Package

1. Choose the appropriate category for your package
2. Create a directory with your package name (lowercase, hyphen-separated)
3. Follow the structure in [templates/package-template/](../templates/package-template/)
4. See [CONTRIBUTING.md](../CONTRIBUTING.md) for detailed guidelines

## Package Structure

Each package directory should contain:

```
package-name/
├── PKGINFO      # Required: Package metadata
├── build.sh     # Required: Build/installation script
├── README.md    # Required: Package documentation
└── ...          # Additional files as needed
```

## Browse Packages

Explore the categories to discover available packages or to see examples for your own contributions.
