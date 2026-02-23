# 🛠️ Troubleshooting Guide – Lab 05: Linux File System Hierarchy

---

## 🔎 Overview

This document covers common issues encountered while:

- Navigating the filesystem
- Accessing restricted directories
- Using `find` and `locate`
- Creating symbolic and hard links
- Working with system files

Each issue includes symptoms, causes, and solutions.

---

# 1️⃣ Problem: Permission Denied While Accessing Directory

## 📌 Symptoms

```bash
ls: cannot open directory '/var/log': Permission denied
````

## 🧠 Possible Causes

* Directory requires elevated privileges
* User does not have read permissions

## ✅ Resolution

Use sudo:

```bash id="q3ty8n"
sudo ls /var/log
```

Check permissions:

```bash id="t8p3za"
ls -ld /var/log
```

---

# 2️⃣ Problem: `locate` Command Not Found

## 📌 Symptoms

```bash id="wz21aq"
locate: command not found
```

## 🧠 Possible Causes

* `mlocate` or `plocate` package not installed

## ✅ Resolution

Install locate package:

```bash id="k9rm3x"
sudo apt install mlocate -y
```

Update database:

```bash id="p6vs21"
sudo updatedb
```

---

# 3️⃣ Problem: `locate` Returns No Results

## 📌 Symptoms

Command runs but shows no output.

## 🧠 Possible Causes

* Database not updated
* File recently created

## ✅ Resolution

Update database manually:

```bash id="e8kn92"
sudo updatedb
```

Retry locate command.

---

# 4️⃣ Problem: Hard Link Creation Fails

## 📌 Symptoms

```bash id="m4kq82"
ln: failed to create hard link: Invalid cross-device link
```

## 🧠 Possible Causes

* Attempted to create hard link across different filesystems

## ✅ Resolution

Hard links only work within same filesystem.

Use symbolic link instead:

```bash id="t9lp38"
ln -s source_file link_name
```

---

# 5️⃣ Problem: Symbolic Link Broken

## 📌 Symptoms

```bash id="r3sx18"
ls -l linkname
linkname -> missingfile
```

or

```bash id="f7me91"
cat linkname
No such file or directory
```

## 🧠 Possible Causes

* Target file deleted or moved

## ✅ Resolution

Recreate symbolic link:

```bash id="z5mw72"
rm linkname
ln -s correct_target linkname
```

---

# 6️⃣ Problem: Cannot View `/etc/passwd`

## 📌 Symptoms

```bash id="o2xm63"
Permission denied
```

## 🧠 Possible Causes

* File permission restrictions
* Attempted to edit without privileges

## ✅ Resolution

View with:

```bash id="u7px48"
cat /etc/passwd
```

Edit only with sudo:

```bash id="n6wj19"
sudo nano /etc/passwd
```

⚠️ Editing passwd directly is not recommended unless necessary.

---

# 7️⃣ Problem: Cannot Create File in `/root`

## 📌 Symptoms

```bash id="b3kz75"
touch: cannot touch '/root/file': Permission denied
```

## 🧠 Possible Causes

* `/root` accessible only by root user

## ✅ Resolution

Switch to root:

```bash id="v4tx91"
sudo -i
```

Or create file in home directory instead.

---

# 8️⃣ Problem: `find` Takes Too Long

## 📌 Symptoms

Command appears stuck.

## 🧠 Possible Causes

* Searching entire filesystem (`/`)
* Large number of files

## ✅ Resolution

Limit search scope:

```bash id="h2pl80"
find /etc -name "*.conf"
```

Redirect errors:

```bash id="x8kw31"
find / -name "file" 2>/dev/null
```

---

# 9️⃣ Problem: Cannot Remove Hard Link

## 📌 Symptoms

File still exists after deleting one name.

## 🧠 Explanation

Hard links share same inode. Deleting one removes only that reference.

## ✅ Resolution

Delete all links referencing that inode:

```bash id="m9er42"
ls -i
rm filename
```

File removed only when last link is deleted.

---

# 🔟 Problem: Inode Numbers Are Different

## 📌 Symptoms

Expected hard link but inode differs.

## 🧠 Possible Causes

* Created symbolic link instead of hard link
* Created file copy instead of link

## ✅ Resolution

Verify link type:

```bash id="c4px27"
ls -l
```

Hard link should not show arrow (`->`).

---

# 🧠 Enterprise Best Practices

✔ Know where logs are stored (`/var/log`)
✔ Know where configs are stored (`/etc`)
✔ Avoid editing system files without backup
✔ Understand inode behavior for recovery
✔ Use `find` carefully on production systems

---

# 🔐 Security Insight

Understanding filesystem hierarchy helps in:

* Detecting privilege escalation attempts
* Identifying malicious symlinks
* Monitoring log tampering
* Preventing insecure temporary file usage
* Auditing system configurations

---

# 🏁 Final Takeaway

Filesystem mastery is essential for:

* RHCSA certification
* Linux system administration
* DevOps engineering
* Cloud infrastructure operations
* Security analysis

A strong Linux engineer always knows:

Where files live.
How links behave.
How permissions affect access.
How to diagnose filesystem-related problems.
