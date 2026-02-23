# 🎤 Interview Q&A – Lab 05: Linux File System Hierarchy

> This section contains commonly asked interview questions related to the Linux File System Hierarchy (FHS), navigation, and link management.

---

## 1️⃣ What is the root directory in Linux?

**Answer:**

The root directory (`/`) is the top-level directory of the Linux file system.  
All other directories and files originate from `/`.

It acts as the starting point of the entire hierarchy.

---

## 2️⃣ What is the purpose of the `/etc` directory?

**Answer:**

`/etc` contains system-wide configuration files.

Examples:
- `/etc/passwd` → user accounts
- `/etc/shadow` → encrypted passwords
- `/etc/fstab` → filesystem mount configuration
- `/etc/hosts` → local hostname mapping

---

## 3️⃣ What is the difference between `/bin` and `/sbin`?

**Answer:**

- `/bin` → Essential user command binaries (e.g., `ls`, `cp`, `cat`)
- `/sbin` → System administration binaries (e.g., `reboot`, `iptables`, `fsck`)

`/sbin` typically requires elevated privileges.

---

## 4️⃣ What is stored inside `/var`?

**Answer:**

`/var` contains variable data such as:

- Logs (`/var/log`)
- Mail queues
- Spool files
- Cache
- Runtime data

Logs are critical for troubleshooting.

---

## 5️⃣ What is the purpose of `/tmp`?

**Answer:**

`/tmp` stores temporary files.

- Often cleared on reboot
- World-writable directory
- Used by applications during runtime

---

## 6️⃣ What is an inode?

**Answer:**

An inode is a data structure that stores metadata about a file, including:

- File size
- Ownership
- Permissions
- Timestamps
- Disk block locations

It does NOT store the filename.

---

## 7️⃣ What is a hard link?

**Answer:**

A hard link:

- Shares the same inode as the original file
- Points directly to file data
- Cannot link across filesystems
- Cannot link directories (normally)

Both filenames are equal references to the same file.

---

## 8️⃣ What is a symbolic (soft) link?

**Answer:**

A symbolic link:

- Points to the filename/path of another file
- Has a different inode
- Can link across filesystems
- Can link directories
- Breaks if target file is deleted

Created using:

```bash
ln -s target linkname
````

---

## 9️⃣ How do you identify a symbolic link?

**Answer:**

Use:

```bash
ls -l
```

Symbolic links start with:

```
l
```

Example:

```
lrwxrwxrwx 1 root root 7 sh -> dash
```

---

## 🔟 How do you compare inodes of files?

**Answer:**

Use:

```bash
ls -i filename
```

If two files share the same inode number → they are hard links.

---

## 1️⃣1️⃣ What is the purpose of `/usr`?

**Answer:**

`/usr` contains user applications and utilities.

Subdirectories:

* `/usr/bin`
* `/usr/sbin`
* `/usr/lib`
* `/usr/local`

It holds most installed software.

---

## 1️⃣2️⃣ What is the difference between absolute and relative paths?

**Answer:**

* Absolute path → starts from `/`
  Example: `/etc/passwd`

* Relative path → based on current directory
  Example: `../file.txt`

---

## 1️⃣3️⃣ How can you search for files in Linux?

**Answer:**

Using:

```bash
find /path -name "filename"
```

or

```bash
locate filename
```

`locate` requires updated database (`updatedb`).

---

## 1️⃣4️⃣ Why is understanding filesystem hierarchy important?

**Answer:**

Because it helps in:

* Troubleshooting issues
* Finding configuration files
* Log analysis
* Managing users
* Installing software
* Security auditing

It is foundational for Linux administration.

---

## 🧠 Final Interview Insight

A strong Linux administrator:

* Knows where configuration files are stored
* Understands inode behavior
* Can navigate efficiently
* Knows log locations
* Understands link types

Filesystem knowledge is the backbone of RHCSA-level expertise.
