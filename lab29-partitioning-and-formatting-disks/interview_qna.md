# 🎤 Interview Q&A — Lab 29: Partitioning and Formatting Disks

---

## 🧠 Basic Concept Questions

### 1️⃣ What is the difference between a disk and a partition?

**Answer:**
- A **disk** is a physical or virtual storage device (e.g., `/dev/sdb`).
- A **partition** is a logical division of a disk (e.g., `/dev/sdb1`).
- Partitions allow multiple file systems to exist on a single disk.

---

### 2️⃣ What is the difference between MBR and GPT?

| Feature | MBR (DOS) | GPT |
|----------|------------|------|
| Max Partitions | 4 primary | 128+ |
| Max Disk Size | ~2 TB | 9+ ZB |
| Redundancy | No backup | Backup partition table |
| Modern Systems | Legacy BIOS | UEFI / Modern systems |

**Key Point:** GPT is the modern standard and preferred for new deployments.

---

### 3️⃣ What does `lsblk` show?

**Answer:**
- Lists block devices
- Shows disks, partitions, mount points
- Can show filesystem types using `lsblk -f`

---

### 4️⃣ What is the purpose of `fdisk`?

**Answer:**
- Traditional partitioning tool
- Works primarily with MBR/DOS partition tables
- Interactive CLI tool
- Suitable for smaller or legacy systems

---

### 5️⃣ What is the purpose of `parted`?

**Answer:**
- Modern partitioning tool
- Supports GPT and MBR
- Works with large disks (>2TB)
- Better suited for enterprise/cloud environments

---

## 💾 File System Questions

### 6️⃣ What is `mkfs`?

**Answer:**
`mkfs` (make filesystem) formats a partition with a specific file system type (ext4, xfs, etc.).

Examples:
- `mkfs.ext4`
- `mkfs.xfs`

⚠️ Formatting is destructive and erases data.

---

### 7️⃣ What is the difference between ext4 and xfs?

| Feature | ext4 | xfs |
|----------|------|------|
| Default in older RHEL | Yes | No |
| Default in RHEL 7+ | No | Yes |
| Performance | Good | Excellent for large files |
| Online Resize | Yes | Yes |
| fsck support | Yes | Limited (uses xfs_repair) |

**Real-world note:** XFS is common in enterprise environments.

---

### 8️⃣ Why should we use UUID in `/etc/fstab` instead of `/dev/sdb1`?

**Answer:**
Device names can change after reboot or hardware reordering.
UUID is unique and persistent, ensuring stable mounting.

Example:
```bash
UUID=xxxx-xxxx /mnt/disk1 ext4 defaults 0 2
````

---

## 🔧 Mounting & Persistence Questions

### 9️⃣ What does `mount -a` do?

**Answer:**

* Mounts all file systems listed in `/etc/fstab`
* Used to test fstab entries without rebooting

If no output appears → configuration is correct.

---

### 🔟 What do the last two numbers in `/etc/fstab` mean?

Example:

```bash
UUID=xxxx /mnt ext4 defaults 0 2
```

* First number → Dump (backup utility, usually 0)
* Second number → fsck order

  * 0 → no check
  * 1 → root filesystem
  * 2 → other filesystems

---

## 🛠 Troubleshooting Questions

### 1️⃣1️⃣ What does “device is busy” mean during unmount?

**Answer:**
A process is using the mount point.

Check with:

```bash
fuser -m /mountpoint
lsof +D /mountpoint
```

---

### 1️⃣2️⃣ What if new partitions don’t appear after fdisk?

**Answer:**
Kernel hasn’t re-read partition table.

Run:

```bash
partprobe
```

or

```bash
reboot
```

---

### 1️⃣3️⃣ How do you check filesystem integrity?

For ext4:

```bash
fsck -n /dev/sdb1
```

For xfs:

```bash
xfs_info /dev/sdb2
```

or

```bash
xfs_repair
```

---

## 🏢 Real-World Scenario Questions

### 1️⃣4️⃣ A new 500GB disk is attached to your server. What steps would you take?

**Answer:**

1. Identify disk:

   ```bash
   lsblk
   ```
2. Partition disk (GPT preferred):

   ```bash
   parted /dev/sdx
   ```
3. Format:

   ```bash
   mkfs.xfs /dev/sdx1
   ```
4. Create mount point:

   ```bash
   mkdir /data
   ```
5. Add to `/etc/fstab` using UUID
6. Test:

   ```bash
   mount -a
   ```

---

### 1️⃣5️⃣ Why separate partitions for `/var`, `/home`, or `/backup`?

**Answer:**

* Prevent one directory from filling entire disk
* Improve security isolation
* Improve performance tuning
* Support backup strategies

---

### 1️⃣6️⃣ When would you choose GPT over MBR?

**Answer:**

* Disk larger than 2TB
* Modern UEFI systems
* Enterprise/cloud environments
* Need more than 4 primary partitions

---

## 🎯 RHCSA-Level Practical Questions

### 1️⃣7️⃣ How do you create a 1GB partition using fdisk?

```bash
fdisk /dev/sdb
n
p
1
+1G
w
```

---

### 1️⃣8️⃣ How do you permanently mount a partition?

1. Get UUID:

```bash
blkid
```

2. Edit `/etc/fstab`

3. Test:

```bash
mount -a
```

---

### 1️⃣9️⃣ How do you verify mount success?

```bash
df -h
lsblk -f
mount
```

---

### 2️⃣0️⃣ What is the safest workflow for disk configuration?

1. Identify disk
2. Confirm it is unused
3. Partition
4. Format
5. Mount temporarily
6. Test read/write
7. Configure fstab using UUID
8. Validate with `mount -a`

---

# 🏁 Final Interview Takeaway

This lab demonstrates foundational Linux storage administration skills:

* Disk detection
* Partitioning (MBR vs GPT)
* Formatting (ext4 & xfs)
* Mounting and persistence
* Troubleshooting storage issues

These are **core RHCSA objectives** and essential real-world skills for Linux system administrators.
