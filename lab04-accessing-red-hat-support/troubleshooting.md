# 🛠️ Troubleshooting Guide – Lab 04: Accessing Red Hat Support

---

## 🔎 Overview

This document covers common issues encountered during:

- Installing diagnostic tools
- Collecting logs
- Creating compressed archives
- Submitting support cases
- Using Podman
- Accessing Red Hat portal
- Escalating cases

Each issue includes symptoms, root cause analysis, and resolution steps.

---

# 1️⃣ Problem: `dnf install` Fails

## 📌 Symptoms

```bash
Error: Failed to download metadata for repo
````

or

```bash
No match for argument: inxi
```

## 🧠 Possible Causes

* No internet connectivity
* DNS resolution failure
* EPEL repository not enabled
* Repository misconfiguration

## ✅ Resolution

Check internet connectivity:

```bash id="4jpl92"
ping google.com
```

Check DNS:

```bash id="9zwl6a"
nslookup mirror.centos.org
```

Enable EPEL repository:

```bash id="v2l81q"
sudo dnf install epel-release -y
```

Refresh metadata:

```bash id="g1ys9m"
sudo dnf clean all
sudo dnf makecache
```

Retry installation.

---

# 2️⃣ Problem: `journalctl` Returns No Logs

## 📌 Symptoms

```bash
No journal files were found.
```

## 🧠 Possible Causes

* Journald not running
* Log retention misconfigured
* Wrong time filter used

## ✅ Resolution

Check service:

```bash id="ajx3pq"
sudo systemctl status systemd-journald
```

Verify logs without filter:

```bash id="k7d18r"
journalctl -xe
```

Adjust time filter:

```bash id="m4n91t"
journalctl --since "2 hours ago"
```

---

# 3️⃣ Problem: `dmesg` Permission Denied

## 📌 Symptoms

```bash
dmesg: read kernel buffer failed: Operation not permitted
```

## 🧠 Possible Causes

* Kernel security restrictions
* User lacks privileges

## ✅ Resolution

Run with sudo:

```bash id="v3f91b"
sudo dmesg > dmesg_output.log
```

Check kernel setting:

```bash id="o8qp42"
sysctl kernel.dmesg_restrict
```

Disable temporarily (if needed):

```bash id="i2rl19"
sudo sysctl -w kernel.dmesg_restrict=0
```

---

# 4️⃣ Problem: Tar Archive Not Created

## 📌 Symptoms

```bash
tar: Cannot stat: No such file or directory
```

## 🧠 Possible Causes

* Incorrect working directory
* No files present
* Typo in command

## ✅ Resolution

Verify current directory:

```bash id="k4pq18"
pwd
```

List files:

```bash id="w2nm74"
ls -l
```

Re-run command correctly:

```bash id="l9zs82"
tar -czvf system_diagnostics_$(date +%Y%m%d).tar.gz *
```

---

# 5️⃣ Problem: Cannot Access Red Hat Portal

## 📌 Symptoms

* Browser shows connection error
* Login fails
* Portal not loading

## 🧠 Possible Causes

* No internet access
* Account not activated
* Firewall blocking HTTPS

## ✅ Resolution

Test connectivity:

```bash id="q8vl22"
curl https://access.redhat.com
```

Verify account email confirmation.

Check firewall:

```bash id="p6rk19"
sudo firewall-cmd --list-all
```

Allow HTTPS if blocked.

---

# 6️⃣ Problem: Podman Container Fails to Start

## 📌 Symptoms

```bash
Error: cannot connect to container runtime
```

or

```bash
SELinux permission denied
```

## 🧠 Possible Causes

* Podman service not functional
* SELinux enforcing restrictions
* Network issue pulling image

## ✅ Resolution

Check Podman version:

```bash id="t9we18"
podman --version
```

Test basic run:

```bash id="y7bn23"
podman run --rm hello-world
```

Check SELinux status:

```bash id="m2zk71"
getenforce
```

If SELinux blocking:

```bash
sudo setenforce 0   # Temporary only
```

(Use only for troubleshooting — not permanent solution.)

---

# 7️⃣ Problem: Case Escalation Option Not Visible

## 📌 Symptoms

* No escalation button in portal
* Cannot change severity

## 🧠 Possible Causes

* Account lacks support entitlement
* Case severity too low
* Subscription inactive

## ✅ Resolution

Verify subscription status.

Ensure case severity aligns with impact.

Contact account administrator if needed.

---

# 8️⃣ Problem: Archive Too Large for Upload

## 📌 Symptoms

Upload rejected due to size limit.

## 🧠 Possible Causes

* Large journal logs
* Too many artifacts included

## ✅ Resolution

Compress using maximum compression:

```bash id="n4qx28"
tar -czvf system_diagnostics.tar.gz *
```

Exclude unnecessary logs:

```bash id="h3pl94"
tar --exclude='*.tmp' -czvf archive.tar.gz *
```

---

# 🔍 Enterprise Best Practices

✔ Always collect logs before reboot
✔ Attach only relevant diagnostics
✔ Clearly document business impact
✔ Review Knowledge Base before escalation
✔ Maintain structured troubleshooting notes

---

# 🧠 Key Takeaways

* Diagnostics must be methodical and structured
* Proper evidence speeds support resolution
* Escalation requires justification
* Knowledge Base research reduces downtime
* Container issues often involve SELinux or networking

---

🔴 RHCSA & Enterprise Relevance:

Understanding support workflows and diagnostic collection is critical for:

* Production Linux environments
* Container platforms
* Cloud-native infrastructure
* Enterprise DevOps pipelines
