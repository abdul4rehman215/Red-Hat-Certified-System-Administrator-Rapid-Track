#!/bin/bash
# System Information Script

echo "=== System Information Report ===" >> ~/system_reports.log
echo "Date: $(date)" >> ~/system_reports.log
echo "Uptime: $(uptime)" >> ~/system_reports.log
echo "Disk Usage:" >> ~/system_reports.log
df -h >> ~/system_reports.log
echo "Memory Usage:" >> ~/system_reports.log
free -h >> ~/system_reports.log
echo "=================================" >> ~/system_reports.log
echo "" >> ~/system_reports.log
