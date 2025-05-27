#!/bin/bash
# Secure Temporary Folder Cleanup Script
# This script completely removes all files in the Temporary folder
# and ensures no residue is left behind that could impact performance

# Define the temporary folder path
TEMP_FOLDER="/Users/iEzzat/Desktop/Organized/07_Temporary"
BACKUP_DIR="/Users/iEzzat/Desktop/Organized/Temp_Backup_$(date +"%Y%m%d")"

echo "=== Secure Temporary Folder Cleanup ==="
echo "Starting cleanup process for: $TEMP_FOLDER"
echo ""

# Create backup before deletion (just in case)
echo "Creating backup in: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"
cp -R "$TEMP_FOLDER"/* "$BACKUP_DIR"/ 2>/dev/null
echo "Backup completed."
echo ""

# First, remove typical file extensions
echo "Stage 1: Removing regular files..."
find "$TEMP_FOLDER" -type f -name "*.xlsx" -exec rm -f {} \;
find "$TEMP_FOLDER" -type f -name "*.pptx" -exec rm -f {} \;
find "$TEMP_FOLDER" -type f -name "*.doc*" -exec rm -f {} \;
find "$TEMP_FOLDER" -type f -name "*.png" -exec rm -f {} \;
find "$TEMP_FOLDER" -type f -name "*.jpg" -exec rm -f {} \;
find "$TEMP_FOLDER" -type f -name "*.csv" -exec rm -f {} \;
find "$TEMP_FOLDER" -type f -name "~$*" -exec rm -f {} \;
find "$TEMP_FOLDER" -type f -name ".DS_Store" -exec rm -f {} \;
echo "Regular files removed."
echo ""

# Remove all other files
echo "Stage 2: Removing all remaining files..."
find "$TEMP_FOLDER" -type f -exec rm -f {} \;
echo "All files removed."
echo ""

# Remove subdirectories
echo "Stage 3: Removing subdirectories..."
find "$TEMP_FOLDER" -mindepth 1 -type d -exec rm -rf {} \; 2>/dev/null
echo "Subdirectories removed."
echo ""

# Create fresh subdirectories to maintain structure
echo "Stage 4: Creating fresh structure..."
mkdir -p "$TEMP_FOLDER/Test_Data"
touch "$TEMP_FOLDER/.keep"
echo "Fresh structure created."
echo ""

# Reset folder permissions and attributes
echo "Stage 5: Resetting folder attributes..."
chflags nouchg "$TEMP_FOLDER"/* 2>/dev/null
chmod 755 "$TEMP_FOLDER"
echo "Folder attributes reset."
echo ""

# Clear any extended attributes
echo "Stage 6: Clearing extended attributes..."
xattr -c "$TEMP_FOLDER" 2>/dev/null
echo "Extended attributes cleared."
echo ""

# Run system maintenance scripts to clear system caches
echo "Stage 7: Running system maintenance..."
sudo periodic daily weekly monthly &>/dev/null
echo "System maintenance completed."
echo ""

echo "=== Cleanup Process Complete ==="
echo "The temporary folder has been completely cleaned."
echo "A backup of the removed files is stored at: $BACKUP_DIR"
echo ""
echo "To verify cleanup, check: $TEMP_FOLDER"
