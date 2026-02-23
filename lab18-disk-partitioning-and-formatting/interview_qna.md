# 🎤 Interview Questions – Lab 18: Disk Partitioning and Formatting (RHEL 9)

---

## 1️⃣ Difference between MBR and GPT?

| MBR | GPT |
|-----|-----|
| Supports up to 2TB | Supports >2TB |
| Max 4 primary partitions | Up to 128 partitions |
| Older standard | Modern standard |

---

## 2️⃣ What is UUID and why use it?

UUID (Universally Unique Identifier) uniquely identifies a filesystem.

Best practice:
Use UUID in /etc/fstab instead of device names to avoid mount issues if disk order changes.

---

## 3️⃣ What does mkfs do?

Creates a filesystem on a partition.

Example:
```bash
mkfs.ext4 /dev/sdb1
````

---

## 4️⃣ What does the 6th field in /etc/fstab represent?

Filesystem check order:

* 0 → No check
* 1 → Root filesystem
* 2 → Other filesystems

---

## 5️⃣ How do you verify mounted filesystems?

```bash
df -hT
```

or

```bash
mount
```

---

## 6️⃣ How do you check swap usage?

```bash
swapon --show
free -h
```

---

## 7️⃣ What happens if /etc/fstab is misconfigured?

System may fail to boot.

Recovery:
Boot into emergency mode and fix /etc/fstab.

