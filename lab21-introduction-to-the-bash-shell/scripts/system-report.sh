#!/bin/bash
# System Information Report Script

echo "=================================="
echo " SYSTEM INFORMATION REPORT"
echo "=================================="
echo

echo "Date and Time: $(date)"
echo "Hostname: $(hostname)"
echo "Current User: $(whoami)"
echo "Current Directory: $(pwd)"
echo

echo "System Uptime:"
uptime
echo

echo "Disk Usage:"
df -h | head -5
echo

echo "Memory Usage:"
free -h
echo

echo "Number of files in current directory: $(ls | wc -l)"
echo "=================================="
