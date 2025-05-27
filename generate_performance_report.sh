#!/bin/bash
# Performance Report Generator
# This script generates comprehensive performance reports for tracking system health

# Define paths
SCRIPT_DIR="/Users/iEzzat/Desktop/Organized/Maintenance_Scripts"
REPORTS_DIR="$SCRIPT_DIR/Performance_Reports"
LOG_DIR="$SCRIPT_DIR/Maintenance_Logs"

# Create directories if they don't exist
mkdir -p "$REPORTS_DIR" "$LOG_DIR"

# Generate report filename with current date
CURRENT_DATE=$(date +"%Y-%m-%d")
REPORT_FILE="$REPORTS_DIR/Performance_Report_$CURRENT_DATE.md"

echo "=== Generating Performance Report ==="
echo "Report will be saved to: $REPORT_FILE"

# Start generating the report
cat > "$REPORT_FILE" << 'EOF'
# macOS Performance Report
EOF

echo "Generated: $(date)" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# System Information
echo "## System Information" >> "$REPORT_FILE"
system_profiler SPHardwareDataType SPSoftwareDataType | grep -E "(Model Name|Chip|Memory|System Version|Time since boot)" | sed 's/^/- **/' | sed 's/:/**: /' >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Storage Analysis
echo "## Storage Analysis" >> "$REPORT_FILE"
echo "### Current Status" >> "$REPORT_FILE"
df -h | grep "/dev/disk3s5" | awk '{
    used_percent = substr($5, 1, length($5)-1)
    if (used_percent > 80) status = "🔴 CRITICAL"
    else if (used_percent > 70) status = "⚠️ WARNING" 
    else status = "✅ HEALTHY"
    print "- **Total Storage**: " $2
    print "- **Used Space**: " $3 " (" $5 " full) " status
    print "- **Free Space**: " $4 " (" (100-used_percent) "% free)"
}' >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Memory Analysis  
echo "## Memory Analysis" >> "$REPORT_FILE"
echo "### Memory Statistics" >> "$REPORT_FILE"
vm_stat | awk '
BEGIN { page_size = 16384; total_pages = 0; free_pages = 0; compressed = 0 }
/Pages free/ { free_pages = $3 }
/Pages stored in compressor/ { compressed = $6 }
/Swapins/ { swapins = $2 }
/Swapouts/ { swapouts = $2 }
END {
    if (swapins > 1000000 || swapouts > 1000000) swap_status = "🔴 HIGH PRESSURE"
    else if (swapins > 100000 || swapouts > 100000) swap_status = "⚠️ MODERATE PRESSURE"
    else swap_status = "✅ NORMAL"
    print "- **Free Pages**: " free_pages
    print "- **Compressed Pages**: " compressed  
    print "- **Swap Activity**: " swapins " ins / " swapouts " outs " swap_status
}' >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Process Analysis
echo "## Process Analysis" >> "$REPORT_FILE"
echo "### Browser Process Count" >> "$REPORT_FILE"
CHROME_PROCESSES=$(ps aux | grep -i chrome | grep -v grep | wc -l)
BRAVE_PROCESSES=$(ps aux | grep -i brave | grep -v grep | wc -l)
TOTAL_BROWSER_PROCESSES=$((CHROME_PROCESSES + BRAVE_PROCESSES))

if [ $TOTAL_BROWSER_PROCESSES -gt 50 ]; then
    BROWSER_STATUS="🔴 CRITICAL"
elif [ $TOTAL_BROWSER_PROCESSES -gt 30 ]; then
    BROWSER_STATUS="⚠️ WARNING"
else
    BROWSER_STATUS="✅ GOOD"
fi

echo "- **Chrome Processes**: $CHROME_PROCESSES" >> "$REPORT_FILE"
echo "- **Brave Processes**: $BRAVE_PROCESSES" >> "$REPORT_FILE"
echo "- **Total Browser Processes**: $TOTAL_BROWSER_PROCESSES $BROWSER_STATUS" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Top Memory Consumers
echo "### Top Memory Consumers" >> "$REPORT_FILE"
ps aux | sort -k4 -nr | head -5 | awk '{print NR ". " $11 ": " $4 "% memory usage"}' >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Performance Health Score
echo "## Performance Health Score" >> "$REPORT_FILE"
STORAGE_PERCENT=$(df -h | grep "/dev/disk3s5" | awk '{print substr($5, 1, length($5)-1)}')

# Calculate scores
if [ "$STORAGE_PERCENT" -lt 60 ]; then STORAGE_SCORE="A"; elif [ "$STORAGE_PERCENT" -lt 70 ]; then STORAGE_SCORE="B"; elif [ "$STORAGE_PERCENT" -lt 80 ]; then STORAGE_SCORE="C"; else STORAGE_SCORE="D"; fi

if [ "$TOTAL_BROWSER_PROCESSES" -lt 20 ]; then MEMORY_SCORE="A"; elif [ "$TOTAL_BROWSER_PROCESSES" -lt 30 ]; then MEMORY_SCORE="B"; elif [ "$TOTAL_BROWSER_PROCESSES" -lt 50 ]; then MEMORY_SCORE="C"; else MEMORY_SCORE="D"; fi

echo "- **Storage Health**: $STORAGE_SCORE ($STORAGE_PERCENT% usage)" >> "$REPORT_FILE"
echo "- **Memory Health**: $MEMORY_SCORE ($TOTAL_BROWSER_PROCESSES browser processes)" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Recommendations
echo "## Recommendations" >> "$REPORT_FILE"
if [ "$STORAGE_PERCENT" -gt 70 ]; then
    echo "- 🔧 **Storage**: Clean up files to reduce usage below 70%" >> "$REPORT_FILE"
fi
if [ "$TOTAL_BROWSER_PROCESSES" -gt 30 ]; then
    echo "- 🌐 **Browsers**: Reduce browser processes by consolidating to single browser" >> "$REPORT_FILE"
fi
echo "- 📅 **Next Report**: $(date -j -v+1w +"%Y-%m-%d")" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo "---" >> "$REPORT_FILE"
echo "**Report Generated**: $(date)" >> "$REPORT_FILE"

echo "✅ Performance report generated successfully!"
echo "📄 Report saved to: $REPORT_FILE"