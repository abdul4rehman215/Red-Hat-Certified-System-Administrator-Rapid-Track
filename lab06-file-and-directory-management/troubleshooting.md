# 🛠️ Troubleshooting Guide – Lab 06: File and Directory Management

---

## 🔎 Overview

This document outlines common issues encountered while:

- Creating or deleting files
- Moving and copying directories
- Using relative and absolute paths
- Performing recursive operations
- Using wildcards

Each issue includes symptoms, causes, and resolution steps.

---

# 1️⃣ Problem: Permission Denied While Deleting File

## 📌 Symptoms

```bash
rm: cannot remove 'file.txt': Permission denied
````

## 🧠 Possible Causes

* File owned by another user
* Insufficient write permissions on directory

## ✅ Resolution

Check ownership and permissions:

```bash
ls -l file.txt
```

Use sudo if necessary:

```bash
sudo rm file.txt
```

Or modify permissions:

```bash
chmod u+w file.txt
```

---

# 2️⃣ Problem: Cannot Remove Directory with `rmdir`

## 📌 Symptoms

```bash
rmdir: failed to remove 'documents': Directory not empty
```

## 🧠 Cause

`rmdir` only works on empty directories.

## ✅ Resolution

Use recursive removal:

```bash
rm -r documents
```

Or delete contents first:

```bash
rm documents/*
rmdir documents
```

---

# 3️⃣ Problem: Accidentally Deleted Important Files

## 📌 Symptoms

Files permanently removed.

## 🧠 Cause

Used:

```bash
rm -rf
```

## ⚠️ Important

Linux does not provide built-in undo for `rm`.

## ✅ Prevention Strategy

* Always verify directory using:

```bash
pwd
```

* Use interactive mode:

```bash
rm -i filename
```

* Use backups or version control.

---

# 4️⃣ Problem: Copying Directory Fails

## 📌 Symptoms

```bash
cp: -r not specified; omitting directory 'projects'
```

## 🧠 Cause

Recursive option missing.

## ✅ Resolution

Use:

```bash
cp -r projects backup_projects
```

---

# 5️⃣ Problem: Moving File Overwrites Existing File

## 📌 Symptoms

File replaced without warning.

## 🧠 Cause

`mv` overwrites by default.

## ✅ Prevention

Use interactive mode:

```bash
mv -i file.txt destination/
```

---

# 6️⃣ Problem: Wildcard Moves Too Many Files

## 📌 Symptoms

Unexpected files moved with:

```bash
mv *.txt projects/doc/
```

## 🧠 Cause

Wildcard matches all `.txt` files in current directory.

## ✅ Best Practice

Preview first:

```bash
ls *.txt
```

Then move.

---

# 7️⃣ Problem: Absolute Path Incorrect

## 📌 Symptoms

```bash
No such file or directory
```

## 🧠 Cause

Typo or incorrect path.

## ✅ Resolution

Verify path exists:

```bash
ls /home/toor/file_management_lab
```

Use tab completion for accuracy.

---

# 8️⃣ Problem: Command Not Found (`tree`)

## 📌 Symptoms

```bash
tree: command not found
```

## 🧠 Cause

Package not installed.

## ✅ Resolution

Install:

```bash
sudo apt install tree -y
```

---

# 9️⃣ Problem: Cannot Move File Across Filesystems

## 📌 Symptoms

Operation slow or unexpected inode change.

## 🧠 Explanation

Moving across filesystems performs copy + delete.

## ✅ Verification

Check inode before and after:

```bash
ls -i filename
```

---

# 🔟 Problem: Relative Path Confusion

## 📌 Symptoms

Command affects wrong directory.

## 🧠 Cause

Incorrect understanding of current directory.

## ✅ Prevention

Always verify with:

```bash
pwd
```

And list contents:

```bash
ls
```

---

# 🧠 Enterprise Best Practices

✔ Always verify working directory before deletion
✔ Use absolute paths in automation scripts
✔ Avoid running `rm -rf` blindly
✔ Use version control for important files
✔ Validate wildcard matches before executing

---

# 🔐 Security Insight

Improper file management can cause:

* Privilege escalation vulnerabilities
* Log tampering
* Data leakage
* Service downtime
* Container build failures

Understanding file operations is critical for secure infrastructure management.

---

# 🏁 Final Takeaway

File and directory management is fundamental for:

* RHCSA certification
* Linux system administration
* DevOps automation
* Cloud infrastructure operations
* Cybersecurity workflows

A disciplined approach to file operations prevents costly mistakes in production environments.
