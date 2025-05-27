#!/bin/bash
# Setup Script for macOS Performance Optimization Suite
# This script prepares the system for using the maintenance scripts

echo "🚀 macOS Performance Optimization Suite Setup"
echo "=============================================="

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ Error: This script is designed for macOS only."
    exit 1
fi

# Get current directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "📁 Setup directory: $SCRIPT_DIR"

# Create necessary directories
echo "📂 Creating directory structure..."
mkdir -p "$SCRIPT_DIR/Maintenance_Logs"
mkdir -p "$SCRIPT_DIR/Performance_Reports"
mkdir -p "$SCRIPT_DIR/System_Cleaning_Backups"
mkdir -p "$SCRIPT_DIR/App_Residue_Backups"

# Make all scripts executable
echo "🔧 Making scripts executable..."
chmod +x "$SCRIPT_DIR"/*.sh

# Create configuration file from template
if [ ! -f "$SCRIPT_DIR/config.sh" ]; then
    echo "⚙️ Creating configuration file..."
    cp "$SCRIPT_DIR/config_template.sh" "$SCRIPT_DIR/config.sh"
    
    # Get current username and update config
    CURRENT_USER=$(whoami)
    sed -i.bak "s/your_username/$CURRENT_USER/g" "$SCRIPT_DIR/config.sh"
    rm "$SCRIPT_DIR/config.sh.bak"
    
    echo "✅ Configuration file created: config.sh"
    echo "📝 Please review and customize the configuration file for your system."
else
    echo "⚠️ Configuration file already exists. Skipping creation."
fi

# Check system requirements
echo "🔍 Checking system requirements..."

# Check macOS version
MACOS_VERSION=$(sw_vers -productVersion)
echo "📱 macOS Version: $MACOS_VERSION"

# Check available disk space
AVAILABLE_SPACE=$(df -h "$HOME" | awk 'NR==2{print $4}')
echo "💾 Available Space: $AVAILABLE_SPACE"

# Check if fswatch is available (for screenshot monitoring)
if command -v fswatch &> /dev/null; then
    echo "✅ fswatch is available"
else
    echo "⚠️ fswatch not found. Screenshot auto-compression may use polling method."
    echo "   To install fswatch: brew install fswatch"
fi

# Test basic script functionality
echo "🧪 Testing basic functionality..."
if ./system_monitor.sh > /tmp/test_output 2>&1; then
    echo "✅ System monitor test passed"
    rm -f /tmp/test_output
else
    echo "⚠️ System monitor test failed. Check permissions."
fi

# Offer to run initial performance report
echo ""
read -p "📊 Would you like to generate an initial performance report? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🔄 Generating initial performance report..."
    ./generate_performance_report.sh
    echo "✅ Initial report generated!"
fi

# Offer to set up automated reminders
echo ""
read -p "⏰ Would you like to set up maintenance reminders? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "📅 Setting up maintenance reminders..."
    
    # Add to crontab
    (crontab -l 2>/dev/null; echo "# macOS Performance Suite - Weekly Reminder"; echo "0 9 * * 1 '$SCRIPT_DIR/maintenance_reminder.sh weekly'") | crontab -
    (crontab -l 2>/dev/null; echo "# macOS Performance Suite - Monthly Reminder"; echo "0 9 1 * * '$SCRIPT_DIR/maintenance_reminder.sh monthly'") | crontab -
    
    echo "✅ Maintenance reminders configured!"
    echo "   Weekly: Mondays at 9 AM"
    echo "   Monthly: 1st of each month at 9 AM"
fi

# Setup complete
echo ""
echo "🎉 Setup Complete!"
echo "=================="
echo ""
echo "📋 Available Scripts:"
echo "   ./clean_mac.sh                 - Quick system cleanup"
echo "   ./deep_clean_mac.sh           - Comprehensive cleaning"
echo "   ./monthly_maintenance.sh       - Full monthly maintenance"
echo "   ./browser_memory_optimizer.sh  - Optimize browser memory"
echo "   ./generate_performance_report.sh - Create performance report"
echo "   ./maintenance_reminder.sh      - Manual reminders"
echo ""
echo "🚀 Recommended First Steps:"
echo "1. Review configuration: nano config.sh"
echo "2. Run initial cleanup: ./clean_mac.sh"
echo "3. Generate report: ./generate_performance_report.sh"
echo "4. Set up monthly deep clean: ./monthly_maintenance.sh"
echo ""
echo "📚 Documentation: See README.md for detailed usage instructions"
echo ""
echo "⚠️ Important: Always backup important data before running cleanup scripts!"