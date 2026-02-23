# 🧪 Lab 29: Partitioning and Formatting Disks

---

## 📌 Lab Summary

This lab covers **core Linux storage administration** skills required in real-world system operations and the RHCSA Rapid Track exam path:

- Discovering attached disks and verifying usage
- Creating partitions using **fdisk (MBR/DOS)** and **parted (GPT)**
- Formatting partitions using **ext4** and **xfs**
- Mounting and unmounting file systems
- Validating file system access and integrity
- Configuring **persistent mounts** using `/etc/fstab` with UUIDs
- Performing troubleshooting steps for common disk issues

> ✅ Environment note: Work was performed in a CentOS/RHEL-style cloud lab (`-bash-4.2$`) with two additional disks attached (`/dev/sdb` and `/dev/sdc`) for practice.

---

## 🎯 Objectives

By the end of this lab, I was able to:

- Create and manage disk partitions using `fdisk` and `parted`
- Format partitions using `mkfs.ext4` and `mkfs.xfs`
- Mount and unmount file systems for access
- Understand differences between **MBR (DOS)** and **GPT**
- Verify partition and file system information using system commands
- Apply disk management best practices (UUID-based persistent mounts)

---

## ✅ Prerequisites

- Linux CLI basics
- Understanding of filesystem hierarchy
- Familiarity with `sudo` for administrative tasks
- Basic storage concepts: disks, partitions, file systems
- Terminal access to a CentOS/RHEL environment

---

## 🖥️ Lab Environment

| Component | Details |
|----------|---------|
| OS | CentOS/RHEL-based |
| Shell Prompt | `-bash-4.2$` |
| Tools Used | `lsblk`, `fdisk`, `parted`, `mkfs.ext4`, `mkfs.xfs`, `blkid`, `mount`, `umount` |
| Practice Disks | `/dev/sdb` (10G), `/dev/sdc` (10G) |
| OS Disk | `/dev/sda1` mounted at `/` |

---

## 🗂️ Repository Structure

