# 🛠️ Troubleshooting Guide – Lab 23: Managing Users and Groups

---

## 📌 Overview

User and group management issues are among the most common administrative problems in Linux environments.  
This document covers real-world errors encountered during the lab and their resolutions.

All troubleshooting was performed in a CentOS/RHEL cloud environment with root privileges.

---

# 1️⃣ Error: User Already Exists

### ❌ Example

```bash
useradd john
useradd: user 'john' already exists
````

### 🔍 Cause

The username already exists in `/etc/passwd`.

### ✅ Solution

Check before creating:

```bash
getent passwd john
```

If user exists, modify instead:

```bash
usermod -c "New Comment" john
```

---

# 2️⃣ Permission Denied When Creating Users

### ❌ Example

```bash
useradd newuser
useradd: Permission denied.
```

### 🔍 Cause

User is not root.

### ✅ Solution

Verify current user:

```bash
whoami
```

Switch to root:

```bash
sudo su -
```

Or use sudo:

```bash
sudo useradd newuser
```

---

# 3️⃣ Home Directory Not Created

### ❌ Problem

```bash
useradd -d /home/custom_user custom_user
```

Home directory does not exist.

### 🔍 Cause

`-d` sets the path but does NOT create the directory.

### ✅ Fix

Use `-m` flag:

```bash
useradd -m -d /home/custom_user custom_user
```

---

# 4️⃣ Cannot Delete Group

### ❌ Example

```bash
groupdel development
groupdel: cannot remove the primary group of user 'john'
```

### 🔍 Cause

The group is set as primary group of a user.

### ✅ Solution

Change user's primary group:

```bash
usermod -g john john
```

Then delete group:

```bash
groupdel development
```

---

# 5️⃣ GID Already Exists

### ❌ Example

```bash
groupmod -g 2001 admins
groupmod: GID '2001' already exists
```

### 🔍 Cause

Another group already uses that GID.

### ✅ Fix

Find available GID:

```bash
cut -d: -f3 /etc/group | sort -n | tail
```

Assign a free GID:

```bash
groupmod -g 2004 admins
```

---

# 6️⃣ Password Remains Locked After Unlock

### ❌ Example

```bash
usermod -U tom
passwd -S tom
tom LK ...
```

### 🔍 Cause

User never had a password set or account expiration still active.

### ✅ Fix

Set password:

```bash
passwd tom
```

Check expiration:

```bash
chage -l tom
```

---

# 7️⃣ User Cannot Login After Shell Change

### ❌ Example

```bash
usermod -s /bin/zsh sarah
```

Login fails.

### 🔍 Cause

Shell not installed or not listed in `/etc/shells`.

### ✅ Fix

Install shell:

```bash
yum install -y zsh
```

Verify:

```bash
cat /etc/shells
```

---

# 8️⃣ Secondary Groups Overwritten Accidentally

### ❌ Example

```bash
usermod -G developers mike
```

### 🔍 Cause

Missing `-a` flag removes existing secondary groups.

### ✅ Correct Way

```bash
usermod -a -G developers mike
```

Always use `-a` when appending.

---

# 9️⃣ User Home Directory Still Exists After Deletion

### ❌ Example

```bash
userdel tom
```

Home directory remains.

### 🔍 Cause

`-r` option not used.

### ✅ Correct Deletion

```bash
userdel -r username
```

---

# 🔟 Mail Spool Warning During Deletion

### ❌ Example

```bash
userdel -r alice
userdel: alice mail spool (/var/spool/mail/alice) not found
```

### 🔍 Cause

Mail subsystem not configured.

### ✅ Resolution

This warning is harmless and can be ignored.

---

# 1️⃣1️⃣ Account Expired Unexpectedly

### ❌ Example

```bash
usermod -e 1 secuser
```

Account expires immediately (epoch date).

### 🔍 Cause

Expiration set to Unix epoch.

### ✅ Fix

Set future expiration:

```bash
chage -E 2026-12-31 secuser
```

---

# 1️⃣2️⃣ Cannot Remove User from Group

### ❌ Example

```bash
gpasswd -d user group
```

Still appears in `id` output.

### 🔍 Cause

That group is primary group.

### ✅ Fix

Change primary group first:

```bash
usermod -g othergroup username
```

---

# 🔐 Security Best Practice Reminders

✔ Always verify changes using:

```bash
id username
groups username
passwd -S username
```

✔ Review user database files carefully:

* `/etc/passwd`
* `/etc/group`
* `/etc/shadow`

✔ Never manually edit `/etc/shadow` unless necessary.

✔ Use least privilege principle.

✔ Clean up test accounts after lab exercises.

---

# 🧠 Key Administrative Lessons

* Primary groups must be handled carefully before deletion.
* GID/UID conflicts are common in shared systems.
* Account locking is different from password expiration.
* Always verify with `getent`, not only `grep`.
* User lifecycle management includes creation, modification, validation, and cleanup.

---

# ✅ Final Validation Checklist

* [ ] Users created correctly
* [ ] Passwords set and verified
* [ ] Group memberships accurate
* [ ] No orphaned primary groups
* [ ] Test accounts removed
* [ ] Security policies demonstrated
* [ ] No lingering unintended access

---

# 🎯 Conclusion

This lab strengthened real-world user and group administration skills, including:

* Identity lifecycle management
* Secure account handling
* Group-based access control
* Troubleshooting identity issues
* Implementing password aging policies

These skills are essential for:

* RHCSA certification
* Linux system hardening
* Enterprise multi-user server administration
* Production system security management

---
