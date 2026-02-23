#!/bin/bash
# Lab 30: Managing Logical Volume Management (LVM)
# Note: This file contains ONLY the commands executed (no outputs).

# ----------------------------
# Task 1: Identify disks
# ----------------------------
lsblk
sudo fdisk -l
df -h
lsblk | grep -E "sdb|sdc|sdd"
sudo fdisk -l /dev/sdb
sudo fdisk -l /dev/sdc
sudo fdisk -l /dev/sdd

# ----------------------------
# Task 1: Create Physical Volumes (PVs)
# ----------------------------
sudo pvcreate /dev/sdb
sudo pvcreate /dev/sdc
sudo pvcreate /dev/sdd
sudo pvdisplay
sudo pvs
sudo pvdisplay -v
sudo pvdisplay /dev/sdb
sudo pvscan

# ----------------------------
# Task 2: Create Volume Groups (VGs)
# ----------------------------
sudo vgcreate vg_data /dev/sdb /dev/sdc
sudo vgdisplay
sudo vgs

sudo vgcreate vg_backup /dev/sdd
sudo vgdisplay -v
sudo vgs -v

sudo vgdisplay vg_data
sudo vgdisplay -v vg_data
sudo vgscan

# ----------------------------
# Task 3: Create Logical Volumes (LVs)
# ----------------------------
sudo lvcreate -L 2G -n lv_documents vg_data
sudo lvcreate -L 1G -n lv_projects vg_data
sudo lvcreate -L 500M -n lv_backup vg_backup
sudo lvdisplay
sudo lvs

sudo lvcreate -l 50%FREE -n lv_archive vg_backup
sudo lvdisplay -v
sudo lvs -o +lv_size,lv_path

# ----------------------------
# Task 3: Format & Mount LVs
# ----------------------------
sudo mkdir -p /mnt/documents
sudo mkdir -p /mnt/projects
sudo mkdir -p /mnt/backup
sudo mkdir -p /mnt/archive

sudo mkfs.ext4 /dev/vg_data/lv_documents
sudo mkfs.ext4 /dev/vg_data/lv_projects
sudo mkfs.ext4 /dev/vg_backup/lv_backup
sudo mkfs.ext4 /dev/vg_backup/lv_archive

sudo mount /dev/vg_data/lv_documents /mnt/documents
sudo mount /dev/vg_data/lv_projects /mnt/projects
sudo mount /dev/vg_backup/lv_backup /mnt/backup
sudo mount /dev/vg_backup/lv_archive /mnt/archive

df -h | grep -E "documents|projects|backup|archive"

# ----------------------------
# Task 4: Extend lv_documents (+1G) and resize filesystem
# ----------------------------
sudo lvs vg_data/lv_documents
sudo vgs vg_data
sudo lvextend -L +1G /dev/vg_data/lv_documents
sudo lvs vg_data/lv_documents
sudo resize2fs /dev/vg_data/lv_documents
df -h /mnt/documents

# ----------------------------
# Task 4: Extend lv_projects to consume all VG free space
# ----------------------------
sudo vgs vg_data
echo "# To extend a volume group with a new physical volume:"
echo "# vgextend vg_data /dev/sde"
sudo lvextend -l +100%FREE /dev/vg_data/lv_projects
sudo resize2fs /dev/vg_data/lv_projects
df -h /mnt/projects

# ----------------------------
# Task 4: Shrink lv_archive (safe workflow)
# ----------------------------
sudo umount /mnt/archive
sudo e2fsck -f /dev/vg_backup/lv_archive
sudo resize2fs /dev/vg_backup/lv_archive 200M
sudo lvreduce -L 200M /dev/vg_backup/lv_archive
sudo lvs vg_backup/lv_archive
sudo mount /dev/vg_backup/lv_archive /mnt/archive
df -h /mnt/archive

# ----------------------------
# Task 4: Create test files + verify usage
# ----------------------------
echo "This is a test document" > /mnt/documents/test.txt
echo "This is a project file" > /mnt/projects/project.txt
echo "This is backup data" > /mnt/backup/backup.txt
echo "This is archived data" > /mnt/archive/archive.txt
df -h | grep -E "documents|projects|backup|archive"

echo "=== Physical Volumes ==="
sudo pvs
echo "=== Volume Groups ==="
sudo vgs
echo "=== Logical Volumes ==="
sudo lvs

lsblk | grep -E "sdb|sdc|sdd"

# ----------------------------
# Advanced: Snapshot workflow
# ----------------------------
sudo lvcreate -L 100M -s -n lv_documents_snapshot /dev/vg_data/lv_documents
sudo lvs | grep snapshot
sudo mkdir -p /mnt/snapshot
sudo mount /dev/vg_data/lv_documents_snapshot /mnt/snapshot
ls -la /mnt/documents/
ls -la /mnt/snapshot/
sudo umount /mnt/snapshot
sudo lvremove /dev/vg_data/lv_documents_snapshot

# ----------------------------
# Troubleshooting reference commands used
# ----------------------------
sudo lsof /dev/sdb
sudo fdisk -l /dev/sdb
sudo wipefs -a /dev/sdb

sudo pvs
sudo vgs | grep vg_data
sudo vgcreate vg_data2 /dev/sdb /dev/sdc

sudo fsck /dev/vg_data/lv_documents
ls -ld /mnt/documents
mount | grep documents

# ----------------------------
# Final verification block
# ----------------------------
echo "=== LVM System Overview ==="
echo "Physical Volumes:"
sudo pvs
echo ""
echo "Volume Groups:"
sudo vgs
echo ""
echo "Logical Volumes:"
sudo lvs
echo ""
echo "Mounted File Systems:"
df -h | grep -E "documents|projects|backup|archive"
echo ""
echo "LVM Tree Structure:"
lsblk | grep -A 20 -B 5 -E "sdb|sdc|sdd"

# ----------------------------
# Performance test
# ----------------------------
echo "Testing write performance..."
time dd if=/dev/zero of=/mnt/documents/testfile bs=1M count=100
time dd if=/dev/zero of=/mnt/projects/testfile bs=1M count=100

sudo rm /mnt/documents/testfile
sudo rm /mnt/projects/testfile

# ----------------------------
# Cleanup (Optional)
# ----------------------------
sudo umount /mnt/documents
sudo umount /mnt/projects
sudo umount /mnt/backup
sudo umount /mnt/archive

sudo lvremove /dev/vg_data/lv_documents
sudo lvremove /dev/vg_data/lv_projects
sudo lvremove /dev/vg_backup/lv_backup
sudo lvremove /dev/vg_backup/lv_archive

sudo vgremove vg_data
sudo vgremove vg_backup

sudo pvremove /dev/sdb
sudo pvremove /dev/sdc
sudo pvremove /dev/sdd
