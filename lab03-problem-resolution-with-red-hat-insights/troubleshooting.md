# 🛠️ Troubleshooting Guide – Lab 03: Problem Resolution with Red Hat Insights

---

## 🔎 Overview

This document outlines common issues encountered during:

- RHEL system registration
- Subscription attachment
- Installing insights-client
- Uploading system data
- Applying remediation
- SSH configuration fixes

Each issue includes:

- Symptoms
- Possible Causes
- Resolution Steps
- Prevention Strategy

---

# 1️⃣ Problem: Subscription Registration Fails

## 📌 Symptoms

```bash
Invalid username or password.
````

or

```bash
Network error while attempting to register.
```

## 🧠 Possible Causes

* Incorrect credentials
* No internet connectivity
* DNS resolution failure
* Firewall blocking outbound HTTPS (port 443)

## ✅ Resolution

1. Verify network connectivity:

```bash
ping google.com
```

2. Test HTTPS connectivity:

```bash
curl https://subscription.rhsm.redhat.com
```

3. Confirm DNS resolution:

```bash
nslookup subscription.rhsm.redhat.com
```

4. Retry registration:

```bash
sudo subscription-manager register --username <user>
```

## 🔐 Prevention

* Ensure stable internet connectivity
* Configure proper DNS
* Validate credentials before execution

---

# 2️⃣ Problem: No Available Subscription to Attach

## 📌 Symptoms

```bash
No available subscription pools to attach.
```

## 🧠 Possible Causes

* Account has no active subscription
* Subscription expired
* Incorrect organization access

## ✅ Resolution

Check available subscriptions:

```bash
sudo subscription-manager list --available
```

Attach specific pool manually:

```bash
sudo subscription-manager attach --pool=<POOL_ID>
```

## 🔐 Prevention

* Maintain active Red Hat subscription
* Monitor subscription expiration dates

---

# 3️⃣ Problem: `insights-client` Installation Fails

## 📌 Symptoms

```bash
Error: Unable to find a match: insights-client
```

## 🧠 Possible Causes

* System not subscribed
* AppStream repository disabled

## ✅ Resolution

Verify repository status:

```bash
sudo subscription-manager repos --list-enabled
```

Enable required repo:

```bash
sudo subscription-manager repos --enable=rhel-8-appstream-rpms
```

Retry installation:

```bash
sudo dnf install insights-client -y
```

## 🔐 Prevention

* Always verify subscription status before installing packages

---

# 4️⃣ Problem: Insights Client Registration Fails

## 📌 Symptoms

```bash
ERROR: Unable to connect to Red Hat Insights service
```

## 🧠 Possible Causes

* No internet connectivity
* Firewall blocking outbound traffic
* Proxy configuration required

## ✅ Resolution

Test connectivity:

```bash
curl https://console.redhat.com
```

If using proxy, configure:

```bash
sudo nano /etc/insights-client/insights-client.conf
```

Add proxy settings.

Re-run:

```bash
sudo insights-client --register
```

## 🔐 Prevention

* Ensure outbound HTTPS allowed
* Configure proxy properly if required

---

# 5️⃣ Problem: SSH Service Fails After Editing Configuration

## 📌 Symptoms

```bash
Failed to start sshd.service
```

## 🧠 Possible Causes

* Syntax error in `/etc/ssh/sshd_config`
* Incorrect directive formatting

## ✅ Resolution

Validate configuration:

```bash
sudo sshd -t
```

Fix syntax errors.

Restart service:

```bash
sudo systemctl restart sshd
```

Check logs:

```bash
sudo journalctl -xe
```

## 🔐 Prevention

* Always validate configuration before restarting
* Keep backup:

```bash
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
```

---

# 6️⃣ Problem: Insights Dashboard Not Updating

## 📌 Symptoms

* Issue still marked as active after fix
* Dashboard does not reflect changes

## 🧠 Possible Causes

* Insights client not re-run
* Data not uploaded
* Dashboard cache delay

## ✅ Resolution

Force data upload:

```bash
sudo insights-client
```

Verify upload success message.

Refresh dashboard manually.

## 🔐 Prevention

* Re-run insights-client after remediation
* Confirm upload success message

---

# 7️⃣ Problem: Package Update Conflicts

## 📌 Symptoms

```bash
Transaction test error
```

## 🧠 Possible Causes

* Dependency conflict
* Broken package metadata

## ✅ Resolution

Clean metadata:

```bash
sudo dnf clean all
sudo dnf makecache
```

Retry update:

```bash
sudo dnf update bash -y
```

## 🔐 Prevention

* Maintain regular system updates
* Avoid mixing repositories

---

# 🧾 Diagnostic Command Summary

```bash
subscription-manager status
subscription-manager list --available
dnf repolist
insights-client --register
insights-client
sshd -t
journalctl -xe
```

---

# 🧠 Key Takeaways

* Subscription registration is mandatory for RHEL updates.
* Insights requires outbound HTTPS connectivity.
* Always validate SSH configuration before restart.
* Re-run insights-client after remediation.
* Keep backup of configuration files before modification.

---

🟥 RHCSA Focus:
Understanding subscription management, package management, SSH hardening, and proactive monitoring tools is essential for enterprise-level Red Hat administration.
