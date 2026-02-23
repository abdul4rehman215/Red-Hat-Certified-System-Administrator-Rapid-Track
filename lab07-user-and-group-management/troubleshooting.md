# 🛠️ Troubleshooting Guide – Lab 07: User and Group Management

---

## 🔎 Overview

This document outlines common issues encountered during:

- Creating users
- Modifying user attributes
- Managing groups
- Assigning users to groups
- Deleting users and groups

Each issue includes symptoms, root causes, and resolution steps.

---

# 1️⃣ Problem: `useradd` Permission Denied

## 📌 Symptoms

```bash
useradd: Permission denied.
````

## 🧠 Cause

User lacks administrative privileges.

## ✅ Resolution

Run command with sudo:

```bash id="z37na9"
sudo useradd username
```

Ensure current user belongs to `sudo` group:

```bash id="ovl3c5"
groups
```

---

# 2️⃣ Problem: User Already Exists

## 📌 Symptoms

```bash
useradd: user 'labuser1' already exists
```

## 🧠 Cause

Username already present in system.

## ✅ Resolution

Check user:

```bash id="6hs2jp"
id labuser1
```

Delete existing user if needed:

```bash id="9qtxua"
sudo userdel -r labuser1
```

---

# 3️⃣ Problem: Cannot Delete User

## 📌 Symptoms

```bash
userdel: user labuser1 is currently used by process 1234
```

## 🧠 Cause

User has active processes.

## ✅ Resolution

Terminate processes:

```bash id="mg9t6b"
sudo pkill -u labuser1
```

Then retry:

```bash id="u07jvb"
sudo userdel -r labuser1
```

---

# 4️⃣ Problem: Home Directory Not Created

## 📌 Symptoms

User exists but `/home/username` missing.

## 🧠 Cause

User created without `-m` option.

## ✅ Resolution

Create directory manually:

```bash id="0xmq4l"
sudo mkdir /home/username
sudo chown username:username /home/username
```

Or recreate user with:

```bash id="joxw7v"
sudo useradd -m username
```

---

# 5️⃣ Problem: User Not Added to Group

## 📌 Symptoms

```bash
groups username
```

Does not show expected group.

## 🧠 Cause

Forgot `-a` flag.

Incorrect command:

```bash
sudo usermod -G developers username
```

## ✅ Correct Command

```bash id="m1t2q3"
sudo usermod -aG developers username
```

---

# 6️⃣ Problem: Group Already Exists

## 📌 Symptoms

```bash
groupadd: group 'developers' already exists
```

## 🧠 Cause

Group already defined in `/etc/group`.

## ✅ Resolution

Verify:

```bash id="ok79sb"
grep developers /etc/group
```

Delete if necessary:

```bash id="d4tlh0"
sudo groupdel developers
```

---

# 7️⃣ Problem: Shell Not Changed

## 📌 Symptoms

`/etc/passwd` still shows old shell.

## 🧠 Cause

Incorrect shell path or typo.

## ✅ Resolution

List valid shells:

```bash id="r6cw5a"
cat /etc/shells
```

Then update:

```bash id="1xfq4n"
sudo usermod -s /bin/bash username
```

---

# 8️⃣ Problem: Cannot Remove Group

## 📌 Symptoms

```bash
groupdel: cannot remove the primary group of user 'labuser1'
```

## 🧠 Cause

Group is primary group of a user.

## ✅ Resolution

Change user's primary group first:

```bash id="v3mz8e"
sudo usermod -g newgroup username
```

Then delete group.

---

# 9️⃣ Problem: Incorrect UID or GID Assignment

## 📌 Symptoms

Unexpected UID values.

## 🧠 Cause

System automatically assigns next available UID.

## ✅ Manual Assignment

```bash id="q6rb8x"
sudo useradd -u 1050 username
```

Ensure UID not already in use:

```bash id="7pdnxt"
getent passwd 1050
```

---

# 🔟 Problem: User Cannot Login

## 📌 Symptoms

Login fails.

## 🧠 Possible Causes

* Shell set to `/usr/sbin/nologin`
* Password not set

## ✅ Fix

Set shell:

```bash id="g3pdns"
sudo usermod -s /bin/bash username
```

Set password:

```bash id="04y1tx"
sudo passwd username
```

---

# 🧠 Enterprise Best Practices

✔ Follow least privilege principle
✔ Avoid giving sudo access unnecessarily
✔ Remove unused accounts
✔ Monitor `/etc/passwd` and `/etc/group`
✔ Disable rather than delete accounts when auditing

Disable user without deleting:

```bash id="kpl1or"
sudo usermod -L username
```

---

# 🔐 Security Insight

Improper user management can lead to:

* Privilege escalation
* Unauthorized access
* Insider threats
* Compliance violations
* Audit failures

Proper user lifecycle management is critical for enterprise security posture.

---

# 🏁 Final Takeaway

User and group management is essential for:

* Secure server environments
* Cloud infrastructure
* Multi-user systems
* DevOps pipelines
* RHCSA certification readiness

Strong administrators always:

* Audit user accounts regularly
* Manage group membership carefully
* Remove stale users
* Enforce secure shell policies
