#!/bin/bash
# Script to clean up application residue files
# CAUTION: Use this script carefully after reviewing the residue report

echo "=== Application Residue Cleanup ==="
echo "This script will help you clean up leftover files from deleted applications."
echo "CAUTION: This is a potentially destructive operation. Backup important data first."
echo ""

# Create a backup directory
BACKUP_DIR=~/Desktop/Organized/App_Residue_Backups/$(date +"%Y-%m-%d")
mkdir -p $BACKUP_DIR

# Function to safely remove files with backup
safe_remove() {
  if [ -e "$1" ]; then
    local dir_name=$(dirname "$1")
    local base_name=$(basename "$1")
    local backup_path="$BACKUP_DIR/${dir_name//\//_}_$base_name"
    
    echo "Backing up: $1 to $backup_path"
    cp -R "$1" "$backup_path" 2>/dev/null
    
    echo "Removing: $1"
    rm -rf "$1"
    return 0
  else
    echo "Warning: $1 does not exist, skipping."
    return 1
  fi
}

echo "Common applications with known residue files:"
echo "1) Adobe Creative Cloud"
echo "2) Microsoft Office"
echo "3) Google Chrome"
echo "4) Skype"
echo "5) Zoom"
echo "6) Dropbox"
echo "7) Steam"
echo "8) Custom cleanup"
echo "9) Exit"
echo ""

while true; do
  read -p "Enter your choice (1-9): " choice
  
  case $choice in
    1)
      echo "Cleaning Adobe residue files..."
      safe_remove ~/Library/Application\ Support/Adobe
      safe_remove ~/Library/Preferences/com.adobe*
      safe_remove ~/Library/Preferences/Adobe*
      safe_remove ~/Library/Caches/com.adobe*
      safe_remove ~/Library/Caches/Adobe*
      safe_remove ~/Library/Logs/Adobe*
      safe_remove ~/Library/Saved\ Application\ State/com.adobe*
      echo "Adobe residue files cleaned up."
      ;;
    2)
      echo "Cleaning Microsoft Office residue files..."
      safe_remove ~/Library/Application\ Support/Microsoft
      safe_remove ~/Library/Preferences/com.microsoft*
      safe_remove ~/Library/Caches/com.microsoft*
      safe_remove ~/Library/Containers/com.microsoft*
      safe_remove ~/Library/Saved\ Application\ State/com.microsoft*
      safe_remove ~/Library/Group\ Containers/*office*
      echo "Microsoft Office residue files cleaned up."
      ;;
    3)
      echo "Cleaning Google Chrome residue files..."
      safe_remove ~/Library/Application\ Support/Google/Chrome
      safe_remove ~/Library/Preferences/com.google.Chrome*
      safe_remove ~/Library/Caches/com.google.Chrome*
      safe_remove ~/Library/Saved\ Application\ State/com.google.Chrome*
      echo "Google Chrome residue files cleaned up."
      ;;
    4)
      echo "Cleaning Skype residue files..."
      safe_remove ~/Library/Application\ Support/Skype
      safe_remove ~/Library/Preferences/com.skype*
      safe_remove ~/Library/Caches/com.skype*
      safe_remove ~/Library/Saved\ Application\ State/com.skype*
      echo "Skype residue files cleaned up."
      ;;
    5)
      echo "Cleaning Zoom residue files..."
      safe_remove ~/Library/Application\ Support/zoom.us
      safe_remove ~/Library/Preferences/us.zoom*
      safe_remove ~/Library/Caches/us.zoom*
      safe_remove ~/Library/Saved\ Application\ State/us.zoom*
      safe_remove ~/Library/Internet\ Plug-Ins/ZoomUsPlugIn.plugin
      echo "Zoom residue files cleaned up."
      ;;
    6)
      echo "Cleaning Dropbox residue files..."
      safe_remove ~/Library/Application\ Support/Dropbox
      safe_remove ~/Library/Preferences/com.dropbox*
      safe_remove ~/Library/Caches/com.dropbox*
      safe_remove ~/Library/Saved\ Application\ State/com.dropbox*
      echo "Dropbox residue files cleaned up."
      ;;
    7)
      echo "Cleaning Steam residue files..."
      safe_remove ~/Library/Application\ Support/Steam
      safe_remove ~/Library/Preferences/com.valvesoftware.steam*
      safe_remove ~/Library/Caches/com.valvesoftware.steam*
      safe_remove ~/Library/Saved\ Application\ State/com.valvesoftware.steam*
      echo "Steam residue files cleaned up."
      ;;
    8)
      read -p "Enter app name or identifier to clean (e.g., 'Firefox' or 'com.mozilla'): " app_name
      if [ -n "$app_name" ]; then
        echo "Cleaning $app_name residue files..."
        safe_remove ~/Library/Application\ Support/$app_name
        safe_remove ~/Library/Application\ Support/com.$app_name*
        safe_remove ~/Library/Preferences/$app_name*
        safe_remove ~/Library/Preferences/com.$app_name*
        safe_remove ~/Library/Caches/$app_name*
        safe_remove ~/Library/Caches/com.$app_name*
        safe_remove ~/Library/Saved\ Application\ State/$app_name*
        safe_remove ~/Library/Saved\ Application\ State/com.$app_name*
        safe_remove ~/Library/Containers/$app_name*
        safe_remove ~/Library/Containers/com.$app_name*
        echo "$app_name residue files cleaned up."
      else
        echo "No app name provided. Skipping."
      fi
      ;;
    9)
      echo "Exiting cleanup script."
      break
      ;;
    *)
      echo "Invalid option. Please try again."
      ;;
  esac
  
  echo ""
done

echo "Cleanup completed. Backups stored in: $BACKUP_DIR"
echo "You may want to restart your Mac to fully apply changes."
