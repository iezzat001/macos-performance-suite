#!/bin/bash
# Weekly and Monthly Maintenance Reminder Script
# This script sends notifications for scheduled maintenance

# Configuration
SCRIPT_DIR="/Users/iEzzat/Desktop/Organized/Maintenance_Scripts"
LOGS_DIR="$SCRIPT_DIR/Maintenance_Logs"
REMINDER_TYPE="$1"  # "weekly" or "monthly"

# Create logs directory if it doesn't exist
mkdir -p "$LOGS_DIR"

# Function to send notification
send_notification() {
    local title="$1"
    local message="$2"
    local sound="$3"
    
    # Use macOS notification system
    osascript -e "display notification \"$message\" with title \"$title\" sound name \"$sound\""
    
    # Also log the reminder
    echo "$(date): $title - $message" >> "$LOGS_DIR/maintenance_reminders.log"
}

# Function to check system health quickly
quick_health_check() {
    local storage_percent=$(df -h | grep "/dev/disk3s5" | awk '{print substr($5, 1, length($5)-1)}')
    local browser_processes=$(ps aux | grep -E "(chrome|brave)" | grep -v grep | wc -l)
    
    if [ "$storage_percent" -gt 75 ]; then
        send_notification "⚠️ Storage Warning" "Storage is at ${storage_percent}% - cleanup recommended" "Basso"
    fi
    
    if [ "$browser_processes" -gt 50 ]; then
        send_notification "🌐 Browser Warning" "Too many browser processes (${browser_processes}) - consider consolidation" "Funk"
    fi
}

# Weekly maintenance reminder
weekly_maintenance() {
    echo "=== Weekly Maintenance Reminder ==="
    
    send_notification "📅 Weekly Maintenance" "Time for your weekly Mac maintenance checkup!" "Glass"
    
    echo "Weekly maintenance tasks:"
    echo "1. Run system cleanup"
    echo "2. Check browser processes"
    echo "3. Monitor storage usage"
    echo "4. Generate performance report"
    
    # Quick health check
    quick_health_check
    
    # Suggest running maintenance script
    echo ""
    echo "🔧 To run weekly maintenance:"
    echo "cd '$SCRIPT_DIR' && ./clean_mac.sh"
    echo ""
    echo "📊 To generate performance report:"
    echo "cd '$SCRIPT_DIR' && ./generate_performance_report.sh"
}

# Monthly maintenance reminder
monthly_maintenance() {
    echo "=== Monthly Maintenance Reminder ==="
    
    send_notification "📅 Monthly Maintenance" "Time for comprehensive monthly Mac maintenance!" "Submarine"
    
    echo "Monthly maintenance tasks:"
    echo "1. Deep system cleaning"
    echo "2. Application residue cleanup"
    echo "3. Startup items review"
    echo "4. Performance optimization"
    echo "5. Comprehensive system report"
    
    # Quick health check
    quick_health_check
    
    # Suggest running maintenance script
    echo ""
    echo "🔧 To run monthly maintenance:"
    echo "cd '$SCRIPT_DIR' && ./monthly_maintenance.sh"
    echo ""
    echo "🧹 For deep cleaning:"
    echo "cd '$SCRIPT_DIR' && ./deep_clean_mac.sh"
    echo ""
    echo "📊 To generate comprehensive report:"
    echo "cd '$SCRIPT_DIR' && ./generate_performance_report.sh"
}

# Main execution
case "$REMINDER_TYPE" in
    "weekly")
        weekly_maintenance
        ;;
    "monthly")
        monthly_maintenance
        ;;
    *)
        echo "Usage: $0 [weekly|monthly]"
        echo ""
        echo "This script sends maintenance reminders and performs quick health checks."
        echo ""
        echo "Examples:"
        echo "  $0 weekly   - Send weekly maintenance reminder"
        echo "  $0 monthly  - Send monthly maintenance reminder"
        echo ""
        echo "To set up automated reminders, add to crontab:"
        echo "# Weekly reminder (Mondays at 9 AM)"
        echo "0 9 * * 1 '$SCRIPT_DIR/maintenance_reminder.sh weekly'"
        echo ""
        echo "# Monthly reminder (1st of month at 9 AM)"  
        echo "0 9 1 * * '$SCRIPT_DIR/maintenance_reminder.sh monthly'"
        exit 1
        ;;
esac

echo "✅ Maintenance reminder completed at $(date)"