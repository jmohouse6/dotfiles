#!/bin/bash
# Clean scratch directories and old downloads
# Helps keep ~/local/ tidy

echo "🧹 Starting local workspace cleanup..."

# Clean scratch directories older than 30 days
if [ -d "$HOME/local/scratch" ]; then
    echo "  Cleaning scratch files older than 30 days..."
    find "$HOME/local/scratch" -type f -mtime +30 -delete 2>/dev/null
    find "$HOME/local/scratch" -type d -empty -delete 2>/dev/null
fi

# Clean download archives older than 90 days
if [ -d "$HOME/local/downloads/archive" ]; then
    echo "  Cleaning download archives older than 90 days..."
    find "$HOME/local/downloads/archive" -type f -mtime +90 -delete 2>/dev/null
fi

# Clean build caches (optional - uncomment if needed)
# if [ -d "$HOME/local/build/node-caches" ]; then
#     echo "  Cleaning old node caches..."
#     find "$HOME/local/build/node-caches" -type d -mtime +60 -exec rm -rf {} \; 2>/dev/null
# fi

echo "✅ Cleanup complete"

# Show disk usage
echo ""
echo "📊 Local workspace disk usage:"
du -sh "$HOME/local"/* 2>/dev/null | sort -h
