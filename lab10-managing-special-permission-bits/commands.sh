#!/bin/bash
# ============================================
# Lab 10: Managing Special Permission Bits
# Commands Executed During Lab
# ============================================

# -------------------------------
# Task 1: Sticky Bit
# -------------------------------

# Create shared directory
mkdir /tmp/shared_dir

# Set full permissions
chmod 777 /tmp/shared_dir

# Verify permissions
ls -ld /tmp/shared_dir

# Apply sticky bit
chmod +t /tmp/shared_dir

# Verify sticky bit
ls -ld /tmp/shared_dir

# Create file as owner
touch /tmp/shared_dir/user1_file

# Create file as another user
sudo -u nobody touch /tmp/shared_dir/nobody_file

# Attempt deletion as non-owner
sudo -u nobody rm /tmp/shared_dir/user1_file


# -------------------------------
# Task 2: setuid Configuration
# -------------------------------

# Create executable script
sudo nano /usr/local/bin/show_euid

# Make executable
sudo chmod +x /usr/local/bin/show_euid

# Apply setuid
sudo chmod u+s /usr/local/bin/show_euid

# Verify setuid
ls -l /usr/local/bin/show_euid

# Test execution as non-root user
sudo -u nobody /usr/local/bin/show_euid


# -------------------------------
# Task 2: setgid Configuration
# -------------------------------

# Create group
sudo groupadd testgroup

# Change group ownership
sudo chown :testgroup /usr/local/bin/show_euid

# Apply setgid
sudo chmod g+s /usr/local/bin/show_euid

# Verify setgid
ls -l /usr/local/bin/show_euid


# -------------------------------
# Task 3: Verification
# -------------------------------

# Confirm sticky bit enforcement
sudo -u nobody rm /tmp/shared_dir/user1_file

# Verify effective UID behavior
sudo -u nobody /usr/local/bin/show_euid

# Check mount options
mount | grep nosuid

# Detailed permission check
stat /usr/local/bin/show_euid


# -------------------------------
# Cleanup
# -------------------------------

sudo rm /usr/local/bin/show_euid
sudo groupdel testgroup
sudo rm -r /tmp/shared_dir
