# 🛠 Troubleshooting Guide – Lab 19: LVM Configuration (RHEL 9)

---

# 1️⃣ PV Creation Fails

Check disk:
```bash
lsblk
````

Remove old signatures:

```bash
wipefs -a /dev/sdc
```

---

# 2️⃣ VG Creation Fails

Check if PV exists:

```bash
pvdisplay
```

---

# 3️⃣ Mount Fails

Check filesystem:

```bash
blkid
lsblk -f
```

---

# 4️⃣ Extend LV but Size Not Updated

Run:

```bash
resize2fs /dev/vg01/lv01
```

---

# 5️⃣ Shrink Causes Error

Ensure:

* Filesystem unmounted
* e2fsck run first
* resize2fs done before lvreduce

---

# 6️⃣ Snapshot Becomes Invalid

Snapshot space exhausted.

Check:

```bash
lvs
```

Increase snapshot size if needed.

---

# 7️⃣ View LVM Overview

```bash
pvs
vgs
lvs
```

---

# 🔐 Enterprise Best Practices

✔ Always backup before shrinking
✔ Use UUID in /etc/fstab
✔ Monitor snapshot usage
✔ Use XFS for production (grow-only safe)
✔ Avoid shrinking in production

---

# 🏁 Final Note

Improper LVM operations can result in:

* Data corruption
* Unbootable systems
* Production downtime

LVM enables enterprise-grade dynamic storage management.
