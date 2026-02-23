# 🛠️ Troubleshooting Guide – Lab 08: Managing Password Policies

---

## 🔎 Overview

This guide covers common issues encountered while:

- Enforcing password complexity
- Configuring password aging
- Applying `chage` policies
- Locking inactive accounts
- Working with PAM configuration

Each issue includes symptoms, root causes, and resolution steps.

---

# 1️⃣ Problem: Weak Password Still Accepted

## 📌 Symptoms

User sets a weak password, but it is not rejected.

## 🧠 Possible Causes

- `libpwquality` not installed
- `pam_pwquality.so` not configured
- Wrong PAM file edited
- Syntax error in `pwquality.conf`

## ✅ Resolution

Verify package:

```bash
rpm -qa | grep libpwquality
````

Verify PAM integration:

```bash
grep pam_pwquality /etc/pam.d/system-auth
```

Ensure line exists:

```bash
password requisite pam_pwquality.so try_first_pass local_users_only
```

Restart authentication service if needed.

---

# 2️⃣ Problem: `pwscore` Command Not Found

## 📌 Symptoms

```bash
pwscore: command not found
```

## 🧠 Cause

`libpwquality` not installed.

## ✅ Resolution

```bash
sudo dnf install libpwquality -y
```

---

# 3️⃣ Problem: Password Aging Not Applied

## 📌 Symptoms

`chage -l username` does not show expected values.

## 🧠 Cause

Policies in `/etc/login.defs` only apply to new users.

## ✅ Resolution

Apply aging manually:

```bash
sudo chage -M 90 -m 7 -W 14 username
```

Verify:

```bash
sudo chage -l username
```

---

# 4️⃣ Problem: User Cannot Change Password Immediately

## 📌 Symptoms

```bash
You must wait longer to change your password
```

## 🧠 Cause

`PASS_MIN_DAYS` or `-m` value prevents immediate change.

## ✅ Resolution

Temporarily reset minimum days:

```bash
sudo chage -m 0 username
```

---

# 5️⃣ Problem: Account Locked Unexpectedly

## 📌 Symptoms

User cannot log in even with correct password.

## 🧠 Cause

Account expired or inactive period exceeded.

## ✅ Check Status

```bash
sudo chage -l username
```

Look for:

* Account expires
* Password inactive

## ✅ Unlock Account

```bash
sudo chage -E -1 username
sudo chage -I -1 username
```

---

# 6️⃣ Problem: Authentication Token Manipulation Error

## 📌 Symptoms

```bash
passwd: Authentication token manipulation error
```

## 🧠 Possible Causes

* Weak password rejected
* Disk full
* Incorrect PAM configuration
* SELinux denial

## ✅ Check Logs

```bash
sudo tail /var/log/secure
```

Check disk space:

```bash
df -h
```

---

# 7️⃣ Problem: PAM Misconfiguration Locks Out Users

## 📌 Symptoms

All password changes fail.

## 🧠 Cause

Improper edit in:

```
/etc/pam.d/system-auth
```

## ⚠️ Critical Warning

Incorrect PAM configuration can lock out root access.

## ✅ Resolution

Restore original configuration:

```bash
sudo authselect select sssd with-pwquality --force
```

Or restore backup file.

---

# 8️⃣ Problem: Password Expiration Not Enforced

## 📌 Symptoms

User never prompted to change password.

## 🧠 Cause

Password never set after `chage`.

## ✅ Resolution

Set password:

```bash
sudo passwd username
```

Then verify expiration:

```bash
sudo chage -l username
```

---

# 9️⃣ Problem: Inactivity Policy Not Working

## 📌 Symptoms

User not locked after expiration.

## 🧠 Cause

Inactivity days not configured.

## ✅ Set Inactivity

```bash
sudo chage -I 30 username
```

---

# 🔟 Problem: Wrong Date Format in Expiration

## 📌 Symptoms

Invalid date error.

## 🧠 Cause

Incorrect date format used with `-E`.

## ✅ Correct Format

```bash
sudo chage -E YYYY-MM-DD username
```

Example:

```bash
sudo chage -E 2026-03-25 username
```

---

# 🧠 Enterprise Best Practices

✔ Enforce minimum 12–15 character passwords
✔ Require multi-class characters
✔ Rotate passwords every 60–90 days
✔ Lock inactive accounts automatically
✔ Monitor `/var/log/secure` regularly
✔ Audit `/etc/shadow` for anomalies

---

# 🔐 Security Insight

Weak password policies lead to:

* Credential compromise
* Privilege escalation
* Lateral movement
* Ransomware incidents
* Compliance violations

Proper password management significantly reduces attack surface.

---

# 🏁 Final Takeaway

Password policy enforcement is essential for:

* Enterprise Linux security
* Compliance standards (CIS, NIST, ISO 27001)
* Cloud infrastructure security
* Zero-trust environments

Strong password governance is a core RHCSA and security administration competency.
