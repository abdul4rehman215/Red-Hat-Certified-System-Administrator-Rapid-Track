
# 🛠️ Troubleshooting Guide – Lab 22: File System Navigation

---

## 📌 Overview

This document outlines common issues encountered while navigating the Linux file system and managing permissions in a CentOS/RHEL environment.

The troubleshooting scenarios below reflect realistic beginner-to-intermediate mistakes commonly faced in RHCSA practice and real-world Linux administration.

---

# 1️⃣ "No such file or directory" Error

### ❌ Example

```bash
cd Documents
-bash: cd: Documents: No such file or directory
````

### 🔍 Cause

* Directory does not exist
* Typographical error
* Wrong current location

### ✅ Solution

Verify location:

```bash
pwd
ls
```

Search for directory:

```bash
find . -type d -name "Documents"
```

---

# 2️⃣ Cannot Enter a Directory (Permission Denied)

### ❌ Example

```bash
ls permission_test_dir
ls: cannot open directory permission_test_dir: Permission denied
```

### 🔍 Cause

Directory does not have execute (`x`) permission.

### ✅ Solution

Check permissions:

```bash
ls -ld permission_test_dir
```

Restore execute permission:

```bash
chmod +x permission_test_dir
```

Or restore full working permissions:

```bash
chmod 755 permission_test_dir
```

---

# 3️⃣ Script Not Executing

### ❌ Example

```bash
./myscript.sh
-bash: ./myscript.sh: Permission denied
```

### 🔍 Cause

Execute permission missing.

### ✅ Fix

```bash
chmod +x myscript.sh
./myscript.sh
```

---

# 4️⃣ Wrong Numeric Permission Applied

### ❌ Problem

Applying:

```bash
chmod 644 directory_name
```

On a directory removes execute permission.

### 🔍 Result

* Cannot enter directory
* Cannot list files

### ✅ Correct Directory Permission

```bash
chmod 755 directory_name
```

---

# 5️⃣ Cannot Create Files in Directory

### ❌ Example

```bash
touch newfile.txt
touch: cannot touch ‘newfile.txt’: Permission denied
```

### 🔍 Cause

No write permission on directory.

### ✅ Check Directory Permissions

```bash
ls -ld .
```

If missing write permission:

```bash
chmod u+w .
```

---

# 6️⃣ `find` Returns Too Many Results

### 🔍 Cause

Search path too broad.

### ✅ Solution

Limit output:

```bash
find /etc -name "*.conf" -type f 2>/dev/null | head -10
```

Add depth limitation:

```bash
find . -maxdepth 2 -type f
```

---

# 7️⃣ Confusion Between Relative and Absolute Paths

### ❌ Example

```bash
cd lab2_practice
```

Fails if not inside correct directory.

### ✅ Use Absolute Path

```bash
cd /home/centos/lab2_practice
```

Or shortcut:

```bash
cd ~/lab2_practice
```

---

# 8️⃣ Numeric Permission Confusion

### 🔍 Understanding

Permission calculation:

| Permission | Value |
| ---------- | ----- |
| r          | 4     |
| w          | 2     |
| x          | 1     |

Example:

```
rwxr-x--- = 750
```

Calculation:

* 7 = 4+2+1
* 5 = 4+1
* 0 = 0

---

# 9️⃣ Symbolic chmod Not Working as Expected

### ❌ Example

```bash
chmod g+x file
```

### 🔍 Cause

User misunderstanding current permissions.

### ✅ Verify Before and After

```bash
ls -l file
chmod g+x file
ls -l file
```

---

# 🔟 Tree Command Not Installed

### ❌ Example

```bash
tree .
-bash: tree: command not found
```

### ✅ Alternative

```bash
find . -type d
```

---

# 1️⃣1️⃣ Incorrect Permission on Script

If script fails even after `chmod +x`, check:

```bash
head -1 myscript.sh
```

Ensure shebang exists:

```bash
#!/bin/bash
```

---

# 🧠 Best Practices Learned

* Always verify location using `pwd`
* Use `ls -l` before modifying permissions
* Never remove execute permission from directories unintentionally
* Use numeric mode for precise permission control
* Use symbolic mode for incremental changes
* Suppress unnecessary errors using `2>/dev/null`
* Use `stat` to confirm numeric permissions

---

# ✅ Final Validation Checklist

Before marking Lab 02 complete:

* [ ] Directory structure created successfully
* [ ] Files moved and copied correctly
* [ ] Permissions modified as expected
* [ ] Script executed successfully
* [ ] Directory permission behavior demonstrated
* [ ] Numeric permissions verified using `stat`
* [ ] No unresolved permission errors

---

# 🎯 Summary

This lab strengthened:

* Directory traversal mastery
* Permission management skills
* Access control understanding
* Troubleshooting techniques
* Real-world Linux administrative confidence

These skills are fundamental for:

* RHCSA certification
* Linux server management
* Security hardening
* Production environment operations

---
