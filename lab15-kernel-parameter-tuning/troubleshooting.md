# 🛠 Troubleshooting Guide – Lab 15: Kernel Parameter Tuning

---

# 1️⃣ sysctl Change Not Taking Effect

## ❌ Problem
After editing `/etc/sysctl.conf`, the parameter value does not change.

## 🔎 Possible Causes
- File not saved correctly
- Syntax error in config file
- Parameter overridden in `/etc/sysctl.d/`

## ✅ Solution

Reload configuration:

```bash
sudo sysctl -p
````

Check for syntax errors:

```bash
sudo sysctl --system
```

Check active value:

```bash
sysctl <parameter_name>
```

---

# 2️⃣ Parameter Reverts After Reboot

## ❌ Problem

Kernel parameter resets after system restart.

## 🔎 Cause

Change was applied temporarily using:

```bash
sudo sysctl -w parameter=value
```

## ✅ Solution

Add parameter to:

```bash
/etc/sysctl.conf
```

Or preferably:

```bash
/etc/sysctl.d/99-custom.conf
```

Then reload:

```bash
sudo sysctl --system
```

---

# 3️⃣ Memory Pressure / OOM Errors After Overcommit

## ❌ Problem

System crashes or applications terminate unexpectedly after setting:

```bash
vm.overcommit_memory=1
```

## 🔎 Cause

Overcommit allows memory allocation beyond physical limits, possibly triggering OOM Killer.

## ✅ Diagnosis

Check OOM events:

```bash
dmesg | grep -i oom
```

Check memory usage:

```bash
free -h
```

## ✅ Fix

Set conservative policy:

```bash
sudo sysctl -w vm.overcommit_memory=0
```

---

# 4️⃣ High Swapping Despite Low Swappiness

## ❌ Problem

System still swaps even with:

```bash
vm.swappiness=10
```

## 🔎 Possible Causes

* Insufficient RAM
* Memory fragmentation
* Hugepage allocation
* Background memory pressure

## ✅ Check Swap Usage

```bash
free -h
```

Check swap activity:

```bash
vmstat 1
```

---

# 5️⃣ File Descriptor Errors

## ❌ Problem

Application logs show:

```
Too many open files
```

## 🔎 Check System Limit

```bash
cat /proc/sys/fs/file-max
```

Check per-user limit:

```bash
ulimit -n
```

## ✅ Fix

Increase system-wide limit:

```bash
sudo sysctl -w fs.file-max=200000
```

Increase per-user limit:

Edit `/etc/security/limits.conf`:

```
* soft nofile 100000
* hard nofile 100000
```

---

# 6️⃣ TCP Fast Open Not Working

## ❌ Problem

Performance improvement not observed.

## 🔎 Verify Setting

```bash
sysctl net.ipv4.tcp_fastopen
```

## 🔎 Check Kernel Support

```bash
grep TCP_FASTOPEN /boot/config-$(uname -r)
```

If not enabled in kernel config, feature will not work.

---

# 7️⃣ HugePages Misconfiguration

## ❌ Problem

Application fails to start after hugepage changes.

## 🔎 Check HugePage Allocation

```bash
grep Huge /proc/meminfo
```

## ✅ Reset HugePages

```bash
sudo sysctl -w vm.nr_hugepages=0
```

---

# 8️⃣ sysctl Parameter Not Found

## ❌ Error

```
sysctl: cannot stat /proc/sys/<parameter>: No such file or directory
```

## 🔎 Cause

* Parameter removed in newer kernel
* Module not loaded
* Incorrect spelling

## ✅ Verify Available Parameters

```bash
sysctl -a | grep <keyword>
```

---

# 9️⃣ Validate Performance Impact

## 📊 Check CPU & Memory During Stress

```bash
top
```

```bash
htop
```

```bash
vmstat 1
```

## 📊 Check Network Stats

```bash
ss -s
```

```bash
netstat -s
```

---

# 🔟 Best Practices Before Kernel Tuning

✔ Always test in staging
✔ Document baseline values
✔ Change one parameter at a time
✔ Monitor system after changes
✔ Keep rollback plan ready
✔ Avoid random internet tuning values

---

# 🔎 Diagnostic Checklist

| Check                 | Command                   |
| --------------------- | ------------------------- |
| Current parameter     | sysctl <param>            |
| Reload config         | sysctl -p                 |
| System memory         | free -h                   |
| Swap activity         | vmstat                    |
| OOM events            | dmesg | grep oom          |
| File descriptor limit | cat /proc/sys/fs/file-max |
| Hugepage status       | grep Huge /proc/meminfo   |

---

# 🏁 Final Note

Kernel tuning directly affects system stability.

Improper tuning may cause:

* Performance degradation
* Memory exhaustion
* Application failures
* Kernel instability

Always:
Test → Monitor → Validate → Document → Deploy

Enterprise-grade Linux administration requires disciplined kernel management.
