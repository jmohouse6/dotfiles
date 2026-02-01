#!/bin/bash

# OpenCode Terminal Split Script
# Opens a Ghostty terminal split to the right when OpenCode is running

# Function to check if OpenCode is running
is_opencode_running() {
    hyprctl clients -j | jq -r '.[] | select(.class | test("OpenCode|Code"; "i")) | .class' | head -1 | [ -n "$(cat)" ]
}

# Function to get OpenCode window address
get_opencode_address() {
    hyprctl clients -j | jq -r '.[] | select(.class | test("OpenCode|Code"; "i")) | .address' | head -1
}

# Function to get current workspace
get_current_workspace() {
    hyprctl activewindow -j | jq -r '.workspace.id'
}

# Function to open terminal in split layout  
open_terminal_split() {
    local opencode_addr=$(get_opencode_address)
    
    if [ -n "$opencode_addr" ]; then
        # Focus the OpenCode window first
        hyprctl dispatch focuswindow "address:$opencode_addr"
        sleep 0.2
        
        # Create split to the right by opening terminal
        # The window rules will automatically handle the sizing and positioning
        local current_dir="$(omarchy-cmd-terminal-cwd)"
        
        # Open ghostty with special class for identification
        uwsm-app -- env HYPRLAND_INSTANCE_SIGNATURE="$HYPRLAND_INSTANCE_SIGNATURE" \
            ghostty --class="ghostty-opencode-split" --working-directory="$current_dir" &
        
        # Wait for window to appear and then arrange it
        sleep 0.5
        
        # Use Hyprland's dwindle layout to split right
        hyprctl dispatch movefocus l  # Move focus back to OpenCode
        hyprctl dispatch movefocus r  # Then to terminal to ensure it's on the right
        
    else
        echo "OpenCode window not found, opening terminal normally"
        uwsm-app -- xdg-terminal-exec --dir="$(omarchy-cmd-terminal-cwd)"
    fi
}

# Main execution
if command -v jq >/dev/null 2>&1; then
    if is_opencode_running; then
        echo "OpenCode detected, opening terminal in split"
        open_terminal_split
    else
        echo "OpenCode not running, opening terminal normally"
        uwsm-app -- xdg-terminal-exec --dir="$(omarchy-cmd-terminal-cwd)"
    fi
else
    # Fallback without jq
    echo "jq not found, using simple detection"
    if hyprctl clients | grep -qi "opencode\|code"; then
        open_terminal_split
    else
        uwsm-app -- xdg-terminal-exec --dir="$(omarchy-cmd-terminal-cwd)"
    fi
fi