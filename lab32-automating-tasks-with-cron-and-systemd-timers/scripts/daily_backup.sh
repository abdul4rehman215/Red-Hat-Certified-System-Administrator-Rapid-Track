#!/bin/bash
# Daily Backup Script

BACKUP_DIR="/tmp/backups"
DATE=$(date +%Y%m%d_%H%M%S)

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Backup important directories
tar -czf $BACKUP_DIR/home_backup_$DATE.tar.gz ~/scripts ~/system_reports.log 2>/dev/null

# Keep only last 7 days of backups
find $BACKUP_DIR -name "home_backup_*.tar.gz" -mtime +7 -delete

echo "Backup completed at $(date)" >> ~/backup.log
