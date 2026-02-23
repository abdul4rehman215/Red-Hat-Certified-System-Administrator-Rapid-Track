#!/bin/bash
# System Status Script for systemd

LOG_FILE="/var/log/system-status.log"

{
    echo "=== System Status Report - $(date) ==="
    echo "Hostname: $(hostname)"
    echo "Kernel: $(uname -r)"
    echo "Load Average: $(cat /proc/loadavg)"
    echo "Memory Info:"
    free -h
    echo "Top 5 Processes by CPU:"
    ps aux --sort=-%cpu | head -6
    echo "================================="
    echo ""
} >> $LOG_FILE
