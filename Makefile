# Makefile for wofi-emoji

SCRIPT_NAME = wofi-emoji
INSTALL_DIR = $(HOME)/.local/bin
BUILD_SCRIPT = build.sh

# Default target
.PHONY: all
all: build

# Build the emoji data
.PHONY: build
build:
	@echo "Building $(SCRIPT_NAME)..."
	@./$(BUILD_SCRIPT)
	@echo "Build complete!"

# Install the script to ~/.local/bin
.PHONY: install
install: $(SCRIPT_NAME)
	@echo "Installing $(SCRIPT_NAME) to $(INSTALL_DIR)..."
	@mkdir -p $(INSTALL_DIR)
	@cp $(SCRIPT_NAME) $(INSTALL_DIR)/$(SCRIPT_NAME)
	@chmod +x $(INSTALL_DIR)/$(SCRIPT_NAME)
	@echo "Successfully installed $(SCRIPT_NAME) to $(INSTALL_DIR)"
	@echo ""
	@if echo "$$PATH" | grep -q "$(INSTALL_DIR)"; then \
		echo "✓ $(INSTALL_DIR) is already in your PATH"; \
	else \
		echo "⚠ $(INSTALL_DIR) is not in your PATH"; \
		echo "  Add the following line to your shell configuration:"; \
		echo "  export PATH=\"$$HOME/.local/bin:$$PATH\""; \
	fi

# Install to a custom directory (make install PREFIX=/usr/local)
.PHONY: install-system
install-system: $(SCRIPT_NAME)
	@INSTALL_DIR_CUSTOM=$${PREFIX:-/usr/local}/bin; \
	echo "Installing $(SCRIPT_NAME) to $$INSTALL_DIR_CUSTOM..."; \
	mkdir -p $$INSTALL_DIR_CUSTOM; \
	cp $(SCRIPT_NAME) $$INSTALL_DIR_CUSTOM/$(SCRIPT_NAME); \
	chmod +x $$INSTALL_DIR_CUSTOM/$(SCRIPT_NAME); \
	echo "Successfully installed $(SCRIPT_NAME) to $$INSTALL_DIR_CUSTOM"

# Uninstall from ~/.local/bin
.PHONY: uninstall
uninstall:
	@echo "Uninstalling $(SCRIPT_NAME) from $(INSTALL_DIR)..."
	@rm -f $(INSTALL_DIR)/$(SCRIPT_NAME)
	@echo "$(SCRIPT_NAME) uninstalled"

# Uninstall from custom directory
.PHONY: uninstall-system
uninstall-system:
	@INSTALL_DIR_CUSTOM=$${PREFIX:-/usr/local}/bin; \
	echo "Uninstalling $(SCRIPT_NAME) from $$INSTALL_DIR_CUSTOM..."; \
	rm -f $$INSTALL_DIR_CUSTOM/$(SCRIPT_NAME); \
	echo "$(SCRIPT_NAME) uninstalled from $$INSTALL_DIR_CUSTOM"

# Clean build artifacts (if any)
.PHONY: clean
clean:
	@echo "Nothing to clean for this project"

# Check if dependencies are installed
.PHONY: check-deps
check-deps:
	@echo "Checking dependencies..."
	@command -v wofi >/dev/null 2>&1 || (echo "✗ wofi not found" && exit 1)
	@command -v wtype >/dev/null 2>&1 || (echo "✗ wtype not found" && exit 1)
	@command -v wl-copy >/dev/null 2>&1 || (echo "✗ wl-copy not found" && exit 1)
	@command -v curl >/dev/null 2>&1 || (echo "✗ curl not found (needed for building)" && exit 1)
	@command -v jq >/dev/null 2>&1 || (echo "✗ jq not found (needed for building)" && exit 1)
	@echo "✓ All dependencies are installed"

# Display help
.PHONY: help
help:
	@echo "wofi-emoji Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  build           Build the emoji data (default)"
	@echo "  install         Install to ~/.local/bin"
	@echo "  install-system  Install to /usr/local/bin (or PREFIX/bin)"
	@echo "  uninstall       Remove from ~/.local/bin"
	@echo "  uninstall-system Remove from /usr/local/bin (or PREFIX/bin)"
	@echo "  check-deps      Check if all dependencies are installed"
	@echo "  clean           Clean build artifacts"
	@echo "  help            Show this help message"
	@echo ""
	@echo "Examples:"
	@echo "  make install              # Install to ~/.local/bin"
	@echo "  make install-system       # Install to /usr/local/bin"
	@echo "  sudo make install-system PREFIX=/usr  # Install to /usr/bin"
