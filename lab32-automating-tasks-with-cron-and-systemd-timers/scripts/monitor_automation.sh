#!/bin/bash
# Automation Monitoring Script

REPORT_FILE=~/automation_report.log

{
    echo "=== Automation Status Report - $(date) ==="
    
    echo "--- Cron Jobs Status ---"
    echo "Active crontab entries:"
    crontab -l | grep -v '^#' | grep -v '^$' | wc -l
    
    echo "--- systemd Timers Status ---"
    echo "Active timers:"
    systemctl list-timers --no-pager | grep -c "timer"
    
    echo "--- Log File Sizes ---"
    ls -lh ~/system_reports.log ~/cron_monitor.log ~/backup.log 2>/dev/null
    
    echo "=== End Automation Report ==="
    echo ""
} >> $REPORT_FILE 2>&1
