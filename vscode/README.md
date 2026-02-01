# VSCode Configuration

This directory contains VSCode settings and extensions configuration.

## Files

- `settings.json` - VSCode settings
- `keybindings.json` - Custom keybindings
- `mcp.json` - MCP (Model Context Protocol) configuration
- `extensions.list` - List of installed extensions

## Installing Extensions

To install all extensions on a new machine:

```bash
cat ~/dev/dotfiles/vscode/extensions.list | xargs -L 1 code --install-extension
```

## Exporting Extensions

To update the extensions list:

```bash
code --list-extensions > ~/dev/dotfiles/vscode/extensions.list
```
