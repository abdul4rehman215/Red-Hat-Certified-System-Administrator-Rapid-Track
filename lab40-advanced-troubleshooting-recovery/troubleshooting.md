# 🛠 Troubleshooting Guide - Lab 40: Advanced Troubleshooting & System Recovery

---

# 🔍 SECTION 1: Log-Based Troubleshooting

---

## ❌ Issue 1: Service Fails to Start

### Symptoms
- Service shows `failed`
- systemctl status shows `exit-code`
- CPU spikes due to restart loop

### Diagnosis Steps

Check service status:
```bash
systemctl status <service-name>
````

Check service logs:

```bash
journalctl -u <service-name>
```

Filter error-level logs:

```bash
journalctl -p err
```

---

## ❌ Issue 2: Restart Loop (High CPU Usage)

### Symptoms

* `Active: activating (auto-restart)`
* High CPU usage in `top`
* Repeated restart counter increase

### Common Causes

* Invalid `ExecStart`
* Invalid `ExecStop`
* `Restart=always` misconfiguration
* Missing binary
* Incorrect permissions

### Fix Strategy

1. Stop service
2. Inspect service file
3. Correct directive
4. Reload daemon
5. Restart service

---

## ❌ Issue 3: No Clear Error in Logs

### Advanced Log Filtering

Last 2 hours:

```bash
journalctl --since "2 hours ago"
```

Warnings:

```bash
journalctl -p warning
```

Kernel logs:

```bash
dmesg | tail
```

---

# 🚑 SECTION 2: Rescue Mode Troubleshooting

---

## ❌ System Instability or Multiple Service Failures

### Enter Rescue Mode

```bash
sudo systemctl rescue
```

### Verify Current Target

```bash
systemctl list-units --type=target
```

Expected:

* rescue.target active
* minimal services running

---

## ❌ Check Failed Units in Rescue Mode

```bash
systemctl --failed
```

If service shows failed:

* Inspect unit file
* Review dependencies
* Validate syntax

---

## ❌ Incorrect systemd Configuration

### Validate Unit File Syntax

```bash
systemd-analyze verify /etc/systemd/system/<service>.service
```

### Common Errors

* Missing `[Install]` section
* Wrong ExecStart path
* Improper quoting
* Shell variable misuse

---

# 🔄 SECTION 3: Service Recovery Workflow

---

## Recovery Procedure

1️⃣ Stop failing service
2️⃣ Edit service file
3️⃣ Run:

```bash
sudo systemctl daemon-reload
```

4️⃣ Start service
5️⃣ Verify:

```bash
systemctl status <service>
```

6️⃣ Check logs again

---

## If Service Still Fails

* Confirm executable exists
* Check permissions:

```bash
ls -l <binary-path>
```

* Temporarily disable restart policy
* Remove `Restart=always` during testing

---

# 💾 SECTION 4: Backup & Preventive Maintenance Issues

---

## ❌ Backup Script Not Executing

### Check Executable Permission

```bash
ls -l /usr/local/bin/backup-configs.sh
```

If not executable:

```bash
chmod +x /usr/local/bin/backup-configs.sh
```

---

## ❌ Timer Not Triggering

Check timer:

```bash
systemctl status backup-configs.timer
```

List timers:

```bash
systemctl list-timers
```

Common causes:

* Missed daemon-reload
* Incorrect OnCalendar format
* Timer not enabled

---

# 🌐 SECTION 5: Network or Connectivity Issues

---

## Verify Network Services

```bash
systemctl status NetworkManager
```

Test connectivity:

```bash
ping 8.8.8.8
```

If failing:

* Check interface
* Check DNS
* Review `/etc/resolv.conf`

---

# 💽 SECTION 6: Disk & Resource Issues

---

## High Disk Usage

Check disk:

```bash
df -h
```

Check large directories:

```bash
du -sh /var/log/*
```

Clean old journal logs:

```bash
journalctl --vacuum-time=7d
```

---

## High CPU / Load

Check:

```bash
top
uptime
```

Investigate:

* Restart loops
* Zombie processes
* Background scripts

---

# 🔐 SECTION 7: Best Practices for Production Systems

---

✔ Always check logs first
✔ Avoid `Restart=always` unless necessary
✔ Use `Restart=on-failure`
✔ Validate service files before enabling
✔ Keep backups automated
✔ Test changes before production rollout
✔ Document recovery actions

---

# 🏁 Final Recovery Validation Checklist

| Check               | Command                               |
| ------------------- | ------------------------------------- |
| Service Running     | systemctl status <service>            |
| No Errors           | journalctl -p err                     |
| Network Working     | ping google.com                       |
| Disk Healthy        | df -h                                 |
| Backup Timer Active | systemctl status backup-configs.timer |

---

# 🎓 Conclusion

This troubleshooting guide demonstrates:

* Structured log analysis
* Safe rescue mode recovery
* Correct systemd service repair
* Preventive automation implementation
* Production-level diagnostic workflow

Mastering these techniques ensures:

* Reduced downtime
* Faster root cause identification
* Stable Linux environments
* Enterprise-ready system administration

```

---

✅ Lab 20 is now fully structured and clean:

- README.md  
- commands.sh  
- scripts/  
- output.txt  
- interview_qna.md  
- troubleshooting.md  

---

If you want, next we can:

- Polish all 20 labs into final portfolio format  
- Or build a clean GitHub-ready index  
- Or improve formatting to match your screenshots exactly  

Tell me the next move.
```
## 📄 `troubleshooting.md` — Lab 20

**Advanced Troubleshooting & System Recovery Guide**

````md id="lab20troubleshooting"
# 🛠 Troubleshooting Guide  
## Lab 20 — Advanced Troubleshooting & System Recovery

---

# 🔍 SECTION 1: Log-Based Troubleshooting

---

## ❌ Issue 1: Service Fails to Start

### Symptoms
- Service shows `failed`
- systemctl status shows `exit-code`
- CPU spikes due to restart loop

### Diagnosis Steps

Check service status:
```bash
systemctl status <service-name>
````

Check service logs:

```bash
journalctl -u <service-name>
```

Filter error-level logs:

```bash
journalctl -p err
```

---

## ❌ Issue 2: Restart Loop (High CPU Usage)

### Symptoms

* `Active: activating (auto-restart)`
* High CPU usage in `top`
* Repeated restart counter increase

### Common Causes

* Invalid `ExecStart`
* Invalid `ExecStop`
* `Restart=always` misconfiguration
* Missing binary
* Incorrect permissions

### Fix Strategy

1. Stop service
2. Inspect service file
3. Correct directive
4. Reload daemon
5. Restart service

---

## ❌ Issue 3: No Clear Error in Logs

### Advanced Log Filtering

Last 2 hours:

```bash
journalctl --since "2 hours ago"
```

Warnings:

```bash
journalctl -p warning
```

Kernel logs:

```bash
dmesg | tail
```

---

# 🚑 SECTION 2: Rescue Mode Troubleshooting

---

## ❌ System Instability or Multiple Service Failures

### Enter Rescue Mode

```bash
sudo systemctl rescue
```

### Verify Current Target

```bash
systemctl list-units --type=target
```

Expected:

* rescue.target active
* minimal services running

---

## ❌ Check Failed Units in Rescue Mode

```bash
systemctl --failed
```

If service shows failed:

* Inspect unit file
* Review dependencies
* Validate syntax

---

## ❌ Incorrect systemd Configuration

### Validate Unit File Syntax

```bash
systemd-analyze verify /etc/systemd/system/<service>.service
```

### Common Errors

* Missing `[Install]` section
* Wrong ExecStart path
* Improper quoting
* Shell variable misuse

---

# 🔄 SECTION 3: Service Recovery Workflow

---

## Recovery Procedure

1️⃣ Stop failing service
2️⃣ Edit service file
3️⃣ Run:

```bash
sudo systemctl daemon-reload
```

4️⃣ Start service
5️⃣ Verify:

```bash
systemctl status <service>
```

6️⃣ Check logs again

---

## If Service Still Fails

* Confirm executable exists
* Check permissions:

```bash
ls -l <binary-path>
```

* Temporarily disable restart policy
* Remove `Restart=always` during testing

---

# 💾 SECTION 4: Backup & Preventive Maintenance Issues

---

## ❌ Backup Script Not Executing

### Check Executable Permission

```bash
ls -l /usr/local/bin/backup-configs.sh
```

If not executable:

```bash
chmod +x /usr/local/bin/backup-configs.sh
```

---

## ❌ Timer Not Triggering

Check timer:

```bash
systemctl status backup-configs.timer
```

List timers:

```bash
systemctl list-timers
```

Common causes:

* Missed daemon-reload
* Incorrect OnCalendar format
* Timer not enabled

---

# 🌐 SECTION 5: Network or Connectivity Issues

---

## Verify Network Services

```bash
systemctl status NetworkManager
```

Test connectivity:

```bash
ping 8.8.8.8
```

If failing:

* Check interface
* Check DNS
* Review `/etc/resolv.conf`

---

# 💽 SECTION 6: Disk & Resource Issues

---

## High Disk Usage

Check disk:

```bash
df -h
```

Check large directories:

```bash
du -sh /var/log/*
```

Clean old journal logs:

```bash
journalctl --vacuum-time=7d
```

---

## High CPU / Load

Check:

```bash
top
uptime
```

Investigate:

* Restart loops
* Zombie processes
* Background scripts

---

# 🔐 SECTION 7: Best Practices for Production Systems

---

✔ Always check logs first
✔ Avoid `Restart=always` unless necessary
✔ Use `Restart=on-failure`
✔ Validate service files before enabling
✔ Keep backups automated
✔ Test changes before production rollout
✔ Document recovery actions

---

# 🏁 Final Recovery Validation Checklist

| Check               | Command                               |
| ------------------- | ------------------------------------- |
| Service Running     | systemctl status <service>            |
| No Errors           | journalctl -p err                     |
| Network Working     | ping google.com                       |
| Disk Healthy        | df -h                                 |
| Backup Timer Active | systemctl status backup-configs.timer |

---

# 🎓 Conclusion

This troubleshooting guide demonstrates:

* Structured log analysis
* Safe rescue mode recovery
* Correct systemd service repair
* Preventive automation implementation
* Production-level diagnostic workflow

Mastering these techniques ensures:

* Reduced downtime
* Faster root cause identification
* Stable Linux environments
* Enterprise-ready system administration
