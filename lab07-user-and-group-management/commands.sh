#!/bin/bash
# ============================================
# Lab 07: User and Group Management in Linux
# Commands Executed During Lab
# ============================================

# -------------------------------
# Task 1: Create New Users
# -------------------------------

sudo useradd labuser1

sudo useradd -m labuser2

id labuser1
id labuser2


# -------------------------------
# Task 1: Create New Group
# -------------------------------

sudo groupadd developers

grep developers /etc/group


# -------------------------------
# Task 2: Modify User Information
# -------------------------------

# Change Home Directory
sudo usermod -d /home/labuser1_new -m labuser1

ls /home

# Change Default Shell
sudo usermod -s /bin/bash labuser1

grep labuser1 /etc/passwd


# -------------------------------
# Task 3: Assign Users to Group
# -------------------------------

sudo usermod -aG developers labuser1
sudo usermod -aG developers labuser2

groups labuser1


# -------------------------------
# Remove User from Group
# -------------------------------

sudo gpasswd -d labuser1 developers

groups labuser1


# -------------------------------
# Delete Users and Groups
# -------------------------------

sudo userdel -r labuser1

sudo groupdel developers

grep developers /etc/group


# -------------------------------
# Troubleshooting (If Needed)
# -------------------------------

# sudo pkill -u labuser1
