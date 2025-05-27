#!/bin/bash
# Browser Memory Optimizer Script
# This script optimizes browser memory usage and performance

echo "=== Browser Memory Optimizer ==="
echo "Starting browser optimization..."
echo ""

# Function to count browser processes
count_browser_processes() {
    echo "Current browser process count:"
    echo "Chrome processes: $(ps aux | grep -i chrome | grep -v grep | wc -l)"
    echo "Brave processes: $(ps aux | grep -i brave | grep -v grep | wc -l)"
    echo ""
}

# Show current browser memory usage
show_browser_memory() {
    echo "Top memory-consuming browser processes:"
    ps aux | grep -E "(Chrome|Brave)" | grep -v grep | sort -k4 -nr | head -5 | awk '{print $4"% - "$11" "$12" "$13}' 
    echo ""
}

count_browser_processes
show_browser_memory

echo "Optimization recommendations:"
echo "1. Close unnecessary browser tabs"
echo "2. Use one primary browser (Chrome OR Brave)"
echo "3. Enable Chrome's memory saver feature"
echo "4. Clear browser caches regularly"
echo ""

# Clear browser caches
echo "Clearing browser caches..."
rm -rf ~/Library/Caches/Google/Chrome/Default/Cache/* 2>/dev/null
rm -rf ~/Library/Caches/com.brave.Browser/Default/Cache/* 2>/dev/null
rm -rf ~/Library/Caches/com.microsoft.edgemac/Default/Cache/* 2>/dev/null
echo "Browser caches cleared."
echo ""

# Chrome memory optimization
echo "Applying Chrome memory optimizations..."
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool false
echo "Chrome memory optimizations applied."
echo ""

echo "=== Browser Optimization Complete ==="
echo "Recommendation: Restart your browsers to apply changes."
