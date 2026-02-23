# 🧪 Lab 18: Disk Partitioning and Formatting (RHEL 9)

## 🎯 Objectives

This lab covers enterprise-level Linux disk management:

- Understand disk and partition structures
- Create partitions using fdisk (MBR) and parted (GPT)
- Format partitions with ext4 filesystem
- Mount filesystems temporarily and persistently
- Configure /etc/fstab
- Create and enable swap partitions

---

## 🖥️ Lab Environment

- OS: RHEL 9.3
- Hostname: rhel9-storage-lab
- Primary Disk: /dev/nvme0n1
- Secondary Disk: /dev/sdb (20GB)
- Required Packages:
  - util-linux
  - parted
  - e2fsprogs

---

## 🧩 Lab Tasks Overview

### Task 1 – Partition Disk
- Use fdisk to create MBR partition
- Use parted to create GPT partition

### Task 2 – Format Partition
- Create ext4 filesystem
- Verify using blkid

### Task 3 – Mount & Persistence
- Temporary mount
- Configure persistent mount via /etc/fstab
- Verify after reboot

### Advanced Task
- Create and enable swap partition
- Configure swap persistence

---

## 🏁 Enterprise Learning Outcomes

After completing this lab, I can:

- Safely partition production disks
- Use UUID-based mounting (best practice)
- Configure persistent storage
- Create swap space
- Prepare storage for databases & container workloads

---

## 🔐 Why This Matters

Disk management is critical for:

- Database servers
- Container platforms (OpenShift PVs)
- High-performance systems
- Production Linux infrastructure
