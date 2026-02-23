#!/bin/bash
# Temporary Files Cleanup Script

LOG_FILE="/var/log/temp-cleanup.log"

{
    echo "=== Temp Cleanup Started - $(date) ==="
    
    # Clean /tmp files older than 7 days
    DELETED_COUNT=$(find /tmp -type f -mtime +7 -delete -print | wc -l)
    echo "Deleted $DELETED_COUNT files from /tmp"
    
    # Clean log files older than 30 days
    find /var/log -name "*.log" -mtime +30 -size +100M -exec truncate -s 0 {} \;
    echo "Truncated large old log files"
    
    # Clean package cache
    if command -v dnf &> /dev/null; then
        dnf clean packages -q
        echo "Cleaned DNF package cache"
    elif command -v yum &> /dev/null; then
        yum clean packages -q
        echo "Cleaned YUM package cache"
    fi
    
    echo "=== Temp Cleanup Completed - $(date) ==="
    echo ""
} >> $LOG_FILE 2>&1
