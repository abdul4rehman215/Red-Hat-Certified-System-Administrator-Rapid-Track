# 🛠️ Troubleshooting Guide — Lab 29: Partitioning and Formatting Disks

---

## 🔎 Issue 1: New Partitions Not Visible After fdisk

### 🧾 Symptom
After creating partitions using `fdisk`, running `lsblk` does not show `/dev/sdb1` or `/dev/sdb2`.

---

### 📌 Possible Causes
- Kernel has not re-read the partition table.
- Changes were not written (`w` not executed).
- Disk is in use by another process.

---

### ✅ Resolution

1️⃣ Re-read partition table:
```bash
sudo partprobe /dev/sdb
````

2️⃣ Alternatively:

```bash
sudo kpartx -a /dev/sdb
```

3️⃣ If still not visible:

```bash
reboot
```

---

## 🔎 Issue 2: “Device or resource busy” When Unmounting

### 🧾 Symptom

```bash
umount: /mnt/disk1: device is busy
```

---

### 📌 Possible Causes

* A process is accessing the mount point.
* Current working directory is inside mount.
* Open file handles exist.

---

### ✅ Resolution

1️⃣ Identify processes:

```bash
sudo fuser -m /mnt/disk1
```

2️⃣ Check open files:

```bash
sudo lsof +D /mnt/disk1
```

3️⃣ Exit directory if inside it:

```bash
cd ~
```

4️⃣ Force unmount (use carefully):

```bash
sudo umount -l /mnt/disk1
```

---

## 🔎 Issue 3: Mount Fails with “Wrong fs type”

### 🧾 Symptom

```bash
mount: wrong fs type, bad option, bad superblock
```

---

### 📌 Possible Causes

* Filesystem not formatted.
* Incorrect filesystem type in `/etc/fstab`.
* Corrupted filesystem.

---

### ✅ Resolution

1️⃣ Verify filesystem type:

```bash
sudo blkid
```

2️⃣ Ensure correct entry in `/etc/fstab`:

```bash
UUID=xxxx /mnt/disk1 ext4 defaults 0 2
```

3️⃣ Run filesystem check (ext4):

```bash
sudo fsck -f /dev/sdb1
```

4️⃣ For XFS:

```bash
sudo xfs_repair /dev/sdb2
```

---

## 🔎 Issue 4: Filesystem Corruption

### 🧾 Symptom

System reports errors when accessing partition.

---

### ✅ Resolution

For ext4:

```bash
sudo fsck -y /dev/sdb1
```

For xfs:

```bash
sudo xfs_repair /dev/sdb2
```

⚠️ Always unmount before running repair:

```bash
sudo umount /dev/sdb1
```

---

## 🔎 Issue 5: fstab Misconfiguration Causing Boot Failure

### 🧾 Symptom

System fails to boot after editing `/etc/fstab`.

---

### 📌 Possible Causes

* Wrong UUID
* Wrong filesystem type
* Missing mount directory

---

### ✅ Prevention Best Practice

Always test:

```bash
sudo mount -a
```

If no output → configuration is valid.

---

### 🔄 Recovery (Emergency Mode)

1️⃣ Boot into rescue mode.
2️⃣ Edit `/etc/fstab`:

```bash
vi /etc/fstab
```

3️⃣ Comment faulty line:

```bash
# UUID=xxxx ...
```

4️⃣ Reboot system.

---

## 🔎 Issue 6: Partitioning Wrong Disk

### 🧾 Symptom

Accidentally partitioned the OS disk.

---

### 📌 Prevention

Before partitioning, always verify:

```bash
lsblk
```

Confirm:

* OS disk is mounted at `/`
* Practice disk is unmounted

---

## 🔎 Issue 7: Mount Point Directory Missing

### 🧾 Symptom

```bash
mount: mount point does not exist
```

---

### ✅ Resolution

Create directory:

```bash
sudo mkdir -p /mnt/disk1
```

---

## 🔎 Issue 8: UUID Changes After Reformatting

### 🧾 Explanation

Reformatting generates a new UUID.

---

### ✅ Resolution

1️⃣ Retrieve new UUID:

```bash
sudo blkid
```

2️⃣ Update `/etc/fstab` accordingly.

---

## 🔎 Issue 9: GPT vs MBR Confusion

### 📌 How to Check Partition Table Type

```bash
sudo parted /dev/sdb print
```

Look for:

* `Partition Table: gpt`
* `Partition Table: msdos`

---

## 🔐 Best Practices for Disk Management

* Always verify disk before modifying.
* Backup `/etc/fstab` before editing.
* Use UUID instead of device names.
* Test mounts with `mount -a`.
* Avoid formatting mounted partitions.
* Keep mount points organized under `/mnt` or `/data`.
* Document storage layout.

---

# 🧠 Production Storage Safety Checklist

✔ Confirm correct disk
✔ Verify disk is not mounted
✔ Partition carefully
✔ Format intentionally
✔ Label filesystems
✔ Mount and test
✔ Use UUID in fstab
✔ Validate with `mount -a`
✔ Verify with `lsblk -f`

---

# 🏁 Final Notes

Disk misconfiguration can cause:

* Data loss
* Boot failures
* Application downtime

This troubleshooting guide ensures safe and professional disk management aligned with RHCSA and enterprise Linux standards.
