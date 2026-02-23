# 🛠 Troubleshooting Guide – Lab 14: Adjusting Process Priorities

---

# 1️⃣ Unable to Set Negative Nice Value

## ❌ Problem
```

renice: failed to set priority: Permission denied

````

## 🔎 Cause
Only **root** can assign negative nice values (higher priority).

## ✅ Solution
Use sudo:
```bash
sudo renice -n -10 -p <PID>
````

Or start process as root:

```bash
sudo nice -n -20 command
```

---

# 2️⃣ Priority Change Not Reflecting

## ❌ Problem

Nice value appears unchanged after using `renice`.

## 🔎 Possible Causes

* Incorrect PID used
* Process terminated before change
* Insufficient privileges

## ✅ Verification Steps

```bash
ps -o pid,ni,cmd -p <PID>
```

Ensure process is still running:

```bash
ps aux | grep <process_name>
```

---

# 3️⃣ System Becomes Unresponsive After High Priority Assignment

## ❌ Problem

System slows down or becomes unresponsive after assigning -20 priority.

## 🔎 Cause

High-priority CPU-intensive process starving other processes.

## ✅ Immediate Fix

Kill process:

```bash
sudo kill -9 <PID>
```

Or lower its priority:

```bash
sudo renice -n 10 -p <PID>
```

---

# 4️⃣ Load Average Remains High

## 🔎 Check CPU Core Count

```bash
nproc
```

## 🔎 Check Load

```bash
uptime
```

If load average > CPU cores consistently → CPU saturation.

## ✅ Identify Top Consumers

```bash
ps aux --sort=-%cpu | head
```

---

# 5️⃣ Nice Value vs Actual CPU Usage Mismatch

## 🔎 Explanation

Nice values influence scheduling but do NOT guarantee exact CPU percentage.

Other factors:

* I/O wait
* Scheduler fairness
* Cgroups (in containerized environments)
* CPU affinity
* Real-time scheduling policies

---

# 6️⃣ Verify Scheduling Policy

Check scheduling class:

```bash
chrt -p <PID>
```

Common classes:

* SCHED_OTHER (default)
* SCHED_FIFO
* SCHED_RR

Real-time classes override nice values.

---

# 7️⃣ Check for Cgroup Limitations (Containers / OpenShift)

Inside container:

```bash
cat /sys/fs/cgroup/cpu.max
```

Cgroup limits may override nice behavior.

In Kubernetes/OpenShift:

* CPU requests
* CPU limits
* QoS class

Priority tuning inside container may have limited impact.

---

# 8️⃣ Process Not Responding to Kill

## 🔎 Check Process State

```bash
ps -o pid,state,cmd -p <PID>
```

State meanings:

* R → Running
* S → Sleeping
* D → Uninterruptible (I/O wait)
* Z → Zombie

If in D state → waiting on I/O → cannot be killed immediately.

---

# 9️⃣ Investigate Scheduler Behavior

Use:

```bash
htop
```

Enable:

* PRI column
* NI column
* CPU% sorting

Advanced:

```bash
sudo perf top
```

For deep performance analysis.

---

# 🔟 Production Best Practices

✔ Do NOT assign -20 priority to long-running CPU-heavy jobs
✔ Use priority tuning sparingly
✔ Always monitor after changes
✔ Prefer tuning background jobs lower instead of elevating others
✔ Combine with system monitoring tools (htop, glances, sar)

---

# 🔎 Diagnostic Checklist

| Check              | Command                    |
| ------------------ | -------------------------- |
| Current nice value | ps -o pid,ni,cmd           |
| CPU load           | uptime                     |
| Top CPU consumers  | ps aux --sort=-%cpu        |
| Scheduling policy  | chrt -p PID                |
| Cgroup limits      | cat /sys/fs/cgroup/cpu.max |
| Kill process       | kill -9 PID                |

---

# 🏁 Final Note

Process priority management is powerful but dangerous if misused.

Improper configuration may cause:

* CPU starvation
* Service degradation
* Production outages

Always test in staging before applying in production environments.
