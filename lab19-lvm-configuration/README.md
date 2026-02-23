# 🧪 Lab 19: LVM Configuration (RHEL 9)

## 🎯 Objectives

This lab demonstrates enterprise Logical Volume Manager (LVM) configuration:

- Create Physical Volumes (PV)
- Create Volume Groups (VG)
- Create Logical Volumes (LV)
- Extend and shrink LVs
- Create LVM snapshots
- Mount logical volumes

---

## 🖥️ Lab Environment

- OS: RHEL 9.3
- Hostname: rhel9-lvm-lab
- Additional Disk: /dev/sdc (15GB)
- User: student
- sudo privileges required

---

## 🧩 Lab Tasks Overview

### Task 1 – Initialize Storage
- Create PV
- Create VG

### Task 2 – Create Logical Volume
- Allocate 5GB LV
- Format ext4
- Mount and verify

### Task 3 – Resize Logical Volume
- Extend LV (+2GB)
- Resize filesystem
- Shrink LV safely

### Advanced Task
- Create snapshot
- Mount snapshot
- Verify snapshot functionality

---

## 🏁 Enterprise Learning Outcomes

After completing this lab, I can:

- Dynamically allocate storage
- Expand volumes without downtime (ext4/xfs grow)
- Shrink volumes safely (offline)
- Create point-in-time snapshots
- Manage flexible storage pools

---

## 🔐 Why LVM is Critical

LVM is widely used in:

- Enterprise RHEL servers
- Database systems
- OpenShift nodes
- Cloud VM storage
- Dynamic storage provisioning

LVM enables flexible, scalable storage architecture.
