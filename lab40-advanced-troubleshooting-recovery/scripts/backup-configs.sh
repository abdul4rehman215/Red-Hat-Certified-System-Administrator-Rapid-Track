#!/bin/bash
# System Configuration Backup Script

BACKUP_DIR="/var/backups/system-configs"
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p "$BACKUP_DIR"

tar -czf "$BACKUP_DIR/system-configs-$DATE.tar.gz" \
/etc/systemd/system/ \
/etc/fstab \
/etc/hosts \
/etc/resolv.conf \
/etc/ssh/sshd_config \
2>/dev/null

echo "System configuration backup completed: $BACKUP_DIR/system-configs-$DATE.tar.gz"

cd "$BACKUP_DIR"
ls -t system-configs-*.tar.gz | tail -n +6 | xargs -r rm

echo "Backup cleanup completed"
