# 🧪 Lab 13: Process Monitoring

# ⚙️ Lab Overview

This lab demonstrates real-world process monitoring and performance management tasks.

You performed:

1️⃣ Real-time process monitoring  
2️⃣ Static process analysis  
3️⃣ CPU & memory sorting  
4️⃣ Load average interpretation  
5️⃣ Killing resource-heavy processes  
6️⃣ Adjusting process priority (niceness)  

---

# 🎯 Objectives

By the end of this lab, I was able to:

- Monitor system processes using `top`, `ps`, and `htop`
- Identify CPU and memory intensive processes
- Analyze system load average
- Optimize performance by killing runaway processes
- Adjust process priority using `renice`

---

# 🖥️ Lab Environment

| Component | Value |
|------------|--------|
| OS | Ubuntu 24.04.1 LTS |
| Hostname | ip-172-31-10-278 |
| User | toor |
| CPU | 2 vCPUs |
| RAM | ~4GB |
| Tools Used | top, ps, htop, kill, renice |

---

## 📁 Repository Structure

lab13-process-monitoring/
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
└── troubleshooting.md

---

# 🧩 Tasks Performed

## 1️⃣ Install Monitoring Tools

Installed `htop` using apt package manager.

---

## 2️⃣ Monitor Running Processes

### Using `top`
- Observed CPU usage
- Identified python3 consuming ~45% CPU
- Reviewed memory usage
- Interpreted load averages

### Using `ps`
- Listed processes with `ps aux`
- Sorted by CPU usage
- Sorted by memory usage

### Using `htop`
- Sorted by CPU (F6)
- Tree view (F5)
- Interactive process control

---

## 3️⃣ Identify Resource Hogs

Used:

ps aux --sort=-%cpu
ps aux --sort=-%mem

Identified high CPU python3 process.

---

## 4️⃣ Optimize Performance

### Kill Process

kill <PID>

Verified termination using `ps` and `grep`.

---

### Renice Process

Created CPU load:

yes > /dev/null &

Adjusted priority:

sudo renice -n 10 -p <PID>

Confirmed lower scheduling priority.

---

# 📊 Understanding Key Metrics

## 🔹 CPU Usage
Indicates percentage of CPU used per process.

## 🔹 Memory Usage
Measured using RSS and %MEM.

## 🔹 Load Average
Represents average runnable processes over:
- 1 minute
- 5 minutes
- 15 minutes

For 2 vCPUs:
Load < 2 → Healthy  
Load > 2 → CPU bottleneck  

---

# 🏁 Conclusion

In this lab, you:

- Monitored processes in real time
- Identified performance bottlenecks
- Interpreted load averages correctly
- Terminated problematic processes
- Adjusted process priority to improve fairness

---

# 🌍 Real-World Relevance

Process monitoring is essential for:

- Performance tuning
- Production incident response
- Detecting runaway applications
- Identifying cryptomining malware
- Managing container workloads
- Troubleshooting high load issues

These skills are critical for:

- Linux System Administrators
- DevOps Engineers
- Cloud Engineers
- SRE roles
- RHCSA certification

---

# 🔐 Security Insight

Unusual CPU spikes may indicate:

- Cryptojacking
- Malware execution
- Fork bombs
- Misconfigured applications
- Infinite loops in scripts

Regular process monitoring prevents system instability and compromise.

---

# 🎓 RHCSA Exam Relevance

Key commands frequently tested:

- top
- ps aux
- kill
- renice
- uptime
- nice
- htop (conceptual)

Understanding process states and priority management is fundamental.

---
