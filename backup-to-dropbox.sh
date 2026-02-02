#!/bin/bash
# ~/dotfiles/backup-to-dropbox.sh
# Periodic backup of configs to Dropbox

set -e

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$HOME/Dropbox/Configs-Backup/$DATE"
LATEST_LINK="$HOME/Dropbox/Configs-Backup/LATEST"

echo "Creating backup: $BACKUP_DIR"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Backup VS Code settings (not in dotfiles)
if [ -d "$HOME/.config/Code/User" ]; then
    echo "Backing up VS Code settings..."
    mkdir -p "$BACKUP_DIR/Code/User"
    cp -r "$HOME/.config/Code/User/settings.json" "$BACKUP_DIR/Code/User/" 2>/dev/null || true
    cp -r "$HOME/.config/Code/User/keybindings.json" "$BACKUP_DIR/Code/User/" 2>/dev/null || true
    cp -r "$HOME/.config/Code/User/snippets" "$BACKUP_DIR/Code/User/" 2>/dev/null || true
    cp -r "$HOME/.config/Code/User/mcp.json" "$BACKUP_DIR/Code/User/" 2>/dev/null || true
fi

# Backup GitHub Desktop settings
if [ -d "$HOME/.config/GitHub Desktop" ]; then
    echo "Backing up GitHub Desktop settings..."
    cp -r "$HOME/.config/GitHub Desktop" "$BACKUP_DIR/" 2>/dev/null || true
fi

# Backup shell history
cp "$HOME/.bash_history" "$BACKUP_DIR/" 2>/dev/null || true

# Backup git config
cp "$HOME/.gitconfig" "$BACKUP_DIR/" 2>/dev/null || true

# Backup Claude config
if [ -f "$HOME/.claude.json" ]; then
    cp "$HOME/.claude.json" "$BACKUP_DIR/" 2>/dev/null || true
fi

# Create a manifest
cat > "$BACKUP_DIR/MANIFEST.txt" << EOF
Backup created: $DATE
Hostname: $(hostname)
User: $USER
OS: $(uname -a)

Contents:
- VS Code User settings
- GitHub Desktop settings
- Shell history
- Git global config
- Claude configuration

Note: Dotfiles are version controlled in GitHub
Repository: https://github.com/jmohouse6/dotfiles
EOF

# Update LATEST symlink
rm -f "$LATEST_LINK"
ln -s "$BACKUP_DIR" "$LATEST_LINK"

echo "Backup complete: $BACKUP_DIR"
echo "Latest backup linked at: $LATEST_LINK"

# Optional: Archive old backups (keep last 10)
cd "$HOME/Dropbox/Configs-Backup"
BACKUP_COUNT=$(ls -dt */ 2>/dev/null | grep -v "^archives/" | wc -l)
if [ "$BACKUP_COUNT" -gt 10 ]; then
    echo "Archiving old backups (keeping last 10)..."
    ls -dt */ | grep -v "^archives/" | tail -n +11 | while read dir; do
        mv "$dir" archives/ 2>/dev/null || true
    done
    echo "Old backups archived"
fi

echo ""
echo "Backup summary:"
echo "  Total backups: $BACKUP_COUNT"
echo "  Latest: $LATEST_LINK"
