# Repository Migration Notes

## Completed Migrations

### moorhouse-portal
- **Original location**: `~/Dropbox/moorhouse-portal`
- **New location**: `~/Projects/moorhouse-portal`
- **Status**: ✅ Successfully migrated
- **Git status**: Clean working tree, 2 commits ahead of origin/master
- **Remote**: https://github.com/jmohouse6/moorhouse-portal.git
- **Date**: February 2, 2026

## Pending Migrations

### moorhouse2025
- **Current location**: `~/Dropbox/moorhouse2025`
- **Planned location**: `~/Projects/moorhouse2025`
- **Status**: ⏸️ NOT MIGRATED YET - Has uncommitted changes
- **Reason**: Working directory has 400+ modified files that need to be reviewed
- **Remote**: https://github.com/jmohouse6/moorhouse2025.git
- **Action required**: 
  1. Review uncommitted changes
  2. Decide what to commit vs discard
  3. Create meaningful commits
  4. Then migrate to ~/Projects

**Recommendation**: Handle moorhouse2025 migration separately when you're ready to commit or stash those changes.

### Flutter SDK
- **Current location**: `~/Dropbox/flutter`
- **Status**: Not migrated (official Flutter SDK)
- **Note**: This is the Flutter framework itself, not a custom project. Consider moving to:
  - `~/development/flutter` (recommended)
  - Or keep in Dropbox if used across multiple machines

## Migration Checklist

When ready to migrate moorhouse2025:
```bash
# 1. Navigate to repo
cd ~/Dropbox/moorhouse2025

# 2. Review changes
git status
git diff | head -100

# 3. Decide: commit, stash, or discard
git add <files-to-keep>
git commit -m "Your message"
# OR
git stash save "Pre-migration changes"
# OR
git restore .  # CAUTION: Discards all changes

# 4. Verify clean
git status

# 5. Move to Projects
mv ~/Dropbox/moorhouse2025 ~/Projects/

# 6. Verify git still works
cd ~/Projects/moorhouse2025
git status
git fetch
```

## Post-Migration Verification

- [x] moorhouse-portal accessible from new location
- [x] Git operations work in new location
- [ ] moorhouse2025 migrated
- [ ] All projects buildable from ~/Projects
- [ ] VS Code can open projects from ~/Projects
- [ ] No broken absolute paths in project files
