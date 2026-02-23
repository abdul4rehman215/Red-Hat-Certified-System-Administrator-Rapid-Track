#!/bin/bash
# ============================================
# Lab 08: Managing Password Policies
# Commands Executed During Lab
# ============================================

# -------------------------------
# Lab Setup: Create Test Users
# -------------------------------

sudo useradd testuser1
sudo useradd testuser2


# -------------------------------
# Task 1: Install Required Package
# -------------------------------

sudo dnf install libpwquality -y


# -------------------------------
# Task 1: Configure Password Complexity
# -------------------------------

sudo nano /etc/security/pwquality.conf

# (Modified values inside file)
# minlen = 12
# minclass = 4
# dcredit = -1
# ucredit = -1
# lcredit = -1
# ocredit = -1


# -------------------------------
# Verify Password Quality
# -------------------------------

echo "Weakpass1" | sudo pwscore
echo "StrongPass123!" | sudo pwscore


# -------------------------------
# Task 2: Configure Global Password Aging
# -------------------------------

sudo nano /etc/login.defs

# (Modified values inside file)
# PASS_MAX_DAYS   90
# PASS_MIN_DAYS   7
# PASS_WARN_AGE   14
# PASS_MIN_LEN    12


# -------------------------------
# Apply Aging Policy to Users
# -------------------------------

sudo chage -M 90 -m 7 -W 14 testuser1
sudo chage -M 90 -m 7 -W 14 testuser2

sudo chage -l testuser1


# -------------------------------
# Configure Default Inactivity Lock
# -------------------------------

sudo useradd -D -f 30


# -------------------------------
# Task 3: Test Password Policies
# -------------------------------

sudo passwd testuser1

sudo chage -l testuser1

sudo chage -d 0 testuser1

sudo chage -I 30 -E $(date -d "+30 days" +%Y-%m-%d) testuser2

sudo chage -l testuser2


# -------------------------------
# Troubleshooting Commands
# -------------------------------

grep pam_pwquality /etc/pam.d/system-auth

sudo tail /var/log/secure


# -------------------------------
# Cleanup
# -------------------------------

sudo userdel -r testuser1
sudo userdel -r testuser2
