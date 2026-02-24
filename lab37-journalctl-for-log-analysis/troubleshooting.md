# 🛠 Troubleshooting Guide - Lab 37: Using journalctl for Log Analysis

---

## 🔴 Issue 1: Journal Logs Not Persisting After Reboot

### Problem
After rebooting the system, previous logs are missing.

### Cause
Persistent storage is not enabled. By default, logs may be stored in `/run/log/journal` (volatile memory).

### Solution

1️⃣ Create persistent journal directory:
```bash
mkdir -p /var/log/journal
````

2️⃣ Set correct ownership and permissions:

```bash
chown root:systemd-journal /var/log/journal
chmod 2755 /var/log/journal
```

3️⃣ Edit configuration:

```bash
nano /etc/systemd/journald.conf
```

Set:

```
Storage=persistent
```

4️⃣ Restart service:

```bash
systemctl restart systemd-journald
```

5️⃣ Verify:

```bash
ls -la /var/log/journal/
```

---

## 🔴 Issue 2: Journal Taking Too Much Disk Space

### Problem

Journal logs consume excessive disk space.

### Diagnosis

```bash
journalctl --disk-usage
```

### Solution

Clean by time:

```bash
journalctl --vacuum-time=7d
```

Clean by size:

```bash
journalctl --vacuum-size=200M
```

Limit permanently in configuration:

```
SystemMaxUse=500M
SystemKeepFree=1G
```

Restart service after changes:

```bash
systemctl restart systemd-journald
```

---

## 🔴 Issue 3: Cannot View Logs for a Specific Service

### Problem

`journalctl -u servicename` shows no output.

### Possible Causes

* Incorrect unit name
* Service not started
* No logs generated yet

### Solution

1️⃣ Verify service exists:

```bash
systemctl list-units --type=service | grep sshd
```

2️⃣ Use full unit name:

```bash
journalctl -u sshd.service
```

3️⃣ Check service status:

```bash
systemctl status sshd
```

---

## 🔴 Issue 4: journalctl Command Not Showing Recent Logs

### Problem

Recent activity does not appear in logs.

### Solution

Check time filtering:

```bash
journalctl --since "10 minutes ago"
```

Check priority filtering:

```bash
journalctl -p info
```

Ensure service is active:

```bash
systemctl status systemd-journald
```

---

## 🔴 Issue 5: journalctl Output Is Too Long or Hard to Read

### Problem

Large output makes analysis difficult.

### Solutions

View recent entries:

```bash
journalctl -n 20
```

Disable pager:

```bash
journalctl --no-pager
```

Reverse order:

```bash
journalctl -r
```

Filter by unit and time:

```bash
journalctl -u sshd --since "1 hour ago"
```

---

## 🔴 Issue 6: Journal Corruption Suspected

### Diagnosis

```bash
journalctl --verify
```

If corruption detected:

```bash
rm -rf /var/log/journal/*
systemctl restart systemd-journald
```

⚠️ Warning: This deletes existing logs.

---

## 🔴 Issue 7: Monitoring Script Not Logging Alerts

### Problem

Custom script does not generate alerts.

### Troubleshooting Steps

Check if critical logs exist:

```bash
journalctl -p crit --since "5 minutes ago"
```

Verify script permissions:

```bash
ls -l /usr/local/bin/log_monitor.sh
```

Make executable if needed:

```bash
chmod +x /usr/local/bin/log_monitor.sh
```

Check alert log file:

```bash
cat /var/log/critical_alerts.log
```

---

## 🔴 Issue 8: Unable to See Logs from Previous Boot

### Solution

List boots:

```bash
journalctl --list-boots
```

View previous boot:

```bash
journalctl -b -1
```

If unavailable, persistent storage is not configured.

---

## 🧪 Verification Checklist

✔ systemd-journald service running
✔ Persistent storage directory exists
✔ Disk usage within limits
✔ Log filtering works (time, priority, unit)
✔ Monitoring script executes properly
✔ Vacuum operations successful

---

## 🎯 Best Practices

* Enable persistent logging in production
* Set disk usage limits
* Regularly vacuum old logs
* Monitor critical logs automatically
* Restrict journal access using proper permissions
* Forward logs to SIEM or central logging server if required

---

## 🔐 Security Relevance

Proper journal management is critical for:

* Incident response
* Security auditing
* Forensic investigation
* Compliance requirements
* Detecting brute force attempts
* Monitoring suspicious activity

Logs are often the **first source of truth** during security investigations.

---

## ✅ Final Notes

This troubleshooting guide ensures that:

* Logging is reliable
* Disk usage is controlled
* Monitoring is proactive
* Troubleshooting is efficient
* System integrity is maintained

Mastering journalctl troubleshooting is essential for RHCSA and real-world Linux administration.
