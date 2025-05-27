#!/bin/bash
# Auto Screenshot Compressor
# This script watches the Screenshots directory and automatically compresses new screenshots
# It should be run in the background using launchd

# Define paths
SCREENSHOTS_DIR="/Users/iEzzat/Desktop/Organized/Screenshots"
LOGS_DIR="/Users/iEzzat/Desktop/Organized/Maintenance_Logs"
mkdir -p "$SCREENSHOTS_DIR" "$LOGS_DIR"

# Log file
LOG_FILE="$LOGS_DIR/auto_screenshot_compressor.log"

# Make sure the screenshots directory exists
if [ ! -d "$SCREENSHOTS_DIR" ]; then
    mkdir -p "$SCREENSHOTS_DIR"
    echo "$(date): Created screenshots directory at $SCREENSHOTS_DIR" >> "$LOG_FILE"
fi

# Function to compress a PNG file
compress_png() {
    local file="$1"
    local filename=$(basename "$file")
    
    # Only process new screenshots (not already compressed ones)
    if [[ "$filename" == *"_compressed"* ]]; then
        return 0
    fi
    
    # Wait a moment to ensure the file is completely written
    sleep 1
    
    # Get file size before compression
    local size_before=$(du -h "$file" | cut -f1)
    
    # Get file base name and directory
    local dir=$(dirname "$file")
    local base_name="${filename%.*}"
    
    # Create compressed version
    echo "$(date): Compressing: $filename (Original: $size_before)" >> "$LOG_FILE"
    
    # Use sips for compression (native macOS tool)
    sips -s format png --setProperty formatOptions 80 "$file" --out "${dir}/${base_name}_compressed.png" &>/dev/null
    
    # Get file size after compression
    local size_after=$(du -h "${dir}/${base_name}_compressed.png" | cut -f1)
    
    echo "$(date):   Compressed: ${base_name}_compressed.png (New: $size_after)" >> "$LOG_FILE"
    
    # Remove original if compressed version exists
    if [ -f "${dir}/${base_name}_compressed.png" ]; then
        rm "$file"
        echo "$(date):   Original removed" >> "$LOG_FILE"
    fi
}

# Use fswatch to monitor the directory for new files
echo "$(date): Starting screenshot monitoring service..." >> "$LOG_FILE"
echo "$(date): Watching directory: $SCREENSHOTS_DIR" >> "$LOG_FILE"

# Check if fswatch is installed
if ! command -v fswatch &> /dev/null; then
    echo "$(date): fswatch is not installed. Please install it using Homebrew:" >> "$LOG_FILE"
    echo "$(date): brew install fswatch" >> "$LOG_FILE"
    echo "$(date): For now, will use a polling method instead" >> "$LOG_FILE"
    
    # Polling method as fallback
    while true; do
        find "$SCREENSHOTS_DIR" -type f -name "*.png" -not -name "*_compressed*" -mmin -1 -print0 | while IFS= read -r -d '' file; do
            compress_png "$file"
        done
        sleep 5
    done
else
    # Use fswatch for real-time monitoring
    fswatch -0 -e ".*_compressed.*" -e ".*/.DS_Store" --event Created "$SCREENSHOTS_DIR" | while read -d "" file; do
        if [[ "$file" == *.png && "$file" != *"_compressed"* ]]; then
            compress_png "$file"
        fi
    done
fi
