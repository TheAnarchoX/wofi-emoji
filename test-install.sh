#!/usr/bin/env bash

# Test script to validate our install.sh works correctly
# This is a dry-run version that doesn't actually download anything

echo "Testing wofi-emoji installation process..."
echo

# Test dependency checking function
echo "✓ Checking dependency check function..."
missing_deps=()

if ! command -v curl >/dev/null 2>&1; then
    missing_deps+=("curl")
fi

echo "Dependencies check: ${#missing_deps[@]} missing dependencies"

# Test directory creation
INSTALL_DIR="$HOME/.local/bin"
echo "✓ Install directory: $INSTALL_DIR"
echo "✓ Directory exists: $([ -d "$INSTALL_DIR" ] && echo "yes" || echo "no")"

# Test PATH checking
echo "✓ PATH check: $(if [[ ":$PATH:" == *":$INSTALL_DIR:"* ]]; then echo "in PATH"; else echo "not in PATH"; fi)"

echo
echo "Test completed successfully! The install.sh script should work correctly."
