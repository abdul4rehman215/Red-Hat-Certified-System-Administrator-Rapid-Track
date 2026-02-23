# 🛠️ Troubleshooting Guide – Lab 13: Process Monitoring

---

## 🔎 Overview

This guide covers common real-world issues related to:

- High CPU usage
- High memory consumption
- System slowdowns
- Zombie processes
- Load average spikes
- Processes that refuse to terminate

---

# 1️⃣ Problem: High CPU Usage

## 📌 Symptoms

- System feels slow
- `top` shows high %CPU
- Load average increasing

Example:
```

python3 using 95% CPU

````

---

## 🔍 Diagnose

```bash
top
````

Or:

```bash id="nbc9t2"
ps aux --sort=-%cpu | head
```

---

## ✅ Solutions

### Option 1: Renice Process

```bash id="w3gq7k"
sudo renice -n 10 -p <PID>
```

### Option 2: Graceful Termination

```bash id="adq9x7"
kill <PID>
```

### Option 3: Force Kill

```bash id="y7md02"
kill -9 <PID>
```

⚠ Use `-9` only if necessary.

---

# 2️⃣ Problem: High Load Average

## 📌 Symptoms

```bash
uptime
```

Example:

```
load average: 4.20, 3.85, 2.90
```

On 2-core system:
Load > 2 → CPU bottleneck

---

## 🔍 Check CPU Core Count

```bash id="u0k4ls"
nproc
```

---

## 🔎 Identify Cause

* CPU-bound process?
* I/O wait?
* Too many threads?

Check in `top`:

* %us → User CPU
* %sy → System CPU
* %wa → I/O wait

---

# 3️⃣ Problem: High Memory Usage

## 📌 Symptoms

* System swapping
* Applications slow
* OOM killer triggered

---

## 🔍 Diagnose

```bash id="ktc18v"
free -h
```

```bash id="i4ml7n"
ps aux --sort=-%mem | head
```

---

## ✅ Solutions

* Restart leaking application
* Add swap space
* Increase RAM (cloud instance resize)

---

# 4️⃣ Problem: Zombie Processes

## 📌 Symptoms

In `top`:

```
1 zombie
```

Or:

```bash id="s2pw1d"
ps aux | grep Z
```

---

## 🔍 Explanation

Zombie processes:

* Completed execution
* Parent process did not collect exit status

---

## ✅ Fix

Identify parent PID (PPID):

```bash id="r6dy1h"
ps -el | grep Z
```

Restart parent process if needed.

---

# 5️⃣ Problem: Process Won’t Terminate

## 📌 Symptoms

```bash
kill <PID>
```

Process still running.

---

## 🔍 Check Process State

```bash id="e7nz6t"
ps -o pid,stat,cmd -p <PID>
```

If state is:

* `D` → Uninterruptible sleep (usually I/O wait)

---

## ✅ Solution

* Investigate disk or network issue
* Reboot system if stuck in D state

---

# 6️⃣ Problem: htop Not Installed

## 📌 Fix

```bash id="z1bf82"
sudo apt install htop -y
```

---

# 7️⃣ Problem: I/O Bottleneck

In `top`, if `%wa` is high:

* Disk overloaded
* Slow storage
* Database heavy workload

Check:

```bash id="tpkh19"
iostat
```

(Install via `sudo apt install sysstat` if needed)

---

# 8️⃣ Best Practice: Process Monitoring Checklist

✔ Check load average
✔ Compare load to CPU cores
✔ Sort by CPU usage
✔ Sort by memory usage
✔ Check for zombies
✔ Inspect I/O wait
✔ Adjust priority if required
✔ Kill runaway processes carefully

---

# 🔐 Security Monitoring Insight

Unusual process behavior may indicate:

* Cryptomining malware
* Fork bomb attack
* Memory leak exploit
* Compromised container
* Brute force attack

Always investigate unknown processes:

```bash id="n0sl72"
ps aux | grep suspicious_process
```

---

# 🧠 Enterprise Troubleshooting Flow

1. Check load average
2. Identify high CPU processes
3. Identify high memory consumers
4. Check I/O wait
5. Investigate unknown processes
6. Renice or terminate safely
7. Monitor system after action

---

# 📌 Important Commands Summary

| Command | Purpose               |
| ------- | --------------------- |
| top     | Real-time monitoring  |
| htop    | Enhanced monitoring   |
| ps aux  | Snapshot process list |
| uptime  | Check load average    |
| kill    | Terminate process     |
| renice  | Change priority       |
| free -h | Check memory          |
| nproc   | CPU core count        |

---

# 🏁 Final Takeaway

Process monitoring is critical for:

* Production stability
* Performance tuning
* Incident response
* Security detection
* Capacity planning

Mastering these tools prepares you for:

* RHCSA
* DevOps roles
* Cloud administration
* Enterprise Linux environments
