# 🎤 Interview Q&A – Lab 19: LVM Configuration (RHEL 9)

---

## 1️⃣ What is LVM?

Logical Volume Manager allows flexible disk management by abstracting physical storage into logical storage pools.

---

## 2️⃣ LVM Components?

| Component | Purpose |
|-----------|---------|
| PV | Physical Volume (disk) |
| VG | Volume Group (storage pool) |
| LV | Logical Volume (usable partition) |

---

## 3️⃣ Can you extend a mounted ext4 filesystem?

Yes.

```bash
lvextend -L +2G /dev/vg01/lv01
resize2fs /dev/vg01/lv01
````

---

## 4️⃣ Why must filesystem be shrunk before lvreduce?

To avoid data corruption.

Order:

1. Unmount
2. e2fsck
3. resize2fs
4. lvreduce

---

## 5️⃣ What are LVM snapshots used for?

* Backup
* Testing
* Rollback
* Database consistency

---

## 6️⃣ Difference between snapshot and full backup?

Snapshot:

* Copy-on-write
* Space efficient
* Temporary

Backup:

* Full data copy
* Independent storage

---

## 7️⃣ How do you list LVM structures?

```bash
pvs
vgs
lvs
```

---

## 8️⃣ Can you shrink XFS?

No.

XFS supports grow only, not shrink.