```text
lab29-partitioning-and-formatting-disks/
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
└── troubleshooting.md
````

---

## 🧩 Tasks Overview

### ✅ Task 1: Create Partitions with fdisk and parted

#### 🔹 Subtask 1.1: Identify Available Storage Devices

* Used `lsblk` to identify disks and partitions
* Used `fdisk -l` to validate disk sizes and labels
* Used `df -h` to validate mounted filesystems

#### 🔹 Subtask 1.2: Create Partitions Using `fdisk` (MBR/DOS)

On `/dev/sdb`:

* Created a new DOS partition table (`o`)
* Created:

  * `/dev/sdb1` (2G)
  * `/dev/sdb2` (1G)
* Wrote changes (`w`) and validated partitions with `lsblk`

#### 🔹 Subtask 1.3: Create Partitions Using `parted` (GPT)

On `/dev/sdc`:

* Created a GPT label (`mklabel gpt`)
* Created:

  * `/dev/sdc1` (1GiB)
  * `/dev/sdc2` (2GiB)
* Verified with `parted print` and `lsblk`

---

### ✅ Task 2: Format Partitions with mkfs

#### 🔹 Subtask 2.1: Format MBR partitions

* Formatted `/dev/sdb1` with `ext4` + label `DataDisk1`
* Formatted `/dev/sdb2` with `xfs` + label `DataDisk2`

  * Applied real-world behavior: used `-f` for overwrite to apply label on existing xfs

#### 🔹 Subtask 2.2: Format GPT partitions

* Formatted `/dev/sdc1` with `ext4` + label `GPTDisk1`
* Formatted `/dev/sdc2` with `xfs` + label `GPTDisk2`
* Verified UUIDs and labels using `blkid`

---

### ✅ Task 3: Mount, Test, and Unmount File Systems

#### 🔹 Subtask 3.1: Create mount points

Created:

* `/mnt/disk1`
* `/mnt/disk2`
* `/mnt/gpt1`
* `/mnt/gpt2`

#### 🔹 Subtask 3.2: Mount partitions

Mounted:

* `/dev/sdb1` → `/mnt/disk1`
* `/dev/sdb2` → `/mnt/disk2`
* `/dev/sdc1` → `/mnt/gpt1`
* `/dev/sdc2` → `/mnt/gpt2`

Verified mounts with:

* `df -h`
* `mount | grep -E "(sdb|sdc)"`

#### 🔹 Subtask 3.3: Test write access

* Created test files on each mount
* Wrote data using `tee`
* Verified with `cat`

#### 🔹 Subtask 3.4: Unmount and validate

* Unmounted all mounts using `umount`
* Verified unmount success using `df -h | grep`

---

### ✅ Subtask 3.5: Configure Persistent Mounts (fstab)

* Backed up `/etc/fstab` before editing
* Retrieved UUID values using `blkid`
* Appended UUID-based mount entries for `/dev/sdb1` and `/dev/sdb2`
* Tested with:

  * `mount -a`
  * `df -h | grep -E "(disk1|disk2)"`

---

## 🔎 Verification & Validation

Commands used to validate success:

* `lsblk -f` (filesystem and mount mapping)
* `df -hT` (filesystem type + usage)
* `cat /etc/fstab` (verify persistent mount entries)
* `fsck -n /dev/sdb1` (ext4 integrity check, read-only)
* `xfs_info /dev/sdb2` (xfs filesystem info)
* `mount | grep` (active mount validation)

---

## ✅ Result

* Created MBR partitions using `fdisk` on `/dev/sdb`
* Created GPT partitions using `parted` on `/dev/sdc`
* Formatted partitions with ext4 and xfs (with labels)
* Mounted and verified multiple file systems
* Wrote and read test files successfully from each mount
* Configured persistent mounts for `/dev/sdb1` and `/dev/sdb2` using UUIDs in `/etc/fstab`
* Validated filesystem integrity and mount stability

---

## 📚 What I Learned

* How to safely identify disks and confirm they are unused before partitioning
* The difference between:

  * **MBR/DOS** (fdisk default in many legacy systems)
  * **GPT** (modern standard with better scalability)
* How filesystem formatting is destructive and should be done carefully
* Why UUID-based fstab entries are safer than device names (`/dev/sdb1` can change)
* Practical troubleshooting steps for partition visibility and “device busy” unmount errors

---

## 🧠 Why This Matters

Disk partitioning and formatting are essential administration skills for:

* Provisioning storage for applications and data
* Configuring mount points for persistent storage
* Managing backup volumes and recovery partitions
* Preparing disks for higher-level storage layers like **LVM**, RAID, or NFS exports
* Meeting operational requirements for Linux server maintenance

---

## 🌍 Real-World Relevance

In production environments, admins frequently:

* Add new disks to servers and provision them for applications
* Use GPT for modern workloads (cloud + large disks)
* Select filesystem types based on performance and features (ext4 vs xfs)
* Ensure mounts persist across reboot using `/etc/fstab` and UUIDs
* Validate storage health with filesystem tools (fsck/xfs_info)

---

## 🧰 Real-World Applications

* Attaching and preparing storage for:

  * web servers (`/var/www`)
  * databases (`/var/lib/mysql`, `/var/lib/pgsql`)
  * log storage (`/var/log`)
  * backup volumes (`/backup`)
* Creating separate partitions for:

  * application isolation
  * performance tuning
  * compliance requirements
* Using UUID mounts for stability in cloud environments

---

## 🏁 Conclusion

This lab provided hands-on experience with the full disk workflow:

✅ detect disks → ✅ partition → ✅ format → ✅ mount → ✅ validate → ✅ persist → ✅ troubleshoot

These skills are foundational for RHCSA-level storage management and serve as the base for more advanced topics like **LVM**, encryption, and RAID.
