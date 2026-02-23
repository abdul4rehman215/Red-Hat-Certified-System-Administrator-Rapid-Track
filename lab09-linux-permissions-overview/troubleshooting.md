# 🛠️ Troubleshooting Guide – Lab 09: Linux Permissions Overview

---

## 🔎 Overview

This document covers common issues encountered while:

- Viewing permissions
- Modifying permissions with `chmod`
- Changing ownership with `chown`
- Changing group with `chgrp`
- Handling “Permission denied” errors

---

# 1️⃣ Problem: Permission Denied Error

## 📌 Symptoms

```bash
bash: ./script.sh: Permission denied
````

Or:

```bash
touch: cannot touch 'file.txt': Permission denied
```

## 🧠 Possible Causes

* Missing execute permission
* User does not own the file
* Directory lacks write permission
* SELinux restriction (RHEL-based systems)

## ✅ Resolution

Check permissions:

```bash
ls -l file.txt
```

Add execute permission if needed:

```bash
chmod +x script.sh
```

If root required:

```bash
sudo chmod ...
```

If directory write permission missing:

```bash
chmod u+w directory_name
```

---

# 2️⃣ Problem: Cannot Change Ownership

## 📌 Symptoms

```bash
chown: changing ownership of 'file.txt': Operation not permitted
```

## 🧠 Cause

Only root (or sudo user) can change file ownership.

## ✅ Resolution

Use sudo:

```bash
sudo chown user file.txt
```

---

# 3️⃣ Problem: User Cannot Access File After Ownership Change

## 📌 Symptoms

User reports inability to read/write file.

## 🧠 Cause

Incorrect permission bits after ownership change.

## ✅ Check:

```bash
ls -l file.txt
```

Adjust accordingly:

```bash
chmod 640 file.txt
```

Or give group access:

```bash
chmod 660 file.txt
```

---

# 4️⃣ Problem: Group Change Not Reflected

## 📌 Symptoms

User added to group but access still denied.

## 🧠 Cause

User must log out and log back in for group changes to apply.

## ✅ Resolution

Check group membership:

```bash
groups username
```

Re-login or run:

```bash
newgrp groupname
```

---

# 5️⃣ Problem: Recursive Permission Changes Affect System Files

## 📌 Symptoms

System tools stop working after running:

```bash
chmod -R 777 /
```

## ⚠️ Critical Warning

Never run recursive chmod on root filesystem.

## ✅ Prevention

Always verify path before using:

```bash
pwd
```

Use precise directory paths.

---

# 6️⃣ Problem: Numeric Permission Confusion

## 📌 Symptoms

Unexpected permission results after using numeric chmod.

## 🧠 Explanation

Each digit is sum of:

* 4 = Read
* 2 = Write
* 1 = Execute

Example:

| Value | Meaning |
| ----- | ------- |
| 7     | rwx     |
| 6     | rw-     |
| 5     | r-x     |
| 4     | r--     |

If incorrect value used, adjust accordingly.

---

# 7️⃣ Problem: Directory Cannot Be Entered

## 📌 Symptoms

```bash
cd directory
Permission denied
```

## 🧠 Cause

Execute (x) permission missing on directory.

## ✅ Resolution

```bash
chmod +x directory
```

---

# 8️⃣ Problem: File Accessible But Not Executable

## 📌 Symptoms

Script does not execute directly.

## 🧠 Cause

Execute permission missing.

## ✅ Fix

```bash
chmod +x script.sh
```

---

# 9️⃣ Problem: Permission Changes Not Persisting (RHEL/OpenShift)

## 📌 Possible Cause

SELinux policy enforcement.

Check SELinux status:

```bash
getenforce
```

If enforcing, check context:

```bash
ls -Z
```

Restore context if required:

```bash
restorecon -Rv directory/
```

---

# 🔟 Problem: Accidental Permission Exposure (777)

## 📌 Risk

Using:

```bash
chmod 777 file.txt
```

Grants full access to everyone.

## 🛑 Why Dangerous?

* Allows modification by any user
* Potential privilege escalation
* Data tampering risk

## ✅ Best Practice

Use least privilege principle:

* 640 for sensitive files
* 750 for secure directories
* 755 for executables

---

# 🔐 Security Best Practices

✔ Follow least privilege principle
✔ Avoid 777 permissions
✔ Use groups for shared access
✔ Audit permissions regularly
✔ Monitor `/var/log/auth.log` (Ubuntu)
✔ Monitor `/var/log/secure` (RHEL)

---

# 🧠 Enterprise Perspective

Incorrect permissions can lead to:

* Data breaches
* Unauthorized access
* Compliance violations
* Container breakout risks

Proper permission management is critical in:

* Red Hat Enterprise Linux
* OpenShift environments
* Multi-user servers
* Shared development systems

---

# 🏁 Final Takeaway

Linux permissions are the backbone of system access control.

Mastering:

* `chmod`
* `chown`
* `chgrp`
* Permission interpretation

Is essential for secure Linux administration and RHCSA certification.
