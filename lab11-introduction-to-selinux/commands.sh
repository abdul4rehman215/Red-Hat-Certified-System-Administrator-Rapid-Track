#!/bin/bash
# ============================================
# Lab 11: Introduction to SELinux
# Commands Executed During Lab
# ============================================

# -------------------------------
# Task 1: Verify SELinux Installation
# -------------------------------

rpm -qa | grep selinux

# If missing:
# sudo dnf install selinux-policy selinux-policy-targeted libselinux-utils -y

# Check SELinux status
sestatus


# -------------------------------
# Task 2: Understand SELinux Modes
# -------------------------------

# Check current mode
getenforce

# Temporarily switch to Permissive
sudo setenforce 0

# Verify
getenforce

# Switch back to Enforcing
sudo setenforce 1

# Verify
getenforce

# Permanently change mode
sudo vi /etc/selinux/config

# (Edited file content)
# SELINUX=enforcing
# SELINUXTYPE=targeted

# Reboot system
sudo reboot

# After reboot, verify
sestatus


# -------------------------------
# Task 3: Check and Modify Contexts
# -------------------------------

# View context of system file
ls -Z /etc/passwd

# Create web directory
sudo mkdir -p /var/www/html

# Create test file
sudo touch /var/www/html/testfile.html

# Check current context
ls -Z /var/www/html/testfile.html

# Change context to web content type
sudo chcon -t httpd_sys_content_t /var/www/html/testfile.html

# Verify context change
ls -Z /var/www/html/testfile.html

# Restore default context
sudo restorecon -v /var/www/html/testfile.html


# -------------------------------
# Troubleshooting SELinux
# -------------------------------

# Check recent AVC denials
sudo ausearch -m avc -ts recent

# Generate policy module from denials
sudo ausearch -m avc -ts recent | audit2allow -M mypolicy

# Install custom module
sudo semodule -i mypolicy.pp
