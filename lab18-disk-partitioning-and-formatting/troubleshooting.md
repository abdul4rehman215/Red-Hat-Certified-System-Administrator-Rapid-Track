# 🛠 Troubleshooting Guide – Lab 18: Disk Partitioning and Formatting

---

# 1️⃣ Disk Not Visible

## Check:
```bash
lsblk
````

Rescan SCSI:

```bash
echo "- - -" | sudo tee /sys/class/scsi_host/host*/scan
```

---

# 2️⃣ Partition Table Not Updated

Run:

```bash
sudo partprobe
```

---

# 3️⃣ Mount Fails

Error:
wrong fs type, bad option

Check:

```bash
blkid
lsblk -f
```

---

# 4️⃣ fstab Causes Boot Failure

Boot into:

* Emergency mode
* Edit /etc/fstab
* Comment faulty line

Use:

```bash
mount -a
```

before reboot to validate.

---

# 5️⃣ Swap Not Activating

Check:

```bash
swapon --show
```

Enable:

```bash
sudo swapon -a
```

---

# 6️⃣ Filesystem Corruption

Check:

```bash
sudo fsck /dev/sdb1
```

---

# 🔐 Enterprise Best Practices

✔ Always use UUID in fstab
✔ Test with `mount -a` before reboot
✔ Avoid modifying production disks without backup
✔ Prefer GPT for modern systems
✔ Document partition layout

---

# 🏁 Final Note

Improper disk management can result in:

* Data loss
* Boot failures
* Production downtime
* Corrupted filesystems

Enterprise Linux storage requires precision and validation.
