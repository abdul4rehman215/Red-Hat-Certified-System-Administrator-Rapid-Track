# 🧪 Lab 30: Managing Logical Volume Management (LVM)

---

## 📌 Lab Overview
This lab focuses on **Logical Volume Management (LVM)** — a flexible storage layer used in Linux to create **resizable virtual storage volumes**. You will build the full LVM stack:

- **PV (Physical Volume)** → raw disks
- **VG (Volume Group)** → storage pool
- **LV (Logical Volume)** → usable virtual partitions

You will also practice **extending**, **shrinking**, and managing LVs, and explore an **LVM snapshot** workflow.

---

## 🧾 Objectives
By the end of this lab, you will be able to:

- Understand LVM components (PV, VG, LV, PE)
- Create physical volumes using `pvcreate`
- Create volume groups using `vgcreate`
- Create logical volumes using `lvcreate`
- Extend logical volumes and resize filesystems
- Shrink logical volumes safely
- Monitor and audit LVM layout using LVM tools
- Apply LVM in real-world storage expansion and maintenance scenarios

---

## ✅ Prerequisites
- Basic Linux filesystem & partitions understanding
- Comfortable using terminal (CLI)
- Familiarity with basic commands (`ls`, `cd`, `mkdir`, etc.)
- Understanding of disks (`/dev/sdX`) and mount points
- `sudo` / root privileges

---

## 🖥️ Lab Environment
**Platform:** Al Nafi Ready-to-Use Cloud Machine  
**OS Type:** CentOS/RHEL-based Linux  
**Shell Prompt Style:** `-bash-4.2$`  
**Storage:** Multiple extra disks attached for practice (e.g., `/dev/sdb`, `/dev/sdc`, `/dev/sdd`)  
**Tools:** `lvm2` utilities available (`pvcreate`, `vgcreate`, `lvcreate`, etc.)

---

## 📁 Repository Structure
```bash
lab30-managing-lvm/
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
└── troubleshooting.md
````

> ✅ Note: This lab is command-line focused, so no additional scripts were created beyond `commands.sh`.

---

## 🧠 Key Concepts (Quick Reference)

* **PV (Physical Volume):** Disk or partition initialized for LVM
* **VG (Volume Group):** Storage pool made from one/more PVs
* **LV (Logical Volume):** “Virtual partition” carved from a VG
* **PE (Physical Extent):** Allocation unit (default commonly 4MB)

---

## 🧩 Tasks Performed (Overview Only)

### ✅ Task 1: Create Physical Volumes (PVs)

* Identified available disks (`lsblk`, `fdisk -l`)
* Prepared disks and created PVs (`pvcreate`)
* Verified PV metadata (`pvdisplay`, `pvs`, `pvscan`)

### ✅ Task 2: Create Volume Groups (VGs)

* Created VG `vg_data` using two PVs
* Created VG `vg_backup` using one PV
* Verified VG layout (`vgdisplay`, `vgs`, `vgscan`)

### ✅ Task 3: Create Logical Volumes (LVs)

* Created LVs by fixed size (2G, 1G, 500M)
* Created LV using percentage of free space (50%FREE)
* Verified LV creation (`lvdisplay`, `lvs`)
* Formatted LVs as `ext4` and mounted them under `/mnt/*`

### ✅ Task 4: Extend and Shrink LVM Storage

* Extended `lv_documents` and resized filesystem online (`lvextend`, `resize2fs`)
* Extended `lv_projects` to consume remaining VG free space
* Shrunk `lv_archive` safely (unmount → `e2fsck` → `resize2fs` → `lvreduce` → remount)

### ✅ Task 5: Monitor LVM Layout & Validate

* Confirmed mounts and usage (`df -h`, `mount`)
* Inspected LVM hierarchy (`pvs`, `vgs`, `lvs`, `lsblk`)
* Wrote test files to validate filesystem operations

### ⚙️ Advanced: Snapshot Workflow

* Created snapshot of an LV
* Mounted snapshot and verified content
* Removed snapshot safely after testing

---

## ✅ Result

* LVM was successfully configured across multiple disks.
* Volume groups and logical volumes were created, formatted, mounted, resized, and validated.
* Snapshot operations were tested and cleaned up.
* Final verification confirmed correct LVM mapping and mount status.

---

## 🌍 Why This Matters (Real-World Relevance)

LVM is widely used in enterprise Linux because it allows:

* **Online storage expansion** without reinstalling OS or repartitioning
* **Flexible storage pooling** across multiple disks
* **Safer changes** through snapshots before risky operations
* **Simplified management** for systems that grow over time (apps, logs, databases)

---

## 🧾 What I Learned

* How PVs, VGs, and LVs form a layered storage abstraction
* How to safely resize volumes (especially shrinking)
* How to verify storage changes using multiple system tools
* How snapshots can help in backup/testing workflows
