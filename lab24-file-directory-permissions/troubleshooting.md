# 🛠️ Troubleshooting Guide — Lab 24: File and Directory Permissions

> This document covers real-world permission and ACL-related issues encountered in Linux systems and how to systematically troubleshoot them.

---

# 🔎 1️⃣ Permission Denied When Accessing a File

## ❌ Problem
```bash
cat textfile.txt
Permission denied
````

## ✅ Step-by-Step Diagnosis

### 1. Check file permissions

```bash
ls -l textfile.txt
```

Example:

```text
-rw-r-----. 1 testuser centos 28 textfile.txt
```

### 2. Check current user

```bash
whoami
```

### 3. Check group membership

```bash
groups
```

### 4. Check ACLs

```bash
getfacl textfile.txt
```

---

## 🔧 Solution Options

* Add read permission:

```bash
chmod o+r textfile.txt
```

* Or add user-specific ACL:

```bash
setfacl -m u:centos:r textfile.txt
```

---

# 🔎 2️⃣ Cannot Enter Directory

## ❌ Problem

```bash
cd testdir
Permission denied
```

## 🔍 Diagnosis

Check directory permissions:

```bash
ls -ld testdir
```

If execute bit missing:

```text
drw-r--r--
```

---

## 🔧 Fix

Restore execute permission:

```bash
chmod +x testdir
```

> 💡 Important: Directories require execute (x) permission to traverse.

---

# 🔎 3️⃣ ACL Changes Not Taking Effect

## ❌ Problem

User still cannot access file even after ACL added.

## 🔍 Diagnosis

Check ACL:

```bash
getfacl filename
```

Look for:

```text
mask::r--
```

If mask is restrictive, effective permissions are limited.

---

## 🔧 Fix Mask

Update mask:

```bash
setfacl -m m::rw filename
```

---

# 🔎 4️⃣ Script Not Executing Even With 755

## ❌ Problem

```bash
./script.sh
Permission denied
```

## 🔍 Possible Causes

### 1️⃣ Filesystem mounted with noexec

```bash
mount | grep noexec
```

### 2️⃣ SELinux enforcing

```bash
getenforce
ls -Z script.sh
```

### 3️⃣ Parent directory lacks execute permission

Check:

```bash
ls -ld .
```

---

## 🔧 Solutions

If SELinux:

```bash
sudo restorecon -v script.sh
```

If mount issue:

```bash
sudo mount -o remount,exec /
```

If directory issue:

```bash
chmod +x parent_directory
```

---

# 🔎 5️⃣ setfacl or getfacl Command Not Found

## ❌ Problem

```bash
setfacl: command not found
```

## 🔧 Install ACL Utilities

For RHEL/CentOS:

```bash
sudo yum install acl -y
```

For Ubuntu/Debian:

```bash
sudo apt-get install acl -y
```

---

# 🔎 6️⃣ ACLs Not Supported on Filesystem

## ❌ Problem

ACL commands execute but no "+" appears in `ls -l`.

## 🔍 Check Mount Options

```bash
mount | grep acl
```

If missing:

## 🔧 Remount With ACL Support

```bash
sudo mount -o remount,acl /
```

---

# 🔎 7️⃣ Ownership Change Fails

## ❌ Problem

```bash
chown: changing ownership: Operation not permitted
```

## 🔍 Cause

Only root can change file ownership.

## 🔧 Fix

```bash
sudo chown user:group file
```

---

# 🔎 8️⃣ Default ACL Not Inherited

## ❌ Problem

New files in directory do not inherit ACL.

## 🔍 Diagnosis

Check default ACL:

```bash
getfacl directory
```

Look for:

```text
default:user:testuser:rwx
```

---

## 🔧 Fix

Add default ACL:

```bash
setfacl -m d:u:testuser:rwx directory
```

---

# 🔎 9️⃣ Cannot Delete File Inside Directory

## ❌ Problem

User has write permission on file but cannot delete it.

## 🔍 Important Concept

Deletion depends on **directory permissions**, not file permissions.

Check:

```bash
ls -ld directory
```

---

## 🔧 Fix

Grant write permission on directory:

```bash
chmod u+w directory
```

---

# 🔎 🔟 Sticky Bit Confusion

If directory has sticky bit (e.g., `/tmp`):

```text
drwxrwxrwt
```

Only file owner can delete their own files.

---

# 🧠 Systematic Permission Troubleshooting Workflow

When facing access issues:

```bash
ls -l filename
getfacl filename
id
groups
ls -ld parent_directory
mount
getenforce
```

Always verify:

* Ownership
* Standard permissions
* ACL entries
* Mask
* Directory execute bit
* SELinux status
* Filesystem mount options

---

# ⭐ Best Practices Recap

## 🔐 Security Guidelines

* Use 600 for sensitive files
* Avoid 777 unless absolutely necessary
* Use ACLs for fine-grained control
* Audit permissions regularly
* Apply least privilege principle
* Monitor group memberships

---

# 🎯 RHCSA Exam Relevance

This troubleshooting knowledge directly supports RHCSA objectives:

* File permissions management
* Ownership configuration
* ACL implementation
* Security best practices
* Diagnosing access failures

---
