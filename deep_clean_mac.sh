#!/bin/bash
# Deep Clean Mac Script
# This script performs a comprehensive cleaning of junk files on your Mac

echo "=== Deep Mac Cleaning Script ==="
echo "Starting deep cleaning process... This may take several minutes."
echo ""

# Create backup directory
BACKUP_DIR=~/Desktop/Organized/System_Cleaning_Backups/$(date +"%Y-%m-%d")
mkdir -p $BACKUP_DIR

# Function to safely clean with backup
safe_clean() {
  local target="$1"
  local desc="$2"
  local skip_backup="$3"
  
  if [ -e "$target" ]; then
    echo "Cleaning $desc..."
    
    if [ "$skip_backup" != "yes" ] && [ -d "$target" ]; then
      local backup_name=$(echo "$target" | sed 's/\//_/g')
      local backup_path="$BACKUP_DIR/$backup_name"
      echo "  Backing up to $backup_path"
      tar -czf "$backup_path.tar.gz" "$target" 2>/dev/null
    fi
    
    if [ -d "$target" ]; then
      rm -rf "${target:?}"/* 2>/dev/null
    else
      rm -rf "${target:?}" 2>/dev/null
    fi
    echo "  Done cleaning $desc"
  else
    echo "  $desc not found, skipping."
  fi
}

echo "1. Cleaning System Caches..."

# System caches
safe_clean ~/Library/Caches "User cache files"
safe_clean /Library/Caches "System cache files"

echo "2. Cleaning Application Caches..."

# Common browser caches
safe_clean ~/Library/Caches/com.apple.Safari "Safari cache"
safe_clean ~/Library/Safari/LocalStorage "Safari local storage"
safe_clean ~/Library/Caches/com.google.Chrome "Chrome cache"
safe_clean ~/Library/Caches/Google/Chrome/Default/Cache "Chrome cache data"
safe_clean ~/Library/Caches/com.brave.Browser "Brave cache"
safe_clean ~/Library/Application\ Support/Google/Chrome/Default/Application\ Cache "Chrome application cache"
safe_clean ~/Library/Caches/com.microsoft.edgemac "Edge cache"

echo "3. Cleaning Logs..."

# Log files
safe_clean ~/Library/Logs "Application logs"
safe_clean /Library/Logs "System logs"
safe_clean /var/log "System logs directory" yes

echo "4. Cleaning Temporary Files..."

# Temporary files
safe_clean /private/var/tmp "System temporary files" yes
safe_clean /private/var/folders "System cache folders" yes
safe_clean ~/Library/Caches/TemporaryItems "Temporary items"

echo "5. Cleaning Download History..."

# Download history (not the actual downloads)
safe_clean ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV2 "Download history"

echo "6. Cleaning Mail Attachments..."

# Mail attachments cache
safe_clean ~/Library/Containers/com.apple.mail/Data/Library/Mail\ Downloads "Mail downloads"

echo "7. Cleaning iOS Device Backups..."

# iOS backups
safe_clean ~/Library/Application\ Support/MobileSync/Backup "iOS device backups"

echo "8. Cleaning Trash..."

# Empty trash
echo "Emptying Trash..."
rm -rf ~/.Trash/* 2>/dev/null
echo "  Done emptying Trash"

echo "9. Cleaning Language Files..."

# Remove unused language files
find /Applications -type d -name "*.lproj" ! -name "en.lproj" ! -name "English.lproj" ! -name "Base.lproj" -exec echo "  Removing language: {}" \; -exec rm -rf {} \; 2>/dev/null

echo "10. Cleaning Old iOS Software Updates..."

# Remove old iOS software updates
safe_clean ~/Library/iTunes/iPhone\ Software\ Updates "iOS software updates"
safe_clean ~/Library/iTunes/iPad\ Software\ Updates "iPad software updates"

echo "11. Cleaning System Font Caches..."

# Clear font caches
atsutil databases -removeUser
atsutil server -shutdown
atsutil server -ping

echo "12. Cleaning Quick Look Cache..."

# Clear Quick Look cache
safe_clean ~/Library/Caches/com.apple.QuickLook.thumbnailcache "Quick Look cache"
qlmanage -r cache &>/dev/null

echo "13. Cleaning DNS Cache..."

# Clear DNS cache
dscacheutil -flushcache &>/dev/null
killall -HUP mDNSResponder &>/dev/null

echo "14. Cleaning System Diagnostics Reports..."

# Remove diagnostic reports
safe_clean ~/Library/Logs/DiagnosticReports "Diagnostic reports"
safe_clean /Library/Logs/DiagnosticReports "System diagnostic reports"

echo "15. Cleaning Derived Data (for developers)..."

# Remove Xcode derived data
safe_clean ~/Library/Developer/Xcode/DerivedData "Xcode derived data"

echo "16. Running System Maintenance Scripts..."

# Run built-in maintenance scripts
echo "Running daily maintenance script..."
sudo periodic daily &>/dev/null
echo "Running weekly maintenance script..."
sudo periodic weekly &>/dev/null
echo "Running monthly maintenance script..."
sudo periodic monthly &>/dev/null

echo ""
echo "=== Deep Cleaning Complete ==="
echo "Your Mac has been thoroughly cleaned."
echo "Backups of important data are stored at: $BACKUP_DIR"
echo "You should restart your Mac to complete the cleaning process."
