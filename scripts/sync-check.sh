#!/bin/bash
# Check sync status of Dropbox and dotfiles git repo
# Useful for verifying everything is backed up

echo "🔍 Checking sync status..."
echo ""

# Check Dropbox status
echo "📦 Dropbox Status:"
if command -v dropbox &> /dev/null; then
    dropbox status
else
    echo "  ℹ️  Dropbox CLI not installed (files may still be syncing via GUI)"
    if [ -d "$HOME/Dropbox" ]; then
        echo "  ✓ Dropbox directory exists"
    fi
fi

echo ""

# Check dotfiles git status
echo "📂 Dotfiles Git Status:"
if [ -d "$HOME/dev/dotfiles/.git" ]; then
    cd "$HOME/dev/dotfiles" || exit
    
    # Check for uncommitted changes
    if [ -n "$(git status --porcelain)" ]; then
        echo "  ⚠️  Uncommitted changes detected:"
        git status --short
    else
        echo "  ✓ Working tree clean"
    fi
    
    # Check if ahead of remote
    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse @{u} 2>/dev/null)
    
    if [ "$LOCAL" != "$REMOTE" ] && [ -n "$REMOTE" ]; then
        echo "  ⚠️  Local branch is ahead of remote - push needed"
    elif [ -n "$REMOTE" ]; then
        echo "  ✓ Synced with remote"
    else
        echo "  ℹ️  No remote tracking branch set"
    fi
    
    echo ""
    echo "  Last commit:"
    git log -1 --format="  %h - %s (%cr)"
else
    echo "  ❌ Dotfiles git repository not found"
fi

echo ""
echo "✅ Sync check complete"
