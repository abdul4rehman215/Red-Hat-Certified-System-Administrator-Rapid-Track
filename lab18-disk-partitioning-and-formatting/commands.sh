#!/bin/bash
# Lab 18 - Disk Partitioning & Formatting

# View available disks
lsblk

# Partition disk using fdisk
sudo fdisk /dev/sdb

# Verify partition
lsblk

# Format partition
sudo mkfs.ext4 /dev/sdb1

# Verify filesystem
sudo blkid /dev/sdb1

# Create mount point
sudo mkdir -p /mnt/mydata

# Mount partition
sudo mount /dev/sdb1 /mnt/mydata

# Verify mount
df -hT /mnt/mydata

# Get UUID
sudo blkid /dev/sdb1

# Edit fstab (manual step)
# UUID=<UUID> /mnt/mydata ext4 defaults 0 2

# Test fstab
sudo mount -a

# Reboot
sudo reboot

# ----- Swap Creation -----

# Create swap partition using fdisk
sudo fdisk /dev/sdb

# Format swap
sudo mkswap /dev/sdb2

# Enable swap
sudo swapon /dev/sdb2

# Verify swap
swapon --show

# Add to fstab
# /dev/sdb2 none swap sw 0 0
