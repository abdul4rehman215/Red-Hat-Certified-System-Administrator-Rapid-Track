# 🛠 Troubleshooting Guide – Lab 32: Automating Tasks with Cron and systemd Timers

> This document outlines common issues encountered when working with cron jobs and systemd timers, along with their diagnosis and resolution steps.

---

# 🔎 1️⃣ Cron Job Not Executing

## ❌ Problem
Scheduled cron job does not run at expected time.

## 🔍 Diagnosis
Check:
```bash
sudo systemctl status crond
sudo journalctl -u crond --since "1 hour ago"
sudo tail -f /var/log/cron
```

## ⚠ Possible Causes
- Cron service not running
- Incorrect cron syntax
- Script not executable
- Wrong file path
- Environment variable issues

## ✅ Resolution
- Start and enable cron:
```bash
sudo systemctl start crond
sudo systemctl enable crond
```

- Ensure script is executable:
```bash
chmod +x script.sh
```

- Use absolute paths in crontab:
```bash
/usr/bin/df -h
``` 

---

# 🔎 2️⃣ Cron Script Runs Manually but Not via Cron

## ❌ Problem
Script works when executed manually but fails when run by cron.

## 🔍 Diagnosis
Check environment variables:
```bash
echo $PATH
``` 

Compare with:
```bash
env | sort
``` 

Cron environment example:
````

PATH=/usr/bin:/bin

````

## ⚠ Cause
Cron runs with a minimal environment.

## ✅ Resolution
- Use full binary paths inside scripts
- Define PATH explicitly in script:
```bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```

---

# 🔎 3️⃣ systemd Timer Not Triggering

## ❌ Problem
Timer shows enabled but does not execute service.

## 🔍 Diagnosis
Check timer status:
```bash
systemctl status system-status.timer
systemctl list-timers --all
```

Check service logs:
```bash
journalctl -u system-status.service
``` 

## ⚠ Possible Causes
- `daemon-reload` not executed
- Incorrect `OnCalendar` syntax
- Service file misconfigured
- Missing execute permissions on script

## ✅ Resolution
Reload systemd:
```bash
sudo systemctl daemon-reload
``` 

Ensure script is executable:
```bash
sudo chmod +x /usr/local/bin/script.sh
```

---

# 🔎 4️⃣ Timer Did Not Run After Reboot

## ❌ Problem
Scheduled job missed execution while system was powered off.

## 🔍 Cause
`Persistent=true` not defined.

## ✅ Resolution
Add to timer file:
```ini
[Timer]
Persistent=true
```

Reload and restart timer:
```bash
sudo systemctl daemon-reload
sudo systemctl restart timer-name.timer
``` 

---

# 🔎 5️⃣ User-Level Timer Not Running When Logged Out

## ❌ Problem
User timer stops when user logs out.

## 🔍 Cause
User services require active session or lingering enabled.

## ✅ Resolution
Enable lingering:
```bash
sudo loginctl enable-linger centos
```

Verify:
```bash
loginctl show-user centos
``` 

---

# 🔎 6️⃣ Permission Denied Errors in systemd Service

## ❌ Problem
Service fails with permission error writing to log file.

## 🔍 Cause
Log directory owned by root or incorrect permissions.

## ✅ Resolution
Check permissions:
```bash
ls -ld /var/log/
``` 

Adjust ownership or use root in service:
```ini
User=root
``` 

---

# 🔎 7️⃣ Cron Job Produces No Output

## ❌ Problem
Script runs but output file not created.

## 🔍 Diagnosis
Check redirection operators in script.

Example correct redirection:
```bash
echo "data" >> file.log
```

Ensure HOME variable resolves correctly:
```bash
echo $HOME
```

---

# 🔎 8️⃣ RandomizedDelaySec Not Working

## ❌ Problem
Timer runs exactly at scheduled time.

## 🔍 Cause
RandomizedDelaySec not defined in timer file.

## ✅ Resolution
Add:
```ini
RandomizedDelaySec=3600
``` 

Reload daemon:
```bash
sudo systemctl daemon-reload
``` 

---

# 🔎 9️⃣ Backup Script Fails Due to Missing Directory

## ❌ Problem
Backup fails because directory does not exist.

## 🔍 Cause
Target backup directory not created before tar execution.

## ✅ Resolution
Ensure:
```bash
mkdir -p $BACKUP_DIR
```

---

# 🔎 🔟 Service Shows Failed State

## ❌ Problem
systemd service enters failed state.

## 🔍 Diagnosis
```bash
systemctl status service-name
journalctl -xe
```

## ⚠ Possible Causes
- Syntax error in script
- Missing shebang (`#!/bin/bash`)
- Script path incorrect in `ExecStart`

## ✅ Resolution
Validate script:
```bash
bash -n script.sh
``` 

Correct service file and reload daemon.

---

# 🧠 Best Practices Summary

- Always use absolute paths
- Enable `Persistent=true` for critical jobs
- Use logging in every automation script
- Validate syntax before enabling timers
- Monitor logs regularly
- Keep backup retention policies defined
- Test scripts manually before scheduling

---

# ✅ Conclusion

During this lab, multiple cron jobs and systemd timers were implemented and tested. Troubleshooting steps ensured reliable automation by validating:

- Service status
- Timer registration
- Script execution permissions
- Logging output
- Environment differences

This systematic debugging approach ensures stable automation in production Linux environments.
