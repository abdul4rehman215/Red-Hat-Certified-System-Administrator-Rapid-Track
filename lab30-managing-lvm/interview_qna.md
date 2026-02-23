# 🎯 Interview Q&A - Lab 30: Managing LVM 

---

## 🔹 Basic Level Questions

### 1️⃣ What is LVM in Linux?
**Answer:**
LVM (Logical Volume Management) is a storage management technology in Linux that allows flexible disk management by abstracting physical storage into logical units.

It enables:
- Dynamic resizing of volumes
- Combining multiple disks into a single pool
- Snapshot creation for backup/testing

---

### 2️⃣ What are the main components of LVM?

**Answer:**

| Component | Description |
|------------|-------------|
| **PV (Physical Volume)** | Raw disk or partition prepared for LVM |
| **VG (Volume Group)** | Pool of storage created from one or more PVs |
| **LV (Logical Volume)** | Virtual partition created from VG space |
| **PE (Physical Extent)** | Smallest allocatable unit (default 4MB) |

---

### 3️⃣ What is the difference between a partition and a logical volume?

**Answer:**
- A **partition** is a fixed section of a disk created using tools like `fdisk`.
- A **logical volume** is flexible and can be resized dynamically without repartitioning.

Logical volumes are created inside volume groups and offer more flexibility than traditional partitions.

---

### 4️⃣ Which command is used to create a Physical Volume?

```bash
pvcreate /dev/sdb
````

---

### 5️⃣ Which command is used to create a Volume Group?

```bash
vgcreate vg_name /dev/sdb /dev/sdc
```

---

### 6️⃣ Which command is used to create a Logical Volume?

```bash
lvcreate -L 2G -n lv_name vg_name
```

---

## 🔹 Intermediate Level Questions

### 7️⃣ How do you extend a Logical Volume?

**Answer:**

```bash
lvextend -L +1G /dev/vg_name/lv_name
resize2fs /dev/vg_name/lv_name
```

> Important: After extending the LV, you must resize the filesystem.

---

### 8️⃣ Can you extend an LVM volume online?

**Answer:**
Yes. LVM allows online extension for most filesystems like ext4 and xfs.

* ext4 → `resize2fs`
* xfs → `xfs_growfs`

---

### 9️⃣ What is the correct order to shrink a logical volume?

**Answer:**
Shrinking must be done carefully:

1. Unmount filesystem
2. Run filesystem check (`e2fsck`)
3. Shrink filesystem (`resize2fs`)
4. Reduce LV (`lvreduce`)
5. Mount again

Incorrect order can cause data loss.

---

### 🔟 What happens if you shrink the LV before the filesystem?

**Answer:**
You may corrupt the filesystem and permanently lose data.

Filesystem must always be reduced first.

---

## 🔹 Advanced Level Questions

### 1️⃣1️⃣ What is an LVM Snapshot?

**Answer:**
An LVM snapshot is a point-in-time copy of a logical volume.

It is commonly used for:

* Backup operations
* Testing changes
* Rolling back configurations

---

### 1️⃣2️⃣ How do you create a snapshot?

```bash
lvcreate -L 100M -s -n snapshot_name /dev/vg_name/lv_name
```

---

### 1️⃣3️⃣ How do you extend a Volume Group?

**Answer:**

1. Create a new Physical Volume:

```bash
pvcreate /dev/sde
```

2. Add it to VG:

```bash
vgextend vg_name /dev/sde
```

---

### 1️⃣4️⃣ How do you check LVM layout?

```bash
pvs
vgs
lvs
lsblk
```

---

### 1️⃣5️⃣ How do you remove LVM components?

Order matters:

1. Remove LVs → `lvremove`
2. Remove VGs → `vgremove`
3. Remove PVs → `pvremove`

---

## 🔹 Scenario-Based Questions (Real-World)

### 🧠 Scenario 1:

Your `/home` directory is running out of space. How do you extend it?

**Answer:**

1. Check free space in VG (`vgs`)
2. Extend LV (`lvextend`)
3. Resize filesystem (`resize2fs` or `xfs_growfs`)

No reboot required.

---

### 🧠 Scenario 2:

You need to take a backup of a running database without stopping it.

**Answer:**

* Create LVM snapshot
* Mount snapshot
* Perform backup from snapshot
* Remove snapshot after completion

---

### 🧠 Scenario 3:

A disk failed in a multi-disk volume group. What should you do?

**Answer:**

* Replace failed disk
* Create new PV
* Use `vgreduce` and `vgextend`
* Restore from backup if needed

---

## 🔹 Command Comparison Cheat Sheet

| Task            | Command       |
| --------------- | ------------- |
| Create PV       | `pvcreate`    |
| List PVs        | `pvs`         |
| Create VG       | `vgcreate`    |
| List VGs        | `vgs`         |
| Create LV       | `lvcreate`    |
| List LVs        | `lvs`         |
| Extend LV       | `lvextend`    |
| Reduce LV       | `lvreduce`    |
| Resize ext4     | `resize2fs`   |
| Resize xfs      | `xfs_growfs`  |
| Create snapshot | `lvcreate -s` |

---

## 🔹 RHCSA Exam Tip

* Be comfortable resizing LVs quickly.
* Understand shrinking procedure order.
* Always verify with `pvs`, `vgs`, `lvs`.
* Practice snapshot creation & removal.

---

# ✅ Final Takeaway

If you understand:

* PV → VG → LV relationship
* Safe resize operations
* Snapshot usage
* Monitoring tools

Then you are production-ready for LVM storage administration.
