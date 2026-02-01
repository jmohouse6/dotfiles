#!/bin/bash
# Universal Linux Development Environment Setup
# Author: Jason Moorhouse (jmohouse6)
# For: Omarchy + Dropbox + GitHub workflow

set -e

echo "🚀 Starting universal development environment setup..."

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Directories
DOTFILES_DIR="$HOME/dev/dotfiles"
CONFIG_DIR="$HOME/.config"

# Check if on Linux
if [[ "$OSTYPE" != "linux-gnu"* ]]; then
    echo -e "${RED}❌ This script is for Linux only${NC}"
    exit 1
fi

# Check if dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "${RED}❌ Dotfiles directory not found at $DOTFILES_DIR${NC}"
    echo -e "${YELLOW}Please clone the repository first:${NC}"
    echo "  git clone https://github.com/jmohouse6/dotfiles.git ~/dev/dotfiles"
    exit 1
fi

# Create base directory structure
echo -e "${GREEN}📁 Creating directory structure...${NC}"
mkdir -p ~/dev
mkdir -p ~/local/{build/{node-caches,cargo-target,docker-builds},data/{ml-datasets,databases,archives},vms/{docker,virtualbox},scratch,cache,downloads/{sorted/{docs,media,software,archives},archive}}
mkdir -p ~/Dropbox/{obsidian,personal,projects,config-backups/{dotfiles,app-settings,scripts}}
mkdir -p ~/.local/{share,state,bin}

# Set permissions
chmod 700 ~/local
chmod 755 ~/dev

# Backup existing configs
echo -e "${YELLOW}💾 Backing up existing configs...${NC}"
BACKUP_DIR="$HOME/Dropbox/config-backups/dotfiles/$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Function to create symlinks
link_config() {
    local source="$DOTFILES_DIR/$1"
    local target="$CONFIG_DIR/$2"
    
    if [ ! -e "$source" ]; then
        echo -e "  ${YELLOW}⚠ Source not found: $1 (skipping)${NC}"
        return
    fi
    
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "  📦 Backing up existing $2..."
        cp -r "$target" "$BACKUP_DIR/"
        rm -rf "$target"
    fi
    
    if [ -L "$target" ]; then
        rm "$target"
    fi
    
    ln -sf "$source" "$target"
    echo -e "  ${GREEN}✓${NC} Linked $2"
}

# Symlink configs
echo -e "${GREEN}🔗 Creating symlinks...${NC}"

link_config "hypr" "hypr"
link_config "waybar" "waybar"
link_config "walker" "walker"
link_config "alacritty" "alacritty"
link_config "mako" "mako"
link_config "omarchy" "omarchy"

# Handle VSCode separately (nested directory)
if [ -d "$DOTFILES_DIR/vscode" ]; then
    mkdir -p "$CONFIG_DIR/Code"
    if [ -e "$CONFIG_DIR/Code/User" ] && [ ! -L "$CONFIG_DIR/Code/User" ]; then
        echo "  📦 Backing up existing VSCode User settings..."
        cp -r "$CONFIG_DIR/Code/User" "$BACKUP_DIR/"
        rm -rf "$CONFIG_DIR/Code/User"
    fi
    if [ -L "$CONFIG_DIR/Code/User" ]; then
        rm "$CONFIG_DIR/Code/User"
    fi
    ln -sf "$DOTFILES_DIR/vscode" "$CONFIG_DIR/Code/User"
    echo -e "  ${GREEN}✓${NC} Linked Code/User"
fi

# Symlink shell configs
echo -e "${GREEN}🐚 Linking shell configs...${NC}"
if [ -f ~/.bashrc ] && [ ! -L ~/.bashrc ]; then
    cp ~/.bashrc "$BACKUP_DIR/.bashrc"
    rm ~/.bashrc
fi
ln -sf "$DOTFILES_DIR/.bashrc" ~/.bashrc
echo -e "  ${GREEN}✓${NC} Linked .bashrc"

if [ -f "$DOTFILES_DIR/.bash_profile" ]; then
    if [ -f ~/.bash_profile ] && [ ! -L ~/.bash_profile ]; then
        cp ~/.bash_profile "$BACKUP_DIR/.bash_profile"
        rm ~/.bash_profile
    fi
    ln -sf "$DOTFILES_DIR/.bash_profile" ~/.bash_profile
    echo -e "  ${GREEN}✓${NC} Linked .bash_profile"
fi

# Symlink .gitconfig if present
if [ -f "$DOTFILES_DIR/.gitconfig" ]; then
    if [ -f ~/.gitconfig ] && [ ! -L ~/.gitconfig ]; then
        cp ~/.gitconfig "$BACKUP_DIR/.gitconfig"
        rm ~/.gitconfig
    fi
    ln -sf "$DOTFILES_DIR/.gitconfig" ~/.gitconfig
    echo -e "  ${GREEN}✓${NC} Linked .gitconfig"
fi

echo ""
echo -e "${GREEN}✅ Setup complete!${NC}"
echo ""
echo -e "${BLUE}📝 Summary:${NC}"
echo "  • Directory structure created"
echo "  • Config symlinks created in ~/.config/"
echo "  • Shell configs linked"
echo "  • Backups saved to: $BACKUP_DIR"
echo ""
echo -e "${YELLOW}📋 Next steps:${NC}"
echo "  1. Reload shell configuration:"
echo "     ${GREEN}source ~/.bashrc${NC}"
echo ""
echo "  2. Verify symlinks:"
echo "     ${GREEN}ls -la ~/.config/hypr${NC}"
echo ""
echo "  3. Test Hyprland configuration:"
echo "     ${GREEN}hyprctl reload${NC}"
echo ""
echo -e "${BLUE}🌟 Your universal development environment is ready!${NC}"
