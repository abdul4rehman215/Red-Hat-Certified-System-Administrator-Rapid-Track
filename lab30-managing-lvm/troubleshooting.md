# 🛠️ Troubleshooting Guide - Lab 10: Managing LVM

> This guide covers common LVM issues encountered in real-world environments and how to resolve them safely.

---

# 🔎 Issue 1: `pvcreate` Fails

## ❌ Error Example
```

Device /dev/sdb excluded by a filter.
Device /dev/sdb contains a partition table.

````

## 🔍 Possible Causes
- Disk already contains partitions
- Existing filesystem signatures
- Disk is mounted or in use

## ✅ Resolution

### 1️⃣ Check if mounted
```bash
lsblk
mount | grep sdb
````

### 2️⃣ Check for partitions

```bash
fdisk -l /dev/sdb
```

### 3️⃣ Wipe existing signatures (⚠ destructive)

```bash
wipefs -a /dev/sdb
```

### 4️⃣ Retry

```bash
pvcreate /dev/sdb
```

---

# 🔎 Issue 2: `vgcreate` Fails

## ❌ Error Example

```
Volume group "vg_data" already exists
```

## 🔍 Cause

VG name already in use.

## ✅ Fix

Use a different name:

```bash
vgcreate vg_data2 /dev/sdb /dev/sdc
```

Or remove existing VG:

```bash
vgremove vg_data
```

---

# 🔎 Issue 3: Not Enough Free Space in VG

## ❌ Error Example

```
Insufficient free space: 256 extents needed, but only 200 available
```

## 🔍 Cause

Volume group has no free extents.

## ✅ Fix Options

### Option 1: Add New Disk

```bash
pvcreate /dev/sde
vgextend vg_data /dev/sde
```

### Option 2: Reduce Other LV

```bash
lvreduce
```

---

# 🔎 Issue 4: Filesystem Not Resized After LV Extension

## ❌ Symptom

LV size increases but `df -h` shows old size.

## 🔍 Cause

Filesystem not resized.

## ✅ Fix

### For ext4

```bash
resize2fs /dev/vg_data/lv_documents
```

### For XFS

```bash
xfs_growfs /mnt/mountpoint
```

---

# 🔎 Issue 5: Shrink Operation Corrupts Filesystem

## ❌ Cause

LV reduced before filesystem shrink.

## ✅ Correct Shrink Procedure

1. Unmount

```bash
umount /mnt/archive
```

2. Check filesystem

```bash
e2fsck -f /dev/vg_backup/lv_archive
```

3. Shrink filesystem

```bash
resize2fs /dev/vg_backup/lv_archive 200M
```

4. Reduce LV

```bash
lvreduce -L 200M /dev/vg_backup/lv_archive
```

5. Mount again

⚠ Always shrink filesystem first.

---

# 🔎 Issue 6: Mount Fails After Resize

## ❌ Error Example

```
wrong fs type, bad superblock
```

## 🔍 Cause

Improper resize sequence or filesystem corruption.

## ✅ Fix

```bash
fsck /dev/vg_name/lv_name
```

If XFS:

```bash
xfs_repair /dev/vg_name/lv_name
```

---

# 🔎 Issue 7: Snapshot Fills Up and Becomes Invalid

## ❌ Error Example

```
Snapshot invalidated
```

## 🔍 Cause

Snapshot size too small and changes exceeded allocated space.

## ✅ Fix

* Allocate larger snapshot space:

```bash
lvcreate -L 1G -s -n snapshot_name /dev/vg_name/lv_name
```

* Remove unused snapshots:

```bash
lvremove /dev/vg_name/snapshot_name
```

---

# 🔎 Issue 8: LV Is Active But Not Mounting

## 🔍 Check LV status

```bash
lvs
```

If inactive:

```bash
lvchange -ay /dev/vg_name/lv_name
```

---

# 🔎 Issue 9: System Fails to Boot After LVM Changes

## 🔍 Possible Causes

* Wrong `/etc/fstab`
* Missing initramfs update
* Root LV misconfiguration

## ✅ Recovery Steps

1. Boot into rescue mode
2. Activate LVM manually:

```bash
vgchange -ay
```

3. Fix `/etc/fstab`
4. Rebuild initramfs (if required):

```bash
dracut -f
```

---

# 🔎 Issue 10: VG or PV Not Detected After Reboot

## 🔍 Scan for LVM metadata

```bash
pvscan
vgscan
lvscan
```

Activate if needed:

```bash
vgchange -ay
```

---

# 🧠 Production Best Practices

✔ Always backup before shrinking
✔ Use `+SIZE` instead of fixed values when extending
✔ Monitor free space with `vgs`
✔ Avoid shrinking XFS (not supported)
✔ Remove unused snapshots
✔ Test with `lsblk`, `pvs`, `vgs`, `lvs`
✔ Document LVM layout

---

# 🚨 High-Risk Operations Checklist

| Operation        | Risk Level |
| ---------------- | ---------- |
| pvremove         | High       |
| vgremove         | High       |
| lvreduce         | Very High  |
| wipefs           | Very High  |
| Snapshot removal | Medium     |
| lvextend         | Low        |

---

# 🏁 Final Notes

LVM errors usually occur due to:

* Incorrect resize order
* Lack of free extents
* Mounting mistakes
* Snapshot mismanagement

If you remember one rule:

👉 **Filesystem first when shrinking. LV first when extending.**

This ensures safe and professional LVM administration in production environments.
