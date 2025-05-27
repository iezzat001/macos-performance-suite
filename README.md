# 🚀 macOS Performance Optimization Suite

A comprehensive collection of bash scripts for maintaining and optimizing macOS performance, specifically designed for MacBook Air M1 but compatible with most macOS systems.

## 📋 Overview

This suite provides automated tools for:
- 🧹 **Deep System Cleaning** - Remove unnecessary files and caches
- 📊 **Performance Monitoring** - Track system health over time  
- 🔧 **Browser Optimization** - Manage memory-heavy browser processes
- 📱 **Screenshot Management** - Automated compression and organization
- ⚡ **Startup Optimization** - Manage and disable unnecessary startup items
- 📈 **Automated Reporting** - Generate detailed performance reports

## 🎯 Key Features

- **Safe Operation**: All scripts create backups before making changes
- **Comprehensive Cleaning**: Removes language files, caches, logs, and temporary data
- **Memory Optimization**: Reduces browser memory usage and system pressure
- **Automated Maintenance**: Scheduled tasks for ongoing optimization
- **Performance Tracking**: Detailed reports with health scores
- **Notification System**: Reminders for regular maintenance

## 📂 Script Collection

### Core Maintenance Scripts
- `deep_clean_mac.sh` - Comprehensive system cleaning with backup
- `clean_mac.sh` - Regular system cleanup for routine maintenance
- `monthly_maintenance.sh` - Complete monthly optimization routine
- `system_monitor.sh` - Real-time system performance monitoring

### Specialized Tools
- `browser_memory_optimizer.sh` - Optimize browser memory usage
- `screenshot_manager.sh` - Automated screenshot compression and archiving
- `auto_screenshot_compressor.sh` - Real-time screenshot compression service
- `find_app_residue.sh` - Identify leftover files from deleted applications
- `cleanup_app_residue.sh` - Remove application residue safely
- `secure_temp_cleanup.sh` - Clean temporary folders securely

### Management Tools  
- `disable_all_startup_items.sh` - Manage startup applications
- `generate_performance_report.sh` - Create detailed system reports
- `maintenance_reminder.sh` - Automated maintenance notifications

## 🚀 Quick Start

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd macOS-Performance-Suite
   ```

2. **Make scripts executable**:
   ```bash
   chmod +x *.sh
   ```

3. **Run initial deep clean**:
   ```bash
   ./deep_clean_mac.sh
   ```

4. **Generate performance report**:
   ```bash
   ./generate_performance_report.sh
   ```

## 📊 Usage Examples

### Basic System Cleanup
```bash
# Quick daily cleanup
./clean_mac.sh

# Comprehensive monthly cleanup  
./monthly_maintenance.sh

# Deep cleaning with language file removal
./deep_clean_mac.sh
```

### Performance Monitoring
```bash
# Generate current performance report
./generate_performance_report.sh

# Monitor system in real-time
./system_monitor.sh

# Check for application residue
./find_app_residue.sh
```

### Browser Optimization
```bash
# Optimize browser memory usage
./browser_memory_optimizer.sh

# Check browser process count
ps aux | grep -E "(chrome|brave)" | wc -l
```

## 🔧 Configuration

### Automated Screenshots
The suite includes automated screenshot compression:
- `com.iEzzat.screenshot-manager.plist` - Daily screenshot management
- `com.iEzzat.auto-screenshot-compressor.plist` - Real-time compression

### Setting Up Automation
```bash
# Copy LaunchDaemons for automation
sudo cp *.plist /Library/LaunchDaemons/
sudo launchctl load /Library/LaunchDaemons/com.iEzzat.screenshot-manager.plist
```

### Maintenance Reminders
```bash
# Set up weekly reminders (add to crontab)
crontab -e
# Add: 0 9 * * 1 /path/to/maintenance_reminder.sh weekly

# Set up monthly reminders  
# Add: 0 9 1 * * /path/to/maintenance_reminder.sh monthly
```

## 📈 Performance Impact

Typical results from optimization:
- **Storage Recovery**: 15-20GB freed up
- **Memory Pressure**: 50-70% reduction
- **Browser Processes**: Reduced from 80+ to <30
- **Boot Time**: Improved startup speed
- **App Launch**: Faster application loading

## ⚠️ Safety Features

- **Automatic Backups**: All operations create safety backups
- **Logging**: Comprehensive logs of all operations
- **Safe Defaults**: Conservative settings to prevent system damage
- **Rollback Capability**: Easy restoration if needed

## 🔒 Privacy & Security

- Scripts operate locally only
- No data transmitted externally  
- Personal information filtered from logs
- Safe handling of system files

## 💡 Best Practices

1. **Run scripts in order**: Start with `clean_mac.sh`, then `deep_clean_mac.sh`
2. **Regular maintenance**: Weekly cleanup, monthly deep clean
3. **Monitor reports**: Check performance trends monthly
4. **Browser hygiene**: Consolidate to single browser when possible
5. **System restarts**: Restart weekly to clear memory pressure

## 🛠️ Troubleshooting

### Common Issues
- **Permission errors**: Run with appropriate permissions
- **Script failures**: Check logs in Maintenance_Logs directory
- **Storage still full**: Run `find_app_residue.sh` for additional cleanup

### Support
- Check logs in `Maintenance_Logs/` directory
- Review generated performance reports
- Ensure adequate disk space before running scripts

## 📋 Requirements

- macOS 10.15+ (optimized for macOS Sonoma)
- Bash shell environment
- Administrative privileges for some operations
- Minimum 10GB free space for safe operation

## 🤝 Contributing

Contributions welcome! Please:
1. Test scripts thoroughly
2. Follow existing code style
3. Add appropriate error handling
4. Update documentation

## 📄 License

MIT License - see LICENSE file for details

## ⭐ Acknowledgments

Created for optimizing MacBook Air M1 performance, with focus on:
- Memory pressure reduction
- Storage optimization  
- Browser performance improvement
- Automated maintenance workflows

---

**⚡ Transform your Mac's performance with automated optimization!**