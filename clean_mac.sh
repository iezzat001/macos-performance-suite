#!/bin/bash
# MacBook Cleanup Script

echo "Starting MacBook cleanup process..."

# Clear system caches
echo "Clearing system cache files..."
rm -rf ~/Library/Caches/*
rm -rf ~/Library/Logs/*
rm -rf ~/Library/Containers/*/Data/Library/Caches/*

# Clear browser caches
echo "Clearing browser caches..."
# Chrome
rm -rf ~/Library/Caches/Google/Chrome/Default/Cache
rm -rf ~/Library/Caches/Google/Chrome/Default/Code\ Cache
# Brave
rm -rf ~/Library/Caches/com.brave.Browser/Default/Cache
rm -rf ~/Library/Caches/com.brave.Browser/Default/Code\ Cache
# Safari
rm -rf ~/Library/Caches/com.apple.Safari/WebKitCache

# Clear downloads older than 30 days
echo "Clearing old downloads..."
find ~/Downloads -type f -atime +30 -delete

# Clear trash
echo "Emptying trash..."
rm -rf ~/.Trash/*

# Run built-in maintenance scripts
echo "Running system maintenance scripts..."
sudo periodic daily weekly monthly

echo "Cleanup complete!"
