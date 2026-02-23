#!/bin/bash
# ==========================================================
# Lab 09: Partitioning and Formatting Disks
# Commands Executed (Sequential / No Explanations)
# Environment: CentOS/RHEL (-bash-4.2$)
# Disks used: /dev/sdb (MBR via fdisk), /dev/sdc (GPT via parted)
# ==========================================================

# --- Identify available storage devices ---
lsblk
sudo fdisk -l
df -h

# --- Create partitions on /dev/sdb using fdisk (interactive) ---
sudo fdisk /dev/sdb
# داخل fdisk:
# o
# n -> p -> 1 -> (Enter) -> +2G
# n -> p -> 2 -> (Enter) -> +1G
# p
# w

# Verify partitions created on /dev/sdb
lsblk /dev/sdb

# --- Create partitions on /dev/sdc using parted (interactive) ---
sudo parted /dev/sdc
# داخل parted:
# mklabel gpt
# yes
# mkpart primary ext4 1MiB 1GiB
# mkpart primary xfs 1GiB 3GiB
# print
# quit

# Verify partitions created on /dev/sdc
lsblk /dev/sdc

# --- Format partitions (mkfs) ---
sudo mkfs.ext4 /dev/sdb1
sudo mkfs.ext4 -L "DataDisk1" /dev/sdb1
sudo blkid /dev/sdb1

sudo mkfs.xfs /dev/sdb2
sudo mkfs.xfs -L "DataDisk2" /dev/sdb2
sudo mkfs.xfs -f -L "DataDisk2" /dev/sdb2
sudo blkid /dev/sdb2

sudo mkfs.ext4 -L "GPTDisk1" /dev/sdc1
sudo mkfs.xfs -L "GPTDisk2" /dev/sdc2
sudo blkid /dev/sdc1 /dev/sdc2

# --- Create mount points ---
sudo mkdir -p /mnt/disk1
sudo mkdir -p /mnt/disk2
sudo mkdir -p /mnt/gpt1
sudo mkdir -p /mnt/gpt2
ls -la /mnt/

# --- Mount file systems manually ---
sudo mount /dev/sdb1 /mnt/disk1
sudo mount /dev/sdb2 /mnt/disk2
sudo mount /dev/sdc1 /mnt/gpt1
sudo mount /dev/sdc2 /mnt/gpt2

# Verify mounts
df -h
mount | grep -E "(sdb|sdc)"

# --- Test filesystem access ---
sudo touch /mnt/disk1/test_ext4.txt
sudo touch /mnt/disk2/test_xfs.txt
sudo touch /mnt/gpt1/test_gpt_ext4.txt
sudo touch /mnt/gpt2/test_gpt_xfs.txt

echo "This is an ext4 file system" | sudo tee /mnt/disk1/test_ext4.txt
echo "This is an xfs file system" | sudo tee /mnt/disk2/test_xfs.txt
echo "This is a GPT ext4 file system" | sudo tee /mnt/gpt1/test_gpt_ext4.txt
echo "This is a GPT xfs file system" | sudo tee /mnt/gpt2/test_gpt_xfs.txt

cat /mnt/disk1/test_ext4.txt
cat /mnt/disk2/test_xfs.txt
cat /mnt/gpt1/test_gpt_ext4.txt
cat /mnt/gpt2/test_gpt_xfs.txt

# --- Unmount file systems ---
sudo umount /mnt/disk1
sudo umount /mnt/disk2
sudo umount /mnt/gpt1
sudo umount /mnt/gpt2

# Verify unmount
df -h | grep -E "(sdb|sdc)"
ls -la /mnt/disk1/
ls -la /mnt/disk2/

# --- Configure persistent mounts (fstab) ---
sudo cp /etc/fstab /etc/fstab.backup
sudo blkid | grep -E "(sdb|sdc)"

echo "# Lab 9 - Disk partitions" | sudo tee -a /etc/fstab
echo "UUID=$(sudo blkid -s UUID -o value /dev/sdb1) /mnt/disk1 ext4 defaults 0 2" | sudo tee -a /etc/fstab
echo "UUID=$(sudo blkid -s UUID -o value /dev/sdb2) /mnt/disk2 xfs defaults 0 2" | sudo tee -a /etc/fstab

sudo mount -a
df -h | grep -E "(disk1|disk2)"

# --- Verification and testing ---
lsblk -f
df -hT
cat /etc/fstab | tail -5

sudo fsck -n /dev/sdb1
sudo xfs_info /dev/sdb2

# --- Troubleshooting commands used ---
sudo fuser -m /mnt/disk1
sudo lsof +D /mnt/disk1

sudo partprobe /dev/sdb
sudo partprobe /dev/sdc

sudo umount /mnt/disk1
sudo mount /dev/sdb1 /mnt/disk1

# --- Cleanup (optional) ---
sudo umount /mnt/disk1 /mnt/disk2 /mnt/gpt1 /mnt/gpt2
sudo cp /etc/fstab.backup /etc/fstab
sudo rmdir /mnt/disk1 /mnt/disk2 /mnt/gpt1 /mnt/gpt2
