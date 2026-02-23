# 🛠️ Troubleshooting Guide – Lab 10: Managing Special Permission Bits

---

## 🔎 Overview

This guide covers common issues related to:

- Sticky Bit
- setuid
- setgid
- Special permission verification
- Mount option conflicts
- Security misconfigurations

---

# 1️⃣ Problem: Sticky Bit Not Preventing File Deletion

## 📌 Symptoms

A non-owner can delete another user's file in a shared directory.

## 🧠 Possible Causes

- Sticky bit not applied correctly
- Directory permissions incorrect
- Wrong directory tested

## ✅ Verify Sticky Bit

```bash
ls -ld /tmp/shared_dir
````

Expected:

```
drwxrwxrwt
```

If missing, apply:

```bash
chmod +t /tmp/shared_dir
```

---

# 2️⃣ Problem: setuid Not Working

## 📌 Symptoms

Running executable as another user does NOT elevate privileges.

Example:

```
Effective UID: 65534
```

Instead of:

```
Effective UID: 0
```

## 🧠 Possible Causes

* Filesystem mounted with `nosuid`
* File not owned by root
* Execute bit missing
* Script-based setuid (some systems restrict this)

## ✅ Check Mount Options

```bash
mount | grep nosuid
```

If `nosuid` present → setuid will be ignored.

---

## ✅ Verify Ownership

```bash
ls -l /usr/local/bin/show_euid
```

Ensure:

```
root root
```

Apply:

```bash
sudo chown root:root file
sudo chmod u+s file
```

---

# 3️⃣ Problem: setgid Not Inheriting Group

## 📌 Symptoms

Files created in directory do not inherit group ownership.

## 🧠 Cause

setgid bit not applied to directory.

## ✅ Fix

```bash
chmod g+s directory
```

Verify:

```bash
ls -ld directory
```

Look for:

```
drwxr-sr-x
```

---

# 4️⃣ Problem: Special Bits Showing as Capital Letters (S or T)

## 📌 Example

```
-rwSr--r--
```

Or:

```
drwxrwxrwT
```

## 🧠 Meaning

* Capital `S` or `T` → execute bit missing
* Special bit applied incorrectly

## ✅ Fix

Add execute permission:

```bash
chmod +x file
```

---

# 5️⃣ Problem: Script setuid Not Working

## 📌 Important Note

Many Linux systems ignore setuid on shell scripts for security reasons.

This is to prevent:

* Race condition exploits
* Privilege escalation attacks

## ✅ Best Practice

Use compiled binaries instead of scripts for secure setuid functionality.

---

# 6️⃣ Problem: Permission Denied After Applying setuid

## 📌 Symptoms

```
Operation not permitted
```

## 🧠 Cause

* SELinux policy enforcement
* Immutable attribute set
* Filesystem restrictions

## ✅ Check SELinux Status

```bash
getenforce
```

If enforcing, check context:

```bash
ls -Z file
```

Restore context:

```bash
restorecon file
```

---

# 7️⃣ Problem: Cannot Remove Sticky Directory

## 📌 Symptoms

Deletion fails even as owner.

## 🧠 Cause

Directory may contain files owned by root.

## ✅ Solution

Use sudo:

```bash
sudo rm -r directory
```

---

# 8️⃣ Problem: Special Permission Bits Removed Accidentally

## 📌 Cause

Using numeric chmod overwrites special bits.

Example:

```bash
chmod 755 file
```

Removes setuid (4755 → 0755).

## ✅ Preserve Special Bits

Use 4xxx format:

```bash
chmod 4755 file
```

---

# 9️⃣ Security Auditing Commands

## 🔎 Find setuid files

```bash
find / -perm -4000 2>/dev/null
```

## 🔎 Find setgid files

```bash
find / -perm -2000 2>/dev/null
```

## 🔎 Find sticky directories

```bash
find / -perm -1000 2>/dev/null
```

---

# 🔟 Best Security Practices

✔ Minimize setuid binaries
✔ Audit special bits regularly
✔ Avoid unnecessary 777 directories
✔ Use sticky bit for shared folders
✔ Monitor `/usr/local/bin` for unauthorized setuid programs
✔ Restrict mount options appropriately

---

# 🧠 Enterprise Security Insight

Improper special permission configuration can lead to:

* Privilege escalation attacks
* Lateral movement
* Root compromise
* Container breakout vulnerabilities

Security teams regularly audit these permissions in:

* RHEL servers
* OpenShift nodes
* Shared DevOps environments
* Multi-tenant systems

---

# 🏁 Final Takeaway

Special permission bits are powerful and sensitive mechanisms.

Understanding:

* Sticky bit behavior
* setuid privilege escalation
* setgid group enforcement
* Mount restrictions (`nosuid`)
* SELinux interaction

Is critical for secure Linux administration and RHCSA certification.
