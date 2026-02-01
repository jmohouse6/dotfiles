# Dotfiles - Universal Linux Development Environment

Personal dotfiles for a universal Linux development environment featuring Omarchy (Hyprland), Dropbox, GitHub workflow, and VSCode.

**Author:** Jason Moorhouse (@jmohouse6)  
**System:** Linux (Omarchy/Hyprland)  
**Philosophy:** Clear separation of synced, local, and version-controlled files

## Directory Structure

```
~/
├── dev/              # All development projects (Git repos)
├── local/            # Local workspace (never synced)
├── Dropbox/          # Cloud-synced files
├── .config/          # App configs (symlinked to dotfiles)
├── .local/           # XDG data, state, bin
└── .cache/           # XDG cache
```

## Quick Start

### Fresh Machine Setup

```bash
# Clone this repository
git clone https://github.com/jmohouse6/dotfiles.git ~/dev/dotfiles

# Run the installer
cd ~/dev/dotfiles
./install.sh

# Reload shell
source ~/.bashrc
```

### What Gets Installed

- **Omarchy/Hyprland configs:** hypr, waybar, walker, mako
- **Terminal:** alacritty configuration
- **Editor:** VSCode settings and extensions
- **Shell:** .bashrc, .bash_profile with XDG variables
- **Git:** .gitconfig with aliases and settings
- **Directory structure:** ~/dev, ~/local, ~/Dropbox organization

## Managed Configurations

### Window Manager & Desktop
- `hypr/` - Hyprland configuration
- `waybar/` - Status bar
- `walker/` - Application launcher
- `mako/` - Notification daemon
- `omarchy/` - Omarchy-specific settings

### Development Tools
- `vscode/` - VSCode settings, keybindings, extensions
- `.gitconfig` - Git configuration
- `.bashrc` - Shell configuration with XDG variables

### Terminal
- `alacritty/` - Terminal emulator configuration

## Maintenance Scripts

Located in `scripts/`:

### `backup-configs.sh`
Automated backup to Dropbox (run weekly via cron)
```bash
./scripts/backup-configs.sh
```

### `cleanup-local.sh`
Clean old scratch files and downloads
```bash
./scripts/cleanup-local.sh
```

### `sync-check.sh`
Verify Dropbox and git sync status
```bash
./scripts/sync-check.sh
```

## Folder Organization

### `~/dev/` - Development Projects
All Git repositories in a flat structure:
```
~/dev/
├── dotfiles/           # This repository
├── crm/                # Project repos
├── moorhouse2025/
└── ...
```

### `~/local/` - Local Workspace
Never backed up, never synced:
```
~/local/
├── build/              # Build artifacts, caches
├── data/               # Large datasets, databases
├── vms/                # Virtual machines, containers
├── scratch/            # Temporary experiments
└── downloads/          # Organized downloads
```

### `~/Dropbox/` - Cloud Storage
Synced across all machines:
```
~/Dropbox/
├── documents/          # General documents
├── obsidian/           # Notes vault
├── personal/           # Personal files
├── projects/           # Business projects
└── config-backups/     # Weekly config snapshots
```

## Environment Variables

Set in `.bashrc`:

```bash
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export DEV_HOME="$HOME/dev"
export LOCAL_WORKSPACE="$HOME/local"
export DROPBOX_HOME="$HOME/Dropbox"
```

## Features

✅ **Universal:** Same structure on all Linux machines  
✅ **Organized:** Clear separation of concerns  
✅ **Version Controlled:** Dotfiles tracked in Git  
✅ **Backed Up:** Critical configs in Dropbox + GitHub  
✅ **XDG Compliant:** Clean home directory  
✅ **Scalable:** Easy to add new machines/projects  
✅ **Portable:** Bootstrap in minutes

## Updating

### Pull Latest Changes
```bash
cd ~/dev/dotfiles
git pull
```

### Push Your Changes
```bash
cd ~/dev/dotfiles
git add .
git commit -m "Update configs"
git push
```

### Update Extensions List
```bash
code --list-extensions > ~/dev/dotfiles/vscode/extensions.list
```

## Troubleshooting

### Symlinks Not Working
```bash
cd ~/dev/dotfiles
./install.sh
```

### Config Changes Not Applying
```bash
# Reload Hyprland
hyprctl reload

# Reload shell
source ~/.bashrc
```

### Check Sync Status
```bash
./scripts/sync-check.sh
```

## Files Not Tracked

The following are intentionally excluded (see `.gitignore`):
- VSCode cache and workspace files
- Secrets, tokens, API keys
- Backup files (*.bak.*)
- OS-specific files (.DS_Store)
- Machine-specific configs (monitors.conf.backup)

## Weekly Maintenance

Set up automatic backups with cron:
```bash
crontab -e

# Add this line for weekly backups (Sundays at 3 AM):
0 3 * * 0 $HOME/dev/dotfiles/scripts/backup-configs.sh
```

## License

MIT License - Feel free to use and modify for your own setup.

## Credits

- **Omarchy** - Amazing Hyprland-based Linux distribution
- **Hyprland** - Tiling window manager
- **Dropbox** - Cloud storage solution
