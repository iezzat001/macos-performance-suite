    "Critical_App.app"
    "System_Essential.app"
    # Add apps you want to protect from cleanup
)

# Browser Process Limits
MAX_CHROME_PROCESSES=15
MAX_BRAVE_PROCESSES=10
MAX_SAFARI_PROCESSES=5
MAX_EDGE_PROCESSES=10

# Scheduled Maintenance Times
WEEKLY_MAINTENANCE_DAY="Monday"
WEEKLY_MAINTENANCE_HOUR=9
MONTHLY_MAINTENANCE_DAY=1
MONTHLY_MAINTENANCE_HOUR=9

# Report Configuration
GENERATE_DETAILED_REPORTS=true
INCLUDE_SYSTEM_INFO=true
INCLUDE_PROCESS_LIST=false  # Set to false to avoid personal info in reports
INCLUDE_FILE_LISTINGS=false

# Development/Debug Settings
DEBUG_MODE=false
VERBOSE_LOGGING=false
DRY_RUN_MODE=false  # Set to true to simulate operations without making changes

# Example Usage in Scripts:
# source config.sh
# if [ "$ENABLE_LOGGING" = true ]; then
#     echo "$(date): Operation started" >> "$LOGS_DIR/script.log"
# fi