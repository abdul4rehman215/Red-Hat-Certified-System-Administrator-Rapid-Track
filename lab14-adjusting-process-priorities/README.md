# 🧪 Lab 14: Adjusting Process Priorities

# ⚙️ Lab Overview

This lab explores how Linux scheduling works using **nice values**.

You performed:

1️⃣ Installed monitoring tools  
2️⃣ Launched processes with varying nice values  
3️⃣ Verified priority using `ps`  
4️⃣ Modified running process priorities using `renice`  
5️⃣ Observed scheduler behavior via `htop`  
6️⃣ Created multiple CPU-bound workloads  
7️⃣ Analyzed CPU allocation differences  
8️⃣ Cleaned up test processes  

---

# 🎯 Objectives

By the end of this lab, I was able to:

- Understand Linux process scheduling and priority concepts
- Launch processes with specific priorities using `nice`
- Modify running process priorities using `renice`
- Observe the impact of priority adjustments using monitoring tools
- Optimize system responsiveness in multi-user environments

---

# 🖥️ Lab Environment

| Component | Value |
|------------|--------|
| OS | RHEL 9.3 |
| Hostname | rhel9-priority-lab |
| User | student |
| CPU | 2 vCPUs |
| Tools Used | nice, renice, ps, htop, glances |

---

## 📁 Repository Structure

lab14-adjusting-process-priorities/
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
└── troubleshooting.md

---


# 🧠 Linux Scheduling Concepts

## 🔹 Nice Value Range

- **-20** → Highest priority
- **0** → Default priority
- **19** → Lowest priority

## 🔹 Important Rules

- Regular users → Can only increase nice value (lower priority)
- Root → Can set negative nice values (higher priority)
- Lower NI value → More CPU time allocated

---

# 🧩 Tasks Performed

## 1️⃣ Install Monitoring Tools

Installed:

- `htop`
- `glances`

Used for observing CPU allocation behavior.

---

## 2️⃣ Launch Processes with Specific Priorities

### Low Priority Process

```bash
nice -n 19 sha1sum /dev/zero &
````

### High Priority Process (Root Required)

```bash
sudo nice -n -20 sha1sum /dev/zero &
```

Verified using:

```bash
ps -l -p $(pgrep sha1sum)
```

Confirmed:

* NI 19 → Low priority
* NI -20 → High priority

---

## 3️⃣ Modify Running Process Priority

### Increase Priority

```bash
sudo renice -n -10 -p <PID>
```

### Decrease User Process Priority

```bash
renice -n 10 -u $(whoami)
```

---

## 4️⃣ Observe Scheduler Behavior

Using `htop`:

* Viewed NI column
* Sorted by PRI
* Observed CPU distribution
* Confirmed lower NI processes received more CPU share

---

## 5️⃣ Simulate Multiple CPU Loads

Launched multiple CPU-bound tasks:

```bash
for i in {1..4}; do nice -n $((i*5)) sha1sum /dev/zero & done
```

Observed:

| NI | CPU Share  |
| -- | ---------- |
| 5  | Higher CPU |
| 10 | Moderate   |
| 15 | Lower      |
| 20 | Lowest     |

Confirmed Linux scheduler fairness behavior.

---

# 📊 Understanding Scheduler Fields

From `ps -l`:

| Column | Meaning         |
| ------ | --------------- |
| PRI    | Kernel priority |
| NI     | Nice value      |
| C      | CPU utilization |
| S      | Process state   |

Lower PRI = Higher execution priority.

---

# 🏁 Conclusion

In this lab, you:

* Controlled process scheduling using `nice`
* Modified running process priorities using `renice`
* Observed CPU allocation differences
* Understood Linux scheduler fairness
* Prevented resource starvation scenarios

---

# 🌍 Real-World Relevance

Priority tuning is critical in:

* Production servers
* Database environments
* High-load web servers
* Multi-user systems
* Containerized infrastructure
* CI/CD runners

Misconfigured priorities can cause:

* System lag
* Service starvation
* Critical process delays
* CPU monopolization

---

# 🔐 Security & Stability Insight

Improper priority configuration may:

* Starve system processes
* Cause denial-of-service conditions
* Disrupt critical daemons

Always adjust priority carefully in enterprise systems.

---

# 🎓 RHCSA & Enterprise Relevance

Common exam skills:

* nice
* renice
* ps -l
* htop analysis
* Priority verification

Understanding process scheduling is a core Linux administration competency.
