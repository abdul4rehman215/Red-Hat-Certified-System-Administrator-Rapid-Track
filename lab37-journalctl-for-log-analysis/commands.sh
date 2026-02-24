#!/bin/bash
# Lab 37 - journalctl Log Analysis
# Commands Executed During Lab

# ----------------------------
# Switch to root
# ----------------------------
sudo su -

# ----------------------------
# Task 1: Basic journal viewing
# ----------------------------
journalctl --help | head -20
journalctl
journalctl -n
journalctl -n 20
journalctl -f
journalctl -r
journalctl --no-pager -n 5

# Output formatting
journalctl -o json -n 3
journalctl -o verbose -n 2
journalctl -o short -n 5

# ----------------------------
# Task 2: Time-based filtering
# ----------------------------
journalctl --since today
journalctl --since yesterday --until today
journalctl --since "1 hour ago"
journalctl --since "2024-01-01 00:00:00" --until "2024-01-01 23:59:59"
journalctl --since "30 minutes ago"

# ----------------------------
# Priority-based filtering
# ----------------------------
journalctl -p err
journalctl -p warning
journalctl -p crit

# Generate test logs
logger -p user.err "This is a test error message"
logger -p user.warning "This is a test warning message"
logger -p user.info "This is a test info message"

journalctl -p info --since "1 minute ago" | grep "test"

# ----------------------------
# Unit-based filtering
# ----------------------------
journalctl -F _SYSTEMD_UNIT | head -10
journalctl -u sshd
journalctl -u NetworkManager
journalctl -u sshd -u NetworkManager --since today
journalctl -k

ps aux | grep systemd | head -1
journalctl _PID=1 -n 5

# ----------------------------
# Combining filters
# ----------------------------
journalctl -u sshd -p err --since today
journalctl -p warning --since "2 hours ago"
journalctl -u NetworkManager -p info --since yesterday --until today

# ----------------------------
# Persistent journal setup
# ----------------------------
journalctl --disk-usage
cat /etc/systemd/journald.conf
ls -la /var/log/journal/

mkdir -p /var/log/journal
chown root:systemd-journal /var/log/journal
chmod 2755 /var/log/journal
cp /etc/systemd/journald.conf /etc/systemd/journald.conf.backup

nano /etc/systemd/journald.conf

systemctl restart systemd-journald
systemctl status systemd-journald

ls -la /var/log/journal/
ls -la /var/log/journal/*/
journalctl --disk-usage

# Generate persistent test entries
for i in {1..10}; do logger "Test persistent log entry $i"; done
journalctl --since "1 minute ago" | grep "Test persistent"

# ----------------------------
# Journal maintenance
# ----------------------------
journalctl --verify
journalctl --vacuum-time=2d
journalctl --vacuum-size=100M
journalctl --vacuum-files=50

systemctl show systemd-journald | grep -E "(Storage|MaxUse|KeepFree)"

# ----------------------------
# Advanced filtering
# ----------------------------
journalctl | grep -i "error"
journalctl -g "failed"
journalctl _UID=0 -n 10

journalctl --list-boots
journalctl -b 0
journalctl -b -1

journalctl --since today --output=json > /tmp/today_logs.json
ls -lh /tmp/today_logs.json

# ----------------------------
# Monitoring script setup
# ----------------------------
nano /usr/local/bin/log_monitor.sh
chmod +x /usr/local/bin/log_monitor.sh
/usr/local/bin/log_monitor.sh

logger -p user.crit "Test critical error for monitoring"
/usr/local/bin/log_monitor.sh
cat /var/log/critical_alerts.log

# ----------------------------
# Troubleshooting commands
# ----------------------------
systemd-tmpfiles --create --prefix /var/log/journal
journalctl --vacuum-size=200M
systemctl list-units --type=service | grep sshd
journalctl -u sshd.service --since today

# ----------------------------
# Final verification
# ----------------------------
systemctl status systemd-journald
ls -la /var/log/journal/
journalctl --disk-usage

logger -p user.info "Lab 17 verification: Info message"
logger -p user.warning "Lab 17 verification: Warning message"
logger -p user.err "Lab 17 verification: Error message"

journalctl -p warning --since "1 minute ago" | grep "Lab 17"
journalctl --since "1 minute ago" | grep "Lab 17"
ls -la /var/log/journal/*/system.journal
