# 🎯 Interview Q&A - Lab 40: Advanced Troubleshooting and System Recovery

---

## 1️⃣ What is the first step when troubleshooting a Linux system issue?

**Answer:**  
Always check logs first.  
Primary tools:
- `journalctl`
- `/var/log/messages`
- `/var/log/secure`

Logs provide root cause before making changes.

---

## 2️⃣ What does `journalctl -p err` do?

**Answer:**  
It filters journal logs by priority level **error** and above.  
Useful for quickly identifying service failures and critical problems.

---

## 3️⃣ What causes a systemd restart loop?

Common causes:
- Incorrect `ExecStart`
- Incorrect `ExecStop`
- `Restart=always` combined with failure
- Invalid binary path
- Permission issues

---

## 4️⃣ What is rescue mode in Linux?

Rescue mode is a minimal system state used for maintenance and recovery.  
It:
- Starts only essential services
- Stops most user services
- Provides safe environment for troubleshooting

Command:
```bash
sudo systemctl rescue
````

---

## 5️⃣ What is the difference between `multi-user.target` and `rescue.target`?

| Target            | Purpose                          |
| ----------------- | -------------------------------- |
| multi-user.target | Normal system operation (no GUI) |
| rescue.target     | Single-user maintenance mode     |

---

## 6️⃣ How do you check failed services?

```bash
systemctl --failed
```

This lists services that exited with errors.

---

## 7️⃣ What does `systemctl daemon-reload` do?

It reloads systemd configuration after:

* Modifying service files
* Adding new units
* Editing timers

Without this command, changes will not apply.

---

## 8️⃣ What is the purpose of `Restart=on-failure`?

It restarts the service only if it fails.
Better than `Restart=always` in many cases to avoid infinite loops.

---

## 9️⃣ How can you analyze service-specific logs?

```bash
journalctl -u <service-name>
```

This isolates logs for a single unit.

---

## 🔟 Why is preventive backup important in system recovery?

Because:

* Configuration corruption can occur anytime
* Manual recovery takes time
* Automated backups reduce downtime
* Production systems require high availability

---

## 1️⃣1️⃣ What is a systemd timer?

A systemd timer is a scheduling unit that runs services at defined intervals (similar to cron).

Example:

* `OnCalendar=daily`
* `Persistent=true`

---

## 1️⃣2️⃣ How do you verify system health after recovery?

Checklist:

* `systemctl status` for critical services
* `journalctl -p err`
* `df -h`
* Network test (ping)
* Load average (`uptime`)

---

## 1️⃣3️⃣ What is the importance of analyzing CPU usage during troubleshooting?

High CPU usage may indicate:

* Infinite loops
* Restart loops
* Memory leaks
* Resource exhaustion

Tool:

```bash
top
```

---

## 1️⃣4️⃣ Why should rescue mode be used instead of force reboot?

Because:

* It avoids abrupt shutdown
* Preserves logs
* Prevents data corruption
* Allows controlled diagnostics

---

## 1️⃣5️⃣ What is the correct troubleshooting workflow?

1. Identify symptoms
2. Check logs
3. Isolate failing service
4. Enter safe mode if necessary
5. Fix configuration
6. Reload services
7. Validate system health
8. Implement preventive measures

---

# 🧠 Summary

This lab demonstrates enterprise-level troubleshooting skills including:

* Log analysis
* Service diagnostics
* Recovery via rescue mode
* Configuration repair
* Preventive automation

These are essential skills for:

* Linux System Administrators
* RHCSA / RHCE candidates
* DevOps Engineers
* Production Support Engineers
