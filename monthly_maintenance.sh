#!/bin/bash
# Monthly Mac Maintenance Script
# Run this script once a month to keep your Mac running smoothly

echo "=== Monthly Mac Maintenance Script ==="
echo "Starting maintenance routines..."
echo ""

# Define paths
MAINTENANCE_DIR=~/Desktop/Organized/Maintenance_Scripts
LOGS_DIR=~/Desktop/Organized/Maintenance_Logs
mkdir -p $LOGS_DIR

# Log file
LOG_FILE="$LOGS_DIR/maintenance_$(date +"%Y-%m-%d").log"
exec > >(tee -a "$LOG_FILE") 2>&1

echo "Maintenance started: $(date)"
echo "=========================="
echo ""

# 1. Run system cleanup
echo "Step 1: Running system cleanup..."
$MAINTENANCE_DIR/clean_mac.sh
echo "System cleanup completed."
echo ""

# 2. Check for startup items
echo "Step 2: Checking startup items..."
launchctl list | grep -v "com.apple" | head -20
echo "Review the list above for any unwanted startup items."
echo "To disable these items, run: $MAINTENANCE_DIR/disable_all_startup_items.sh"
echo ""

# 3. Run application residue finder
echo "Step 3: Checking for application residue..."
$MAINTENANCE_DIR/find_app_residue.sh
echo "Application residue report created."
echo "Review the report and run cleanup_app_residue.sh if needed."
echo ""

# 4. Check disk space
echo "Step 4: Checking disk space..."
df -h
echo ""

# 5. Check large files
echo "Step 5: Finding large files (>500MB)..."
echo "This may take a while..."
find ~/ -type f -size +500M -not -path "*/Library/Application Support/MobileSync/*" -exec ls -lh {} \; 2>/dev/null | sort -rh | head -10
echo "Consider moving or deleting large unused files."
echo ""

# 6. Check memory and CPU usage
echo "Step 6: Checking system resources..."
top -l 1 -n 5 -o cpu
echo "Note any applications using excessive CPU or memory."
echo ""

# 7. Check for software updates
echo "Step 7: Checking for software updates..."
softwareupdate -l
echo ""

# 8. Clean browser data
echo "Step 8: Cleaning browser data..."
rm -rf ~/Library/Caches/Google/Chrome/Default/Cache/* 2>/dev/null
rm -rf ~/Library/Caches/com.brave.Browser/Default/Cache/* 2>/dev/null
rm -rf ~/Library/Caches/com.microsoft.edgemac/Default/Cache/* 2>/dev/null
echo "Browser caches cleaned."
echo ""

# 9. Remove old downloads
echo "Step 9: Finding old downloads (>30 days old)..."
find ~/Downloads -type f -mtime +30 -exec ls -lh {} \; 2>/dev/null | head -10
echo "Consider cleaning up old downloads."
echo ""

# 10. Run system maintenance scripts
echo "Step 10: Running system maintenance scripts..."
sudo periodic daily weekly monthly
echo "System maintenance scripts completed."
echo ""

echo "=========================="
echo "Maintenance completed: $(date)"
echo "Log saved to: $LOG_FILE"
echo ""
echo "For optimal performance, please restart your Mac."
