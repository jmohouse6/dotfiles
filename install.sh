#!/bin/bash
# ~/dotfiles/install.sh
# Automated dotfiles installation script for fresh Omarchy install

set -e  # Exit on error

echo "========================================="
echo "  Omarchy Dotfiles Installation Script  "
echo "========================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script lives
DOTFILES_DIR="$HOME/dotfiles"

# Backup existing configs
backup_config() {
    local config_path=$1
    if [ -e "$config_path" ]; then
        echo -e "${YELLOW}Backing up existing $config_path${NC}"
        mv "$config_path" "$config_path.backup.$(date +%Y%m%d_%H%M%S)"
    fi
}

# Create symlink
create_symlink() {
    local source=$1
    local target=$2
    
    if [ -e "$target" ] || [ -L "$target" ]; then
        backup_config "$target"
    fi
    
    echo -e "${GREEN}Linking $source -> $target${NC}"
    ln -sf "$source" "$target"
}

echo "Step 1: Creating symlinks for config directories..."

# Symlink Hyprland configs
create_symlink "$DOTFILES_DIR/hypr" "$HOME/.config/hypr"

# Symlink Waybar
create_symlink "$DOTFILES_DIR/waybar" "$HOME/.config/waybar"

# Symlink Omarchy
create_symlink "$DOTFILES_DIR/omarchy" "$HOME/.config/omarchy"

# Symlink Walker
create_symlink "$DOTFILES_DIR/walker" "$HOME/.config/walker"

# Symlink Terminal configs
create_symlink "$DOTFILES_DIR/alacritty" "$HOME/.config/alacritty"
create_symlink "$DOTFILES_DIR/ghostty" "$HOME/.config/ghostty"
create_symlink "$DOTFILES_DIR/kitty" "$HOME/.config/kitty"

# Symlink btop
create_symlink "$DOTFILES_DIR/btop" "$HOME/.config/btop"

# Symlink mako
create_symlink "$DOTFILES_DIR/mako" "$HOME/.config/mako"

echo ""
echo "Step 2: Copying non-symlinkable files..."

# Copy git config (user-specific)
cp "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
echo -e "${GREEN}Copied .gitconfig${NC}"

# Copy shell configs
cp "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
cp "$DOTFILES_DIR/.bash_profile" "$HOME/.bash_profile"
echo -e "${GREEN}Copied shell configurations${NC}"

echo ""
echo "Step 3: Setting up VS Code (optional)..."
if [ -d "$DOTFILES_DIR/vscode" ]; then
    echo "VS Code settings found. Install extensions? (y/n)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
        if command -v code &> /dev/null; then
            while IFS= read -r extension; do
                echo "Installing: $extension"
                code --install-extension "$extension"
            done < "$DOTFILES_DIR/vscode/extensions.txt"
        else
            echo -e "${YELLOW}VS Code not found. Skipping extension installation.${NC}"
        fi
    fi
    
    # Note: Settings should be synced via VS Code Settings Sync
    echo -e "${YELLOW}Remember to enable VS Code Settings Sync!${NC}"
fi

echo ""
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}  Installation complete!${NC}"
echo -e "${GREEN}=========================================${NC}"
echo ""
echo "Next steps:"
echo "  1. Reload your shell: source ~/.bashrc"
echo "  2. Restart Hyprland: Super+Shift+C (or logout/login)"
echo "  3. Verify all applications work correctly"
echo ""
