#!/bin/bash
# Personal Backup Script

BACKUP_DIR="$HOME/backups"
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p $BACKUP_DIR

# Backup documents and scripts
tar -czf $BACKUP_DIR/personal_backup_$DATE.tar.gz ~/scripts ~/Documents 2>/dev/null

# Keep only last 5 backups
ls -t $BACKUP_DIR/personal_backup_*.tar.gz | tail -n +6 | xargs -r rm

echo "Personal backup completed at $(date)" >> ~/personal_backup.log
