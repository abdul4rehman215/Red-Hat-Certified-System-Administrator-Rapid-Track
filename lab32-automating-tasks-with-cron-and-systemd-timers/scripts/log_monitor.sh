#!/bin/bash
# Log Monitor Script with proper logging

LOG_FILE=~/cron_monitor.log

{
    echo "=== Log Monitor Started at $(date) ==="
    
    # Check system load
    LOAD=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | sed 's/,//')
    echo "Current system load: $LOAD"
    
    # Check disk space
    DISK_USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
    echo "Root disk usage: $DISK_USAGE%"
    
    if [ $DISK_USAGE -gt 80 ]; then
        echo "WARNING: Disk usage is above 80%"
    fi
    
    echo "=== Log Monitor Completed at $(date) ==="
    echo ""
} >> $LOG_FILE 2>&1
