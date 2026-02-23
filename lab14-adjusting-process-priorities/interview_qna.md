
# 🎓 Interview Q&A – Lab 14: Adjusting Process Priorities

---

## 1️⃣ What is a nice value in Linux?

Nice value determines a process’s scheduling priority.

Range:
- **-20** → Highest priority
- **0** → Default
- **19** → Lowest priority

Lower nice value = Higher CPU scheduling priority.

---

## 2️⃣ What is the difference between PRI and NI in `ps -l`?

- **NI (Nice value)** → User-defined priority adjustment.
- **PRI (Priority)** → Kernel scheduling priority calculated using NI.

Lower PRI number → Higher execution priority.

---

## 3️⃣ How do you start a process with a specific priority?

```bash
nice -n 10 command
````

Example:

```bash
nice -n 19 sha1sum /dev/zero
```

---

## 4️⃣ Can a normal user assign negative nice values?

No.

Only root can assign negative nice values (higher priority).

Regular users can only increase nice value (lower priority).

---

## 5️⃣ How do you change priority of a running process?

```bash
sudo renice -n -10 -p <PID>
```

---

## 6️⃣ What happens if two CPU-intensive processes run simultaneously?

The scheduler distributes CPU time based on:

* Nice values
* Scheduling class
* System load

Lower nice value processes receive more CPU share.

---

## 7️⃣ What is the difference between `nice` and `renice`?

| Command | Purpose                            |
| ------- | ---------------------------------- |
| nice    | Start new process with priority    |
| renice  | Change priority of running process |

---

## 8️⃣ What scheduling algorithm does Linux use?

Linux uses the **Completely Fair Scheduler (CFS)**.

It aims to fairly distribute CPU time among processes based on priority and runtime.

---

## 9️⃣ How do you view nice values in ps?

```bash
ps -o pid,ni,cmd
```

Or:

```bash
ps -l
```

---

## 🔟 What risks exist when assigning -20 priority to a process?

* Starvation of other processes
* System unresponsiveness
* Critical services may be delayed
* Possible system instability

Use high priority carefully in production.

---

## 1️⃣1️⃣ What is CPU starvation?

CPU starvation occurs when low-priority processes receive insufficient CPU time because high-priority processes dominate execution.

---

## 1️⃣2️⃣ How does priority tuning improve system responsiveness?

By lowering priority of background or CPU-heavy tasks, critical services receive sufficient CPU resources.

Example:

* Lowering backup job priority
* Raising database priority

---

## 1️⃣3️⃣ What command shows CPU core count?

```bash
nproc
```

This helps interpret load average relative to CPU capacity.

---

## 1️⃣4️⃣ What is the relationship between load average and priority?

High load average indicates many runnable processes.

Priority affects which processes receive CPU time during high load conditions.

---

## 1️⃣5️⃣ When should priority tuning be used in production?

Use priority tuning for:

* Batch jobs
* Background processing
* Backup operations
* CPU-intensive analytics
* CI/CD builds
* Container workloads

Avoid excessive negative priorities.

---

# 🏁 Interview Summary

Core concepts tested:

✔ Nice value range
✔ Root privilege for negative nice
✔ renice usage
✔ PRI vs NI
✔ Scheduler fairness
✔ CPU starvation
✔ Performance optimization strategies

Process priority management is a critical enterprise Linux skill.
