#!/bin/bash
# Screenshot Manager Script
# This script automatically compresses screenshots and archives old ones
# Set as a daily cron job for automated management

# Define paths
SCREENSHOTS_DIR="/Users/iEzzat/Desktop/Organized/Screenshots"
ARCHIVE_DIR="/Users/iEzzat/Desktop/Organized/Screenshots_Archive"
LOGS_DIR="/Users/iEzzat/Desktop/Organized/Maintenance_Logs"
mkdir -p "$SCREENSHOTS_DIR" "$ARCHIVE_DIR" "$LOGS_DIR"

# Log file
LOG_FILE="$LOGS_DIR/screenshot_manager_$(date +"%Y-%m-%d").log"
exec > >(tee -a "$LOG_FILE") 2>&1

echo "Screenshot Manager Started: $(date)"
echo "==============================="

# Function to compress PNG files
compress_png() {
    local file="$1"
    local filename=$(basename "$file")
    
    # Check if the file is already compressed (has "_compressed" in name)
    if [[ "$filename" == *"_compressed"* ]]; then
        echo "File already compressed: $filename"
        return 0
    fi
    
    # Get file size before compression
    local size_before=$(du -h "$file" | cut -f1)
    
    # Get file base name and directory
    local dir=$(dirname "$file")
    local base_name="${filename%.*}"
    
    # Create compressed version
    echo "Compressing: $filename (Original: $size_before)"
    
    # Use sips for compression (native macOS tool)
    sips -s format png --setProperty formatOptions 80 "$file" --out "${dir}/${base_name}_compressed.png" &>/dev/null
    
    # Get file size after compression
    local size_after=$(du -h "${dir}/${base_name}_compressed.png" | cut -f1)
    
    echo "  Compressed: ${base_name}_compressed.png (New: $size_after)"
    
    # Remove original if compressed version exists
    if [ -f "${dir}/${base_name}_compressed.png" ]; then
        rm "$file"
        echo "  Original removed"
    fi
}

# Function to archive old screenshots (older than 30 days)
archive_old_screenshots() {
    local days_old=30
    echo "Archiving screenshots older than $days_old days..."
    
    # Create dated folder in archive directory
    local archive_date=$(date +"%Y-%m")
    local dated_archive="$ARCHIVE_DIR/$archive_date"
    mkdir -p "$dated_archive"
    
    # Find and move old screenshots
    find "$SCREENSHOTS_DIR" -type f -name "*.png" -mtime +$days_old -print0 | while IFS= read -r -d '' file; do
        local filename=$(basename "$file")
        echo "Archiving: $filename"
        mv "$file" "$dated_archive/"
        echo "  Moved to: $dated_archive/$filename"
    done
}

# Compress existing screenshots in Screenshots folder
echo "Processing screenshots in main folder..."
find "$SCREENSHOTS_DIR" -type f -name "*.png" -not -name "*_compressed*" -print0 | while IFS= read -r -d '' file; do
    compress_png "$file"
done

# Compress existing screenshots in Archive folder (if not already compressed)
echo "Processing screenshots in archive folder..."
find "$ARCHIVE_DIR" -type f -name "*.png" -not -name "*_compressed*" -print0 | while IFS= read -r -d '' file; do
    compress_png "$file"
done

# Archive old screenshots
archive_old_screenshots

echo "==============================="
echo "Screenshot Manager Completed: $(date)"
echo "Log saved to: $LOG_FILE"
