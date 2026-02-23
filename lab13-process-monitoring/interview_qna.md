# 🎓 Interview Q&A – Lab 13: Process Monitoring

---

## 1️⃣ What is the difference between `top` and `ps`?

- `top` → Real-time dynamic process monitoring.
- `ps` → Snapshot of processes at the time of execution.

`top` updates continuously, while `ps` provides static output.

---

## 2️⃣ How do you list all running processes in Linux?

```bash
ps aux
````

* `a` → All users
* `u` → User-oriented format
* `x` → Include processes without TTY

---

## 3️⃣ How do you find the highest CPU-consuming process?

```bash
ps aux --sort=-%cpu | head
```

Or use `top` and press `P`.

---

## 4️⃣ How do you find the highest memory-consuming process?

```bash
ps aux --sort=-%mem | head
```

Or in `top`, press `M`.

---

## 5️⃣ What does load average mean?

Load average represents the average number of processes waiting for CPU over:

* 1 minute
* 5 minutes
* 15 minutes

For a 2-core system:

* Load < 2 → Healthy
* Load > 2 → CPU contention

---

## 6️⃣ What is process priority (niceness)?

Niceness determines scheduling priority:

* Range: -20 (highest priority) to 19 (lowest priority)
* Lower value → Higher priority

Default value = 0

---

## 7️⃣ How do you change priority of a running process?

```bash
sudo renice -n 10 -p <PID>
```

---

## 8️⃣ What is the difference between `kill` and `kill -9`?

* `kill <PID>` → Sends SIGTERM (graceful termination)
* `kill -9 <PID>` → Sends SIGKILL (force termination)

Use `-9` only if the process does not respond.

---

## 9️⃣ What does the STAT column in `ps` mean?

Common process states:

| Code | Meaning               |
| ---- | --------------------- |
| R    | Running               |
| S    | Sleeping              |
| D    | Uninterruptible sleep |
| Z    | Zombie                |
| T    | Stopped               |

---

## 🔟 How do you identify zombie processes?

```bash
ps aux | grep Z
```

Zombie processes show STAT as `Z`.

---

## 1️⃣1️⃣ What is the difference between VIRT, RES, and SHR memory in top?

* VIRT → Virtual memory allocated
* RES → Resident memory (actual RAM usage)
* SHR → Shared memory

---

## 1️⃣2️⃣ How can you start a process with a specific niceness?

```bash
nice -n 10 command
```

---

## 1️⃣3️⃣ What does `%wa` mean in top?

`%wa` = I/O wait time
High value indicates disk bottleneck.

---

## 1️⃣4️⃣ Why is process monitoring important in production?

It helps:

* Detect runaway processes
* Identify malware (cryptomining)
* Troubleshoot performance issues
* Maintain system stability

---

## 1️⃣5️⃣ What tool provides a better interactive interface than top?

`htop`

Features:

* Color display
* Mouse support
* Tree view
* Easier process killing

---

# 🏁 Interview Summary

Key exam and enterprise concepts:

✔ Real-time monitoring (`top`, `htop`)
✔ Snapshot analysis (`ps`)
✔ Load average interpretation
✔ CPU & memory sorting
✔ Process termination
✔ Priority management

Process monitoring is a core Linux system administration skill.
