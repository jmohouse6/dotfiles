# Jason's Omarchy Dotfiles

Bulletproof configuration management for Omarchy Linux with Hyprland, Waybar, and all custom theming.

## Overview

This repository contains my complete Omarchy desktop environment configuration, managed through Git for version control and easy recovery.

## What's Included

- **Hyprland**: Window manager configuration, keybindings, animations
- **Waybar**: Status bar theming and modules
- **Omarchy**: Theme system, branding, and hooks
- **Terminals**: Alacritty, Ghostty, and Kitty configurations
- **Walker**: Application launcher
- **Btop**: System monitor theme
- **Mako**: Notification daemon
- **Shell**: Bash configuration and aliases
- **Git**: Global git configuration

## System Architecture

```
~/Projects/          # Code repositories (local, backed up to GitHub)
~/Dropbox/           # Documents and Obsidian (cloud synced)
  ├── Obsidian/      # All vaults
  ├── Documents/     # Business and personal documents
  └── Configs-Backup/ # Periodic config snapshots
~/dotfiles/          # This repository (version controlled)
~/.config/           # Symlinked to ~/dotfiles/* directories
~/Downloads/         # Temporary files (not backed up)
```

## Fresh Install Instructions

### Prerequisites
1. Fresh Omarchy Linux installation
2. Internet connection
3. GitHub account
4. Dropbox account

### Installation Steps

#### 1. Install Base Applications (10-15 min)
```bash
# Update system
sudo pacman -Syu

# Install essential tools
sudo pacman -S git base-devel

# Install Dropbox
yay -S dropbox

# Install VS Code
yay -S visual-studio-code-bin

# Install GitHub Desktop (optional)
yay -S github-desktop-bin

# Install Obsidian
yay -S obsidian
```

#### 2. Setup Dropbox (30-60 min)
```bash
# Start and login to Dropbox
dropbox

# Wait for sync to complete
# Monitor with: dropbox status
```

#### 3. Clone and Install Dotfiles (5 min)
```bash
# Clone this repository
cd ~
git clone https://github.com/jmohouse6/dotfiles.git

# Run installation script
cd ~/dotfiles
./install.sh

# Reload shell
source ~/.bashrc
```

#### 4. Setup VS Code (2 min)
1. Open VS Code
2. Sign in with GitHub account
3. Enable Settings Sync
4. Wait for extensions to install

#### 5. Clone Project Repositories (10 min)
```bash
# Create projects directory
mkdir -p ~/Projects

# Clone your repositories
cd ~/Projects
git clone https://github.com/jmohouse6/moorhouse-portal.git
git clone https://github.com/jmohouse6/moorhouse2025.git
# ... add other repos
```

#### 6. Setup Obsidian (2 min)
1. Open Obsidian
2. Open vault from `~/Dropbox/Obsidian/moorhouse`

#### 7. Verify Installation
- [ ] Hyprland launches with custom config
- [ ] Waybar appears correctly
- [ ] All keybindings work
- [ ] Dropbox syncing
- [ ] VS Code has extensions
- [ ] Git configured (run: `git config --list`)
- [ ] Projects accessible
- [ ] Obsidian vault works

**Total time: 1-2 hours** (mostly waiting for Dropbox)

## Daily Workflow

### Code Changes
```bash
cd ~/Projects/your-project
# make changes
git add .
git commit -m "Your message"
git push
```

### Config Changes
```bash
# Edit configs in ~/.config/ (they're symlinked to ~/dotfiles)
cd ~/dotfiles
git status  # See what changed
git add -A
git commit -m "Update Hyprland keybindings"
git push
```

### Periodic Backups (Weekly Recommended)
```bash
# Backup non-git configs to Dropbox
cd ~/dotfiles
./backup-to-dropbox.sh

# Commit any dotfile changes
git add -A
git commit -m "Weekly backup"
git push
```

## Recovery Scenarios

### Corrupted Config File
```bash
# Option 1: Restore from git
cd ~/dotfiles
git log  # Find last good commit
git checkout HEAD~1 -- hypr/hyprland.conf

# Option 2: Restore from Dropbox backup
cp ~/Dropbox/Configs-Backup/LATEST/hypr/hyprland.conf ~/.config/hypr/
```

### Complete System Failure
Follow "Fresh Install Instructions" above. All data restored from:
- GitHub (code + configs)
- Dropbox (documents + Obsidian)

## Maintenance

### Update Dotfiles
```bash
cd ~/dotfiles
git pull
./install.sh  # Re-run if structure changed
```

### Clean Downloads
```bash
# Regularly clean temporary files
rm -rf ~/Downloads/*
# Or move important files to Dropbox first
```

### Archive Old Backups
```bash
# Automatically done by backup-to-dropbox.sh
# Keeps last 10 backups, archives older ones
```

## Repository Information

- **Owner**: Jason Moorhouse
- **Email**: jmohouse6@users.noreply.github.com
- **GitHub**: https://github.com/jmohouse6/dotfiles
- **Created**: February 2, 2026
- **Last Updated**: February 2, 2026

## Backup Strategy

### Triple Redundancy
1. **GitHub** - All dotfiles version controlled
2. **Dropbox** - Periodic snapshots of all configs
3. **VS Code Sync** - Editor settings separately synced

### What's Backed Up Where
| Data Type | GitHub | Dropbox | Local Only |
|-----------|--------|---------|------------|
| Code Repos | ✓ | | ✓ |
| Dotfiles | ✓ | ✓ (snapshots) | ✓ |
| Obsidian Vaults | | ✓ | ✓ |
| Documents | | ✓ | ✓ |
| VS Code Settings | ✓ (reference) | ✓ | ✓ (synced) |
| Downloads | | | ✓ |

## License

Personal configuration - use at your own risk!
