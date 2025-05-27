#!/bin/bash
# Script to find application residue files
# This script identifies leftover files from deleted applications

echo "=== Application Residue Finder ==="
echo "Searching for leftover files from deleted applications..."
echo ""

# Create a directory to store the results
RESULTS_DIR=~/Desktop/Organized/App_Residue_Results
mkdir -p $RESULTS_DIR

# Get current date for the report filename
CURRENT_DATE=$(date +"%Y-%m-%d")
REPORT_FILE="$RESULTS_DIR/app_residue_report_$CURRENT_DATE.txt"

echo "=== Application Residue Report $(date) ===" > $REPORT_FILE
echo "This report identifies potential leftover files from deleted applications." >> $REPORT_FILE
echo "" >> $REPORT_FILE

# Common locations for application residue
echo "Scanning common locations for application residue..."

# Application Support files
echo "=== Application Support Files ===" >> $REPORT_FILE
find ~/Library/Application\ Support -type d -maxdepth 1 | sort >> $REPORT_FILE
echo "" >> $REPORT_FILE

# Preferences
echo "=== Preference Files ===" >> $REPORT_FILE
find ~/Library/Preferences -name "*.plist" | grep -v "com.apple" | sort >> $REPORT_FILE
echo "" >> $REPORT_FILE

# Caches
echo "=== Cache Files ===" >> $REPORT_FILE
find ~/Library/Caches -type d -maxdepth 1 | sort >> $REPORT_FILE
echo "" >> $REPORT_FILE

# Containers
echo "=== Container Files ===" >> $REPORT_FILE
find ~/Library/Containers -type d -maxdepth 1 | sort >> $REPORT_FILE
echo "" >> $REPORT_FILE

# Application State
echo "=== Application State Files ===" >> $REPORT_FILE
find ~/Library/Saved\ Application\ State -type d -maxdepth 1 | sort >> $REPORT_FILE
echo "" >> $REPORT_FILE

# Launch Agents and Daemons
echo "=== Launch Agents ===" >> $REPORT_FILE
find ~/Library/LaunchAgents -name "*.plist" | sort >> $REPORT_FILE
echo "" >> $REPORT_FILE

# Logs
echo "=== Log Files ===" >> $REPORT_FILE
find ~/Library/Logs -type d -maxdepth 1 | sort >> $REPORT_FILE
echo "" >> $REPORT_FILE

# WebKit data
echo "=== WebKit Data ===" >> $REPORT_FILE
find ~/Library/WebKit -type d -maxdepth 1 2>/dev/null | sort >> $REPORT_FILE
echo "" >> $REPORT_FILE

echo "Report generated at: $REPORT_FILE"
echo ""
echo "Use the cleanup_app_residue.sh script to remove unwanted files."
echo "IMPORTANT: Review the report carefully before deleting any files!"
