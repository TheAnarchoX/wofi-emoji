# wofi-emoji 🥞

Simple emoji selector for Wayland using [wofi](https://cloudninja.pw/docs/wofi.html) that relies on [wtype](https://github.com/atx/wtype) and [wl-clipboard](https://github.com/bugaevc/wl-clipboard).

![Screenshot of wofi-emoji in action](https://i.imgur.com/8XiUoh6.png)

## Installation

### Prerequisites

Make sure you have the required dependencies installed:
- `wofi` - The launcher/menu program
- `wtype` - Tool to simulate keyboard input
- `wl-clipboard` - Wayland clipboard utilities

### Package Managers

**Arch Linux (AUR):**
```bash
yay -S wofi-emoji
# or
paru -S wofi-emoji
```

### Method 1: One-liner install script (Recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/TheAnarchoX/wofi-emoji/master/install.sh | bash
```

This will:
- Download the latest version of wofi-emoji
- Install it to `~/.local/bin`
- Make it executable
- Check if `~/.local/bin` is in your PATH

### Method 2: Using Make

```bash
# Clone the repository
git clone https://github.com/TheAnarchoX/wofi-emoji.git
cd wofi-emoji

# Install to ~/.local/bin
make install

# Or install system-wide to /usr/local/bin
sudo make install-system

# Or install to a custom location
sudo make install-system PREFIX=/usr
```

### Method 3: Manual installation

```bash
# Download the script
curl -O https://raw.githubusercontent.com/TheAnarchoX/wofi-emoji/master/wofi-emoji

# Make it executable
chmod +x wofi-emoji

# Move to a directory in your PATH
mv wofi-emoji ~/.local/bin/
```

### Adding ~/.local/bin to PATH

If `~/.local/bin` is not in your PATH, add this line to your shell configuration file:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

- **Bash**: Add to `~/.bashrc` or `~/.bash_profile`
- **Zsh**: Add to `~/.zshrc`
- **Fish**: Add to `~/.config/fish/config.fish`

## Usage

### With Sway

Add a shortcut key in your [sway](https://swaywm.org/) config:

```
# ~/.config/sway/config

bindsym Mod4+e exec wofi-emoji
```

### With other window managers

You can bind `wofi-emoji` to any key combination in your window manager configuration. The exact syntax will depend on your window manager.

### From command line

Simply run:
```bash
wofi-emoji
```

## Uninstall

### If installed via script or manual method
```bash
rm ~/.local/bin/wofi-emoji
```

### If installed via Make
```bash
# From the project directory
make uninstall

# Or for system-wide installation
sudo make uninstall-system
```

## Development

### Building from source

If you want to build the emoji data yourself:

```bash
git clone https://github.com/TheAnarchoX/wofi-emoji.git
cd wofi-emoji
make build  # or ./build.sh
```

This will fetch the latest emoji data and update the script.

## Credits

* Original author: [dln](https://github.com/dln)
* Current maintainer: [Zeioth](https://github.com/Zeioth)
* This fork: [TheAnarchoX](https://github.com/TheAnarchoX)

## 🌟 Support the project
Star this repository and vote the [AUR package](https://aur.archlinux.org/packages/wofi-emoji) to increase the visibility of the project.

## Roadmap
This project is community driven. If you have a proposal, send a PR and I will review it.
