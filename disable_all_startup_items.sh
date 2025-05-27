#!/bin/bash
# Enhanced script to disable ALL unnecessary startup items

echo "=== Disabling ALL Unnecessary Startup Items ==="

# Create backup directory
BACKUP_DIR=~/Desktop/Organized/Startup_Items_Backup
mkdir -p $BACKUP_DIR

# Backup and disable user launch agents
echo "Backing up and disabling user launch agents..."
LAUNCH_AGENTS=~/Library/LaunchAgents

# First, let's list all the current launch agents
echo "Current user launch agents:"
ls -la $LAUNCH_AGENTS

# Create a backup of all launch agents
echo "Creating backups of all launch agents..."
cp -r $LAUNCH_AGENTS/* $BACKUP_DIR/ 2>/dev/null

# Disable ALL user launch agents (will exclude any that are critical for system)
for agent in $LAUNCH_AGENTS/*.plist; do
  if [ -f "$agent" ]; then
    # Skip Apple system agents if needed
    if [[ "$agent" == *"com.apple.security"* ]] || [[ "$agent" == *"com.apple.digihub"* ]]; then
      echo "Skipping essential Apple agent: $agent"
      continue
    fi
    
    # Unload and disable the agent
    launchctl unload -w "$agent" 2>/dev/null
    mv "$agent" "$agent.disabled"
    echo "Disabled: $(basename "$agent")"
  fi
done

# Show backup location
echo ""
echo "All disabled items backed up to: $BACKUP_DIR"
echo "Note: You may need to restart your computer for changes to take effect."
echo ""
echo "To re-enable a specific item:"
echo "1. Go to ~/Library/LaunchAgents/"
echo "2. Rename the item to remove .disabled extension"
echo "3. Run: launchctl load -w [path-to-plist]"
echo ""
echo "== Listing Login Items in System Settings =="
echo "Please also check System Settings > General > Login Items and disable unwanted items there."
