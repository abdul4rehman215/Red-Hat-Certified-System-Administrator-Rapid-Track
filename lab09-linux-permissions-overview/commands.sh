#!/bin/bash
# ============================================
# Lab 09: Linux Permissions Overview
# Commands Executed During Lab
# ============================================

# -------------------------------
# Task 1: Viewing Permissions
# -------------------------------

ls -l


# -------------------------------
# Task 2: Modifying Permissions
# -------------------------------

# Create test file
touch testfile.txt

# Change permissions using numeric mode
chmod 640 testfile.txt

# Verify permissions
ls -l testfile.txt

# Add execute permission for owner
chmod u+x testfile.txt

# Remove read permission for others
chmod o-r testfile.txt

# Verify updated permissions
ls -l testfile.txt


# -------------------------------
# Task 3: Changing Ownership
# -------------------------------

# Create new user
sudo useradd testuser

# Change file owner
sudo chown testuser testfile.txt

# Verify owner change
ls -l testfile.txt


# -------------------------------
# Task 3: Changing Group Ownership
# -------------------------------

# Create new group
sudo groupadd testgroup

# Change group ownership
sudo chgrp testgroup testfile.txt

# Verify group change
ls -l testfile.txt

# Alternative combined method
sudo chown testuser:testgroup testfile.txt


# -------------------------------
# Cleanup (Optional)
# -------------------------------

sudo userdel testuser
sudo groupdel testgroup
rm testfile.txt
