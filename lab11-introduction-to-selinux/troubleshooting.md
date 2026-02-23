# 🛠️ Troubleshooting Guide – Lab 11: Introduction to SELinux

---

## 🔎 Overview

This guide covers common SELinux issues related to:

- Mode switching
- Context misconfiguration
- AVC denials
- Policy module creation
- Service failures due to SELinux enforcement

---

# 1️⃣ Problem: Service Not Starting in Enforcing Mode

## 📌 Symptoms

Service works in Permissive mode but fails in Enforcing mode.

Example:
```

httpd: Permission denied

````

## 🧠 Cause

SELinux policy is blocking the service.

## ✅ Check for Denials

```bash
sudo ausearch -m avc -ts recent
````

Look for:

```
type=AVC
```

---

# 2️⃣ Problem: File Accessible via Linux Permissions but Blocked by SELinux

## 📌 Symptoms

* File has correct `rwx` permissions
* Still receiving "Permission denied"

## 🧠 Cause

Incorrect SELinux context.

## ✅ Check Context

```bash
ls -Z filename
```

Example wrong context:

```
unconfined_u:object_r:default_t:s0
```

---

## ✅ Fix Context

Restore default:

```bash
sudo restorecon -v filename
```

Or change to required type:

```bash
sudo chcon -t httpd_sys_content_t filename
```

---

# 3️⃣ Problem: setenforce Not Working

## 📌 Symptoms

```bash
setenforce: SELinux is disabled
```

## 🧠 Cause

SELinux is disabled in configuration file.

## ✅ Verify

```bash
sestatus
```

If disabled:

Edit:

```
/etc/selinux/config
```

Change:

```
SELINUX=enforcing
```

Reboot required.

---

# 4️⃣ Problem: Context Changes Revert After Reboot

## 📌 Cause

`chcon` makes temporary changes only.

## ✅ Permanent Fix

Use `semanage`:

```bash
sudo semanage fcontext -a -t httpd_sys_content_t "/var/www/html(/.*)?"
sudo restorecon -Rv /var/www/html
```

---

# 5️⃣ Problem: Too Many AVC Denials

## 📌 Symptoms

Multiple repeated AVC logs.

## ✅ Analyze Logs

```bash
sudo ausearch -m avc -ts recent
```

Or:

```bash
sudo sealert -a /var/log/audit/audit.log
```

---

# 6️⃣ Problem: Generating Policy Module

## 📌 Create Policy

```bash
sudo ausearch -m avc -ts recent | audit2allow -M mypolicy
sudo semodule -i mypolicy.pp
```

## ⚠️ Warning

Blindly applying policy modules may weaken security.

Always review generated rules before installation.

---

# 7️⃣ Problem: Filesystem Mounted Without SELinux Support

## 📌 Symptoms

Contexts not applied correctly.

## ✅ Check Mount

```bash
mount | grep selinux
```

Ensure SELinux is enabled at boot.

---

# 8️⃣ Problem: Relabel Required After Major Changes

## 📌 Fix Full Relabel

```bash
sudo touch /.autorelabel
sudo reboot
```

System relabels all files on reboot.

---

# 9️⃣ Common SELinux Tools Reference

| Command     | Purpose                 |
| ----------- | ----------------------- |
| sestatus    | Full SELinux status     |
| getenforce  | Quick mode check        |
| setenforce  | Change mode temporarily |
| ls -Z       | View file context       |
| restorecon  | Restore default context |
| ausearch    | Search audit logs       |
| audit2allow | Generate policy module  |
| semodule    | Manage policy modules   |

---

# 🔟 Enterprise Best Practices

✔ Keep SELinux in Enforcing mode
✔ Avoid disabling SELinux in production
✔ Use Permissive mode only for troubleshooting
✔ Restore contexts using restorecon
✔ Audit AVC denials regularly
✔ Avoid unnecessary custom policies

---

# 🧠 Security Insight

SELinux prevents:

* Compromised web servers accessing system files
* Privilege escalation attacks
* Container breakout
* Unauthorized service interactions

It provides an additional security boundary beyond file permissions.

---

# 🏁 Final Takeaway

SELinux is a powerful security layer enforcing Mandatory Access Control.

Understanding:

* Enforcement modes
* Context management
* Policy troubleshooting
* AVC denial analysis

Is critical for enterprise Linux security and RHCSA certification.
