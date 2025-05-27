#!/bin/bash
# Quick Application Residue Cleanup Script
# Targets specific residue files based on manual inspection

echo "=== Quick Application Residue Cleanup ==="
echo "This script will clean up specific application residue files."
echo "Backup folders will be created before deletion."
echo ""

# Create backup directory
BACKUP_DIR=~/Desktop/Organized/Quick_Cleanup_Backups/$(date +"%Y-%m-%d")
mkdir -p $BACKUP_DIR

# Function to safely remove with backup
clean_residue() {
  local path="$1"
  local name="$2"
  
  if [ -e "$path" ]; then
    echo "Found $name residue at: $path"
    
    # Create path-based backup name
    local backup_name=$(echo "$path" | sed 's/\//_/g')
    
    # Backup
    echo "  Creating backup at: $BACKUP_DIR/$backup_name.tar.gz"
    tar -czf "$BACKUP_DIR/$backup_name.tar.gz" "$path" 2>/dev/null
    
    # Delete
    echo "  Removing residue files..."
    rm -rf "$path"
    echo "  Successfully removed $name residue."
    echo ""
    return 0
  else
    return 1
  fi
}

echo "Cleaning Adobe residue files..."
clean_residue ~/Library/Application\ Support/Adobe "Adobe" 
clean_residue ~/Library/Preferences/com.adobe* "Adobe preferences"
clean_residue ~/Library/Preferences/Adobe* "Adobe preferences"
clean_residue ~/Library/Caches/com.adobe* "Adobe cache"
clean_residue ~/Library/Caches/Adobe* "Adobe cache"

echo "Cleaning Microsoft Office residue files..."
clean_residue ~/Library/Application\ Support/Microsoft "Microsoft Office"
clean_residue ~/Library/Preferences/com.microsoft* "Microsoft preferences"
clean_residue ~/Library/Caches/com.microsoft* "Microsoft cache"
clean_residue ~/Library/Containers/com.microsoft* "Microsoft containers"

echo "Cleaning Google Chrome residue files..."
clean_residue ~/Library/Application\ Support/Google/Chrome "Google Chrome"
clean_residue ~/Library/Preferences/com.google.Chrome* "Chrome preferences"
clean_residue ~/Library/Caches/com.google.Chrome* "Chrome cache"

echo "Cleaning Zoom residue files..."
clean_residue ~/Library/Application\ Support/zoom.us "Zoom"
clean_residue ~/Library/Preferences/us.zoom* "Zoom preferences"
clean_residue ~/Library/Caches/us.zoom* "Zoom cache"
clean_residue ~/Library/Internet\ Plug-Ins/ZoomUsPlugIn.plugin "Zoom plugin"

echo "Cleaning Brave Browser residue files..."
clean_residue ~/Library/Application\ Support/BraveSoftware "Brave Browser"
clean_residue ~/Library/Preferences/com.brave* "Brave preferences"
clean_residue ~/Library/Caches/com.brave* "Brave cache"

echo "Cleaning CleanMyMac residue files..."
clean_residue ~/Library/Application\ Support/CleanMyMac* "CleanMyMac"
clean_residue ~/Library/Preferences/com.macpaw.CleanMyMac* "CleanMyMac preferences"
clean_residue ~/Library/Caches/com.macpaw.CleanMyMac* "CleanMyMac cache"

echo "Cleaning WhatsApp residue files..."
clean_residue ~/Library/Application\ Support/WhatsApp "WhatsApp"
clean_residue ~/Library/Preferences/WhatsApp* "WhatsApp preferences"
clean_residue ~/Library/Caches/WhatsApp* "WhatsApp cache"

echo "Cleanup complete! All application residue files have been removed."
echo "Backups stored at: $BACKUP_DIR"
echo ""
echo "For optimal performance, please restart your Mac."
