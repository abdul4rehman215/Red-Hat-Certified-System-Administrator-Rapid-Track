#!/bin/bash
# Lab 19 - LVM Configuration

# Verify disks
lsblk

# Create Physical Volume
sudo pvcreate /dev/sdc

# Verify PV
sudo pvdisplay

# Create Volume Group
sudo vgcreate vg01 /dev/sdc

# Verify VG
sudo vgdisplay vg01

# Create Logical Volume (5GB)
sudo lvcreate -L 5G -n lv01 vg01

# Verify LV
sudo lvdisplay /dev/vg01/lv01

# Format LV
sudo mkfs.ext4 /dev/vg01/lv01

# Create mount point
sudo mkdir -p /mnt/lv01

# Mount LV
sudo mount /dev/vg01/lv01 /mnt/lv01

# Verify mount
df -h /mnt/lv01

# -------- Extend LV --------

sudo lvextend -L +2G /dev/vg01/lv01
sudo resize2fs /dev/vg01/lv01

# Verify
df -h /mnt/lv01

# -------- Shrink LV --------

sudo umount /mnt/lv01
sudo e2fsck -f /dev/vg01/lv01
sudo resize2fs /dev/vg01/lv01 4G
sudo lvreduce -L 4G /dev/vg01/lv01
sudo mount /dev/vg01/lv01 /mnt/lv01

# -------- Snapshot --------

sudo lvcreate -s -n lv01_snap -L 1G /dev/vg01/lv01
sudo mkdir -p /mnt/snap
sudo mount /dev/vg01/lv01_snap /mnt/snap

# Verify snapshot
df -h /mnt/snap
