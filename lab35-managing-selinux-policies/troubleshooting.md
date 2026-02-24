# 🛠 Troubleshooting Guide – Lab 35: Maanging SELinux Policies

> This guide documents common SELinux-related issues encountered during the lab and the systematic approach used to diagnose and resolve them.

---

# 🔍 1️⃣ Service Running but Access Denied (HTTP 403)

## ❌ Problem
Apache starts successfully, but accessing the site returns:

```

403 Forbidden
You don't have permission to access this resource.

````

## 🔎 Diagnosis Workflow

### Step 1: Confirm Service Is Running
```bash
sudo systemctl status httpd
````

### Step 2: Check File Permissions (DAC)

```bash
ls -l /home/testuser/website/
```

If permissions are correct → likely SELinux issue.

### Step 3: Check SELinux Context

```bash
ls -Z /home/testuser/website/
```

Output showed:

```
user_home_t
```

⚠ Apache expects:

```
httpd_sys_content_t
```

---

## ✅ Solution (Best Practice)

Use persistent labeling:

```bash
sudo semanage fcontext -a -t httpd_sys_content_t "/home/testuser/website(/.*)?"
sudo restorecon -R -v /home/testuser/website/
```

Verify:

```bash
ls -Z /home/testuser/website/
```

Test again:

```bash
curl http://localhost/
```

---

# 🔥 2️⃣ SELinux Denials in Audit Logs

## ❌ Problem

Application fails silently or returns permission error.

## 🔎 Check for AVC Denials

```bash
sudo ausearch -m avc -ts recent
```

Example denial:

```
avc: denied { read } for pid=1923 comm="httpd"
tcontext=unconfined_u:object_r:user_home_t:s0
```

Interpretation:

* `httpd_t` tried to read a file labeled `user_home_t`
* Policy blocks this access

---

## 🧠 Use `sealert` for Analysis

```bash
sudo sealert -a /var/log/audit/audit.log
```

It suggests:

* Enable boolean
* Or change file labeling

Prefer relabeling first.

---

# 🌐 3️⃣ Application Cannot Bind to Custom Port

## ❌ Problem

Service configured for port 8080 fails.

## 🔎 Check Port Labeling

```bash
semanage port -l | grep 8080
```

If not labeled correctly:

## ✅ Fix

```bash
sudo semanage port -a -t http_port_t -p tcp 8080
```

If already exists under another type:

```bash
sudo semanage port -d -p tcp 8080
sudo semanage port -a -t http_port_t -p tcp 8080
```

---

# 🔁 4️⃣ Boolean-Related Restrictions

## ❌ Problem

Apache cannot connect to remote database.

## 🔎 Check Boolean

```bash
getsebool httpd_can_network_connect
```

If off:

## ✅ Enable Permanently

```bash
sudo setsebool -P httpd_can_network_connect on
```

---

# 🧪 5️⃣ Temporary Testing Mode

If unsure whether SELinux is causing issue:

## ⚠ Switch to Permissive Mode (Temporary)

```bash
sudo setenforce 0
```

If issue disappears → confirmed SELinux restriction.

⚠ Re-enable immediately:

```bash
sudo setenforce 1
```

Never leave production systems in permissive mode.

---

# 🧩 6️⃣ When to Use `audit2allow`

## ❌ Avoid First

Do NOT immediately generate custom policies.

First try:

1. Fix labeling
2. Adjust boolean
3. Verify port context

## 🔧 Only If Necessary

```bash
grep denied /var/log/audit/audit.log | audit2allow -M mymodule
sudo semodule -i mymodule.pp
```

Custom modules should be last resort.

---

# 🧠 7️⃣ Understanding Context Mismatch

Example context:

```
system_u:system_r:httpd_t:s0
unconfined_u:object_r:user_home_t:s0
```

Mismatch occurs because:

* Process type ≠ allowed file type
* Policy denies cross-type access

Correct by aligning file type to service expectations.

---

# 📊 8️⃣ Monitoring SELinux Health

Use custom monitoring script:

```bash
sudo /usr/local/bin/selinux-monitor.sh
```

It reports:

* Current status
* Recent denials
* Enabled booleans
* Custom file contexts

Automated via cron:

```
0 */6 * * * root /usr/local/bin/selinux-monitor.sh >> /var/log/selinux-monitor.log 2>&1
```

---

# 🛡 Best Practices Learned

* Keep SELinux in **Enforcing**
* Fix context before modifying policy
* Avoid disabling SELinux
* Use persistent tools (`semanage`, `restorecon`)
* Use booleans selectively
* Treat `audit2allow` as advanced/last option
* Monitor denials proactively

---

# 🏁 Final Summary

This troubleshooting workflow ensures:

1. Security is maintained
2. Applications function correctly
3. Root cause is properly identified
4. Policy remains clean and manageable

These practices align with enterprise Linux security standards and RHCSA-level expectations.
