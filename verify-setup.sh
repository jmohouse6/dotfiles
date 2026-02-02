#!/bin/bash
# Quick verification script to check system setup

echo "========================================="
echo "  System Setup Verification"
echo "========================================="
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

check_item() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $2"
    else
        echo -e "${RED}✗${NC} $2"
    fi
}

# Check symlinks
echo "Checking configuration symlinks..."
[ -L ~/.config/hypr ] && [ -d ~/.config/hypr ]; check_item $? "Hyprland config symlinked"
[ -L ~/.config/waybar ] && [ -d ~/.config/waybar ]; check_item $? "Waybar config symlinked"
[ -L ~/.config/omarchy ] && [ -d ~/.config/omarchy ]; check_item $? "Omarchy config symlinked"
[ -L ~/.config/walker ] && [ -d ~/.config/walker ]; check_item $? "Walker config symlinked"

echo ""
echo "Checking directories..."
[ -d ~/Projects ]; check_item $? "Projects directory exists"
[ -d ~/dotfiles ]; check_item $? "Dotfiles directory exists"
[ -d ~/Dropbox/Configs-Backup ]; check_item $? "Configs-Backup directory exists"

echo ""
echo "Checking repositories..."
[ -d ~/Projects/moorhouse-portal/.git ]; check_item $? "moorhouse-portal in Projects"
[ -d ~/dotfiles/.git ]; check_item $? "Dotfiles is a git repository"

echo ""
echo "Checking backup..."
[ -L ~/Dropbox/Configs-Backup/LATEST ]; check_item $? "Latest backup link exists"
[ -f ~/Dropbox/Configs-Backup/LATEST/MANIFEST.txt ]; check_item $? "Backup manifest exists"

echo ""
echo "Checking scripts..."
[ -x ~/dotfiles/install.sh ]; check_item $? "install.sh is executable"
[ -x ~/dotfiles/backup-to-dropbox.sh ]; check_item $? "backup-to-dropbox.sh is executable"

echo ""
echo "Checking git configuration..."
cd ~/dotfiles
git remote -v | grep -q "github.com/jmohouse6/dotfiles"; check_item $? "Dotfiles remote is GitHub"
git status | grep -q "up to date"; check_item $? "Dotfiles synced with GitHub"

echo ""
echo "Checking config files accessibility..."
[ -f ~/.config/hypr/hyprland.conf ]; check_item $? "Hyprland config accessible"
[ -f ~/.config/waybar/config.jsonc ]; check_item $? "Waybar config accessible"
[ -d ~/.config/omarchy/themes ]; check_item $? "Omarchy themes accessible"

echo ""
echo "========================================="
echo "  Verification Complete"
echo "========================================="
echo ""
echo "Documentation:"
echo "  - Setup guide: ~/dotfiles/SETUP_COMPLETE.md"
echo "  - README: ~/dotfiles/README.md"
echo "  - Recovery: ~/Dropbox/Documents/System-Recovery-Guide.md"
echo ""
