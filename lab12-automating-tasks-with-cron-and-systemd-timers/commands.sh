#!/bin/bash
# Lab 32 - Automating Tasks with Cron and systemd Timers
# Commands Executed During Lab
# Environment: CentOS/RHEL 8/9
# User: centos

# ==============================
# TASK 1 - CRON JOBS
# ==============================

sudo systemctl status crond
sudo systemctl start crond
sudo systemctl enable crond

crontab -l
ls -la /etc/cron*
cat /etc/crontab

mkdir -p ~/scripts
nano ~/scripts/system_info.sh
chmod +x ~/scripts/system_info.sh
~/scripts/system_info.sh
cat ~/system_reports.log

export EDITOR=nano
crontab -e
crontab -l

nano ~/scripts/daily_backup.sh
chmod +x ~/scripts/daily_backup.sh
crontab -e

nano ~/scripts/log_monitor.sh
chmod +x ~/scripts/log_monitor.sh
crontab -e
crontab -l

# ==============================
# TASK 2 - SYSTEMD TIMERS
# ==============================

systemctl list-timers
systemctl list-timers --all
ls -la /etc/systemd/system/*.timer
ls -la /usr/lib/systemd/system/*.timer | head

sudo tee /etc/systemd/system/system-status.service << 'EOF'
[Unit]
Description=System Status Reporter
Wants=system-status.timer

[Service]
Type=oneshot
User=root
ExecStart=/usr/local/bin/system-status.sh

[Install]
WantedBy=multi-user.target
EOF

sudo tee /usr/local/bin/system-status.sh << 'EOF'
#!/bin/bash
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
EOF

sudo chmod +x /usr/local/bin/system-status.sh

sudo tee /etc/systemd/system/system-status.timer << 'EOF'
[Unit]
Description=Run system-status.service every 15 minutes
Requires=system-status.service

[Timer]
OnCalendar=*:0/15
Persistent=true

[Install]
WantedBy=timers.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable system-status.timer
sudo systemctl start system-status.timer
sudo systemctl status system-status.timer
systemctl list-timers --all
systemctl list-timers system-status.timer

sudo tee /etc/systemd/system/temp-cleanup.service << 'EOF'
[Unit]
Description=Temporary Files Cleanup Service
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/temp-cleanup.sh
User=root
EOF

sudo tee /usr/local/bin/temp-cleanup.sh << 'EOF'
#!/bin/bash
LOG_FILE="/var/log/temp-cleanup.log"

{
    echo "=== Temp Cleanup Started - $(date) ==="
    DELETED_COUNT=$(find /tmp -type f -mtime +7 -delete -print | wc -l)
    echo "Deleted $DELETED_COUNT files from /tmp"
    find /var/log -name "*.log" -mtime +30 -size +100M -exec truncate -s 0 {} \;
    echo "Truncated large old log files"
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
EOF

sudo chmod +x /usr/local/bin/temp-cleanup.sh

sudo tee /etc/systemd/system/temp-cleanup.timer << 'EOF'
[Unit]
Description=Weekly temporary files cleanup
Requires=temp-cleanup.service

[Timer]
OnCalendar=weekly
RandomizedDelaySec=3600
Persistent=true

[Install]
WantedBy=timers.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable temp-cleanup.timer
sudo systemctl start temp-cleanup.timer

# ==============================
# USER-LEVEL SYSTEMD TIMER
# ==============================

mkdir -p ~/.config/systemd/user

tee ~/.config/systemd/user/personal-backup.service << 'EOF'
[Unit]
Description=Personal Backup Service

[Service]
Type=oneshot
ExecStart=%h/scripts/personal-backup.sh
EOF

nano ~/scripts/personal-backup.sh
chmod +x ~/scripts/personal-backup.sh

tee ~/.config/systemd/user/personal-backup.timer << 'EOF'
[Unit]
Description=Daily personal backup
Requires=personal-backup.service

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target
EOF

systemctl --user daemon-reload
systemctl --user enable personal-backup.timer
systemctl --user start personal-backup.timer
systemctl --user list-timers

# ==============================
# TASK 3 - TESTING & DEBUGGING
# ==============================

sudo journalctl -u crond -f
sudo tail -f /var/log/cron

~/scripts/system_info.sh
ls -la ~/system_reports.log
tail ~/system_reports.log

crontab -e
tail -f ~/cron_test.log
crontab -e

sudo systemctl status crond
sudo grep CRON /var/log/messages
sudo journalctl -u crond --since "1 hour ago"

nano ~/scripts/env_test.sh
chmod +x ~/scripts/env_test.sh
crontab -e
tail ~/env_test.log

sudo journalctl -u system-status.timer -f
sudo journalctl -u system-status.service --since "1 hour ago"
sudo systemctl start system-status.service
sudo tail /var/log/system-status.log

nano ~/scripts/debug_cron.sh
chmod +x ~/scripts/debug_cron.sh
crontab -e
tail -f ~/cron_debug.log

nano ~/scripts/monitor_automation.sh
chmod +x ~/scripts/monitor_automation.sh
~/scripts/monitor_automation.sh
cat ~/automation_report.log
