# 🛠️ Troubleshooting Guide – Lab 12: SELinux Denial & Policy Debugging

---

## 🔎 Overview

This troubleshooting guide focuses on:

- Identifying AVC denials
- Diagnosing context mismatches
- Determining when to restore context vs create policy
- Safely generating custom SELinux modules
- Avoiding security misconfigurations

---

# 1️⃣ Problem: Web Server Cannot Access File

## 📌 Symptoms

- HTTP 403 Forbidden
- Apache fails to read file
- Permission denied despite correct Linux permissions

Example error:
```

Permission denied

````

---

## 🔍 Step 1: Confirm SELinux is Enforcing

```bash
getenforce
````

If output is:

```
Permissive
```

Switch to enforcing:

```bash
sudo setenforce 1
```

---

# 2️⃣ Problem: AVC Denials Present in Logs

## 🔎 Check Recent Denials

```bash
sudo ausearch -m avc -ts recent
```

Look for:

```
type=AVC avc: denied
```

---

## 🔍 Understand the Fields

Example:

```
scontext=system_u:system_r:httpd_t:s0
tcontext=unconfined_u:object_r:default_t:s0
```

Meaning:

* httpd_t → Apache process
* default_t → Incorrect file label

---

# 3️⃣ Correct Solution Path (Best Practice)

## ✅ Step 1: Check File Context

```bash
ls -Z /var/www/html/test.html
```

If label shows:

```
default_t
```

It is incorrect for web content.

---

## ✅ Step 2: Restore Correct Context

```bash
sudo restorecon -v /var/www/html/test.html
```

Verify:

```bash
ls -Z /var/www/html/test.html
```

Expected:

```
httpd_sys_content_t
```

✔ Most issues are fixed by restoring context.

---

# 4️⃣ When restorecon Does NOT Solve the Issue

Only proceed to custom policy if:

* Context is correct
* Denial still occurs
* Application requires additional access beyond default policy

---

# 5️⃣ Generate Custom Policy (Advanced)

## 🔎 Review Denials First

```bash
sudo ausearch -m avc -ts recent
```

## ⚙ Generate Module

```bash
sudo ausearch -m avc -ts recent | audit2allow -M mypolicy
```

## 📦 Install Module

```bash
sudo semodule -i mypolicy.pp
```

---

# 6️⃣ Verify Module Installation

```bash
sudo semodule -l | grep mypolicy
```

---

# 7️⃣ Problem: Policy Module Too Permissive

⚠ audit2allow may generate broad rules.

Before installing:

```bash
cat mypolicy.te
```

Review carefully.

Avoid allowing unnecessary permissions.

---

# 8️⃣ Problem: No AVC Logs Found

## Possible Causes

* SELinux disabled
* Audit service not running

## Check Audit Service

```bash
sudo systemctl status auditd
```

Start if needed:

```bash
sudo systemctl start auditd
```

---

# 9️⃣ Problem: Repeated Denials After Fix

## Solution

Clear old logs:

```bash
sudo ausearch -m avc -ts recent
```

Re-test service.

Confirm no new entries appear.

---

# 🔟 Enterprise Troubleshooting Flow

1. Confirm SELinux mode
2. Identify denial
3. Check file context
4. Use restorecon
5. Re-test
6. Only if required → create minimal policy
7. Validate and monitor

---

# 🔐 Security Warning

Never:

❌ Disable SELinux permanently
❌ Switch to Permissive in production
❌ Blindly install audit2allow rules

Always prefer:

✔ Context correction
✔ Minimal rule creation
✔ Log validation

---

# 🧠 Real-World Enterprise Scenarios

SELinux denials commonly occur in:

* Apache serving custom directories
* Podman containers with bind mounts
* NFS mounts without proper labeling
* Custom application services
* OpenShift deployments

Administrators must diagnose without weakening security posture.

---

# 📌 Useful Commands Summary

| Command         | Purpose                  |
| --------------- | ------------------------ |
| sestatus        | Full SELinux status      |
| getenforce      | Quick mode check         |
| ausearch -m avc | Search denials           |
| audit2allow     | Generate rules           |
| semodule        | Manage policy modules    |
| restorecon      | Restore default context  |
| ls -Z           | View file context        |
| chcon           | Temporary context change |

---

# 🏁 Final Takeaway

SELinux troubleshooting requires:

* Analytical log review
* Understanding context relationships
* Security-first decision making
* Minimal, controlled policy modification

Mastering these skills ensures secure enterprise Linux administration and prepares you for RHCSA and production-level environments.

---
