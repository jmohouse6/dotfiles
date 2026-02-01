# Dotfiles Manifest

Complete inventory of all files and configurations managed in this repository.

**Last Updated:** 2026-02-01  
**Repository:** https://github.com/jmohouse6/dotfiles

## Configuration Files

### Shell Configuration
- `.bashrc` - Bash shell configuration with XDG variables
- `.bash_profile` - Bash profile for login shells

### Git Configuration
- `.gitconfig` - Git aliases, settings, and LFS configuration

### Window Manager (Hyprland/Omarchy)
- `hypr/` - Hyprland window manager configuration
  - `hyprland.conf` - Main configuration
  - `bindings.conf` - Keybindings
  - `looknfeel.conf` - Appearance settings
  - `monitors.conf` - Monitor configuration
  - `input.conf` - Input device settings
  - `autostart.conf` - Autostart applications
  - `hypridle.conf` - Idle management
  - `hyprlock.conf` - Screen lock
  - `hyprsunset.conf` - Night light
  - `xdph.conf` - XDG desktop portal
  - `scripts/` - Helper scripts
  - `shaders/` - Visual effects

### Desktop Environment
- `waybar/` - Status bar configuration
- `walker/` - Application launcher
- `mako/` - Notification daemon
- `omarchy/` - Omarchy-specific settings
- `alacritty/` - Terminal emulator

### Development Tools
- `vscode/` - Visual Studio Code
  - `settings.json` - Editor settings
  - `keybindings.json` - Custom keybindings
  - `mcp.json` - Model Context Protocol config
  - `extensions.list` - Installed extensions
  - `README.md` - Extension management guide

## Scripts

All located in `scripts/`:

### `backup-configs.sh`
- **Purpose:** Automated config backup to Dropbox
- **Schedule:** Weekly via cron (Sundays 3 AM)
- **Backup Location:** `~/Dropbox/config-backups/dotfiles/`
- **Retention:** Last 10 backups

### `cleanup-local.sh`
- **Purpose:** Clean temporary files and old downloads
- **Targets:**
  - Scratch files older than 30 days
  - Download archives older than 90 days
- **Safe:** Only deletes old temporary files

### `sync-check.sh`
- **Purpose:** Verify sync status
- **Checks:**
  - Dropbox sync status
  - Git repository status
  - Uncommitted changes
  - Remote sync status

## Installation

### `install.sh`
- **Purpose:** Bootstrap script for new machines
- **Actions:**
  - Creates directory structure
  - Backs up existing configs
  - Creates symlinks to dotfiles
  - Sets up environment variables

## Dependencies

### Required Packages
- `git` - Version control
- `bash` - Shell
- `hyprland` - Window manager
- `waybar` - Status bar
- `walker` - Launcher
- `mako` - Notifications
- `alacritty` - Terminal

### Optional Packages
- `code` / `vscodium` - Code editor
- `dropbox` - Cloud storage CLI
- `direnv` - Environment management
- `pnpm` - Package manager

## Environment Variables

Set in `.bashrc`:

```bash
# XDG Base Directory
XDG_CONFIG_HOME=$HOME/.config
XDG_DATA_HOME=$HOME/.local/share
XDG_STATE_HOME=$HOME/.local/state
XDG_CACHE_HOME=$HOME/.cache

# Custom Workspaces
DEV_HOME=$HOME/dev
LOCAL_WORKSPACE=$HOME/local
DROPBOX_HOME=$HOME/Dropbox
```

## Symlink Map

Created by `install.sh`:

```
~/.config/hypr          → ~/dev/dotfiles/hypr
~/.config/waybar        → ~/dev/dotfiles/waybar
~/.config/walker        → ~/dev/dotfiles/walker
~/.config/alacritty     → ~/dev/dotfiles/alacritty
~/.config/mako          → ~/dev/dotfiles/mako
~/.config/omarchy       → ~/dev/dotfiles/omarchy
~/.config/Code/User     → ~/dev/dotfiles/vscode
~/.bashrc               → ~/dev/dotfiles/.bashrc
~/.bash_profile         → ~/dev/dotfiles/.bash_profile
~/.gitconfig            → ~/dev/dotfiles/.gitconfig
~/Downloads             → ~/local/downloads
```

## Excluded Files (.gitignore)

### VSCode
- `vscode/workspaceStorage/`
- `vscode/globalStorage/`
- `vscode/History/`
- `vscode/Cache/`
- `vscode/logs/`

### Secrets
- `*secret*`
- `*token*`
- `*.env`
- `*.pem`
- `*.key`
- `id_rsa*`
- `id_ed25519*`

### Backups
- `*.bak.*`
- `*.backup`
- `monitors.conf.backup`

### OS Files
- `.DS_Store`
- `Thumbs.db`

## Directory Structure Created

```
~/
├── dev/
│   └── dotfiles/            # This repository
│
├── local/
│   ├── build/
│   │   ├── node-caches/
│   │   ├── cargo-target/
│   │   └── docker-builds/
│   ├── data/
│   │   ├── ml-datasets/
│   │   ├── databases/
│   │   └── archives/
│   ├── vms/
│   │   ├── docker/
│   │   └── virtualbox/
│   ├── scratch/
│   ├── cache/
│   └── downloads/
│       ├── sorted/
│       │   ├── docs/
│       │   ├── media/
│       │   ├── software/
│       │   └── archives/
│       └── archive/
│
├── Dropbox/
│   ├── obsidian/
│   ├── documents/
│   ├── personal/
│   ├── projects/
│   └── config-backups/
│       ├── dotfiles/
│       ├── app-settings/
│       └── scripts/
│
└── .local/
    ├── share/
    ├── state/
    └── bin/
```

## Version History

### v1.0.0 (2026-02-01)
- Initial dotfiles repository
- Omarchy/Hyprland configuration
- VSCode settings and extensions
- Automation scripts (backup, cleanup, sync-check)
- Bootstrap installer
- Complete directory structure
- XDG Base Directory compliance
- Git configuration with aliases
- Documentation (README, MANIFEST)

## Maintenance Checklist

### Weekly
- [ ] Review backup status: `./scripts/sync-check.sh`
- [ ] Clean local workspace: `./scripts/cleanup-local.sh`
- [ ] Automatic backup runs (cron)

### Monthly
- [ ] Update VSCode extensions list
- [ ] Review and clean archives
- [ ] Check for config drift

### When Adding New Config
1. Add file to `~/dev/dotfiles/`
2. Update `install.sh` to create symlink
3. Update `.gitignore` if needed
4. Test on fresh machine (if possible)
5. Commit and push changes
6. Update this MANIFEST.md

## Support

For issues or questions:
- Check README.md troubleshooting section
- Review install.sh script
- Check symlinks: `ls -la ~/.config/`
- Verify environment variables: `env | grep XDG`

---

**Repository:** https://github.com/jmohouse6/dotfiles  
**Maintainer:** Jason Moorhouse (@jmohouse6)  
**License:** MIT
