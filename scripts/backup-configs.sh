#!/bin/bash
# Automated config backup to Dropbox
# Run weekly via cron for safety snapshots

BACKUP_DIR="$HOME/Dropbox/config-backups/dotfiles/$(date +%Y%m%d-%H%M%S)"

echo "🔄 Starting config backup..."

mkdir -p "$BACKUP_DIR"

# Backup critical configs
cp -r ~/.config/hypr "$BACKUP_DIR/" 2>/dev/null
cp -r ~/.config/waybar "$BACKUP_DIR/" 2>/dev/null
cp -r ~/.config/walker "$BACKUP_DIR/" 2>/dev/null
cp -r ~/.config/alacritty "$BACKUP_DIR/" 2>/dev/null
cp -r ~/.config/mako "$BACKUP_DIR/" 2>/dev/null
cp -r ~/.config/omarchy "$BACKUP_DIR/" 2>/dev/null
cp ~/.bashrc "$BACKUP_DIR/.bashrc" 2>/dev/null
cp ~/.bash_profile "$BACKUP_DIR/.bash_profile" 2>/dev/null
cp ~/.gitconfig "$BACKUP_DIR/.gitconfig" 2>/dev/null

# Backup VSCode settings (just JSON files, not cache)
mkdir -p "$BACKUP_DIR/vscode"
cp ~/.config/Code/User/*.json "$BACKUP_DIR/vscode/" 2>/dev/null

echo "✅ Backup complete: $BACKUP_DIR"

# Keep only last 10 backups (cleanup old ones)
cd "$HOME/Dropbox/config-backups/dotfiles/" || exit
ls -t | tail -n +11 | xargs -r rm -rf

echo "🧹 Cleaned up old backups (keeping last 10)"
