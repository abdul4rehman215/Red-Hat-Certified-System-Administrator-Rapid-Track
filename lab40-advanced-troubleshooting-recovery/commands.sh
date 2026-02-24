#!/bin/bash
# Lab 40: Advanced Troubleshooting and System Recovery
# Commands executed during the lab
# -----------------------------------------------

# ===============================
# TASK 1: Log Analysis
# ===============================

sudo journalctl -n 50
sudo journalctl -p err
sudo journalctl --since "2 hours ago"
sudo journalctl -f

cd /var/log
ls -la
sudo tail -50 /var/log/messages
sudo tail -30 /var/log/secure
sudo grep -i "error\|fail\|critical" /var/log/messages | tail -20

top
df -h
du -sh /var/log/*
uptime
ping -c 4 8.8.8.8
lscpu
free -h
lsblk


# ===============================
# TASK 2: Simulate Service Failure
# ===============================

sudo nano /etc/systemd/system/problem-service.service

sudo systemctl daemon-reload
sudo systemctl enable problem-service.service
sudo systemctl start problem-service.service
sudo systemctl status problem-service.service

sudo systemctl rescue

systemctl get-default
systemctl list-units --type=target
systemctl list-units --state=active
systemctl --failed
systemctl status problem-service.service
journalctl -u problem-service.service -n 20
systemctl list-dependencies rescue.target


# ===============================
# TASK 3: Fix Service Configuration
# ===============================

sudo systemctl stop problem-service.service
sudo nano /etc/systemd/system/problem-service.service

sudo systemctl daemon-reload
sudo systemctl start problem-service.service
sudo systemctl status problem-service.service

sudo systemctl default

systemctl list-units --type=service --state=active | grep -E "(sshd|NetworkManager|systemd)"
sudo journalctl -p warning --since "10 minutes ago"


# ===============================
# Backup Automation
# ===============================

sudo nano /usr/local/bin/backup-configs.sh
sudo chmod +x /usr/local/bin/backup-configs.sh
sudo /usr/local/bin/backup-configs.sh
ls -lh /var/backups/system-configs/

sudo nano /etc/systemd/system/backup-configs.service
sudo nano /etc/systemd/system/backup-configs.timer

sudo systemctl daemon-reload
sudo systemctl enable backup-configs.timer
sudo systemctl start backup-configs.timer
sudo systemctl status backup-configs.timer


# ===============================
# Final Verification
# ===============================

sudo systemctl status sshd
sudo systemctl status NetworkManager
sudo systemctl status problem-service.service

sudo journalctl -p err --since "30 minutes ago"

ping -c 3 google.com
df -h
sudo systemctl restart problem-service.service
sudo systemctl status problem-service.service

sudo nano /var/log/recovery-log-20260224.txt
