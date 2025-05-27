#!/bin/bash
# Script to disable unnecessary startup items

echo "=== Disabling Unnecessary Startup Items ==="

# Create backup directory
BACKUP_DIR=~/Desktop/Organized/Startup_Items_Backup
mkdir -p $BACKUP_DIR

# Backup and disable user launch agents (uncomment items you want to disable)
echo "Backing up and disabling user launch agents..."
LAUNCH_AGENTS=~/Library/LaunchAgents

# Astrill VPN launcher (if not in use)
if [ -f "$LAUNCH_AGENTS/com.astrill.launcher.plist" ]; then
  cp "$LAUNCH_AGENTS/com.astrill.launcher.plist" "$BACKUP_DIR/"
  launchctl unload -w "$LAUNCH_AGENTS/com.astrill.launcher.plist"
  mv "$LAUNCH_AGENTS/com.astrill.launcher.plist" "$LAUNCH_AGENTS/com.astrill.launcher.plist.disabled"
  echo "Disabled: Astrill VPN launcher"
fi

# CleanMyMac scheduler (if not actively using)
if [ -f "$LAUNCH_AGENTS/com.macpaw.CleanMyMac3.Scheduler.plist" ]; then
  cp "$LAUNCH_AGENTS/com.macpaw.CleanMyMac3.Scheduler.plist" "$BACKUP_DIR/"
  launchctl unload -w "$LAUNCH_AGENTS/com.macpaw.CleanMyMac3.Scheduler.plist"
  mv "$LAUNCH_AGENTS/com.macpaw.CleanMyMac3.Scheduler.plist" "$LAUNCH_AGENTS/com.macpaw.CleanMyMac3.Scheduler.plist.disabled"
  echo "Disabled: CleanMyMac scheduler"
fi

# Steam cleaner (if not actively using)
if [ -f "$LAUNCH_AGENTS/com.valvesoftware.steamclean.plist" ]; then
  cp "$LAUNCH_AGENTS/com.valvesoftware.steamclean.plist" "$BACKUP_DIR/"
  launchctl unload -w "$LAUNCH_AGENTS/com.valvesoftware.steamclean.plist"
  mv "$LAUNCH_AGENTS/com.valvesoftware.steamclean.plist" "$LAUNCH_AGENTS/com.valvesoftware.steamclean.plist.disabled"
  echo "Disabled: Steam cleaner"
fi

echo "Process complete. Disabled items backed up to: $BACKUP_DIR"
echo "Note: You may need to restart your computer for changes to take effect."
echo "To re-enable items, rename them to remove .disabled extension and run: launchctl load -w [path-to-plist]"
