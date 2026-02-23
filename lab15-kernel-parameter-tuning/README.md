
# 🧪 Lab 15: Kernel Parameter Tuning (sysctl)

## 📌 Overview
This lab focuses on **Linux kernel runtime tuning** using `sysctl`, covering both **temporary** and **persistent** parameter changes.  
The work simulates common real-world admin tasks like improving **memory behavior**, tuning **network performance**, and validating impact under load.

---

## 🎯 Objectives
By the end of this lab, I was able to:

- View and query kernel parameters using `sysctl`
- Apply **temporary** kernel parameter changes (`sysctl -w`)
- Apply **persistent** kernel tuning (`/etc/sysctl.conf` + `sysctl -p`)
- Tune basic **networking** and **memory management** parameters
- Validate tuning impact using monitoring tools and stress testing

---

## ✅ Prerequisites
- Linux system (Ubuntu used in this lab)
- `sudo` privileges
- Basic CLI knowledge

---

## 🖥️ Lab Environment
- **OS:** Ubuntu 24.04.1 LTS  
- **User:** `toor`  
- **Instance:** `ip-172-31-10-301`  
- **RAM:** 4 GB  
- **Shell Prompt:** `toor@ip-172-31-10-301:~$`

---

## 🗂️ Repository Structure
```text
lab15-kernel-parameter-tuning/
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
└── troubleshooting.md
````

---

## 🧩 Tasks Performed (High-Level)

### ✅ Task 1: View and Modify Kernel Parameters

* Listed parameters using `sysctl -a`
* Queried specific parameter `vm.swappiness`
* Updated `vm.swappiness` temporarily using `sysctl -w`
* Applied permanent change by editing `/etc/sysctl.conf` and loading it via `sysctl -p`

### ✅ Task 2: Tune Networking and Memory Parameters

* Increased file descriptor limit via `fs.file-max`
* Enabled TCP Fast Open via `net.ipv4.tcp_fastopen`
* Enabled memory overcommit via `vm.overcommit_memory`
* Disabled hugepages count via `vm.nr_hugepages`

### ✅ Task 3: Test Effects of Kernel Changes

* Monitored memory impact using `free -h`
* Checked network socket summary using `ss -s`
* Installed `stress-ng` and ran a memory stress test
* Observed reduced swapping behavior (lower swappiness)
* Simulated throughput validation using `iperf3`

---

## ✅ Results Summary

* Confirmed current kernel defaults (e.g., `vm.swappiness=60`)
* Tuned memory swapping aggressiveness (`vm.swappiness=10`)
* Applied persistent kernel tuning via sysctl config
* Verified parameter changes successfully
* Validated system behavior under memory pressure with stress testing

---

## 🔐 Why This Matters (Security + Ops Relevance)

Kernel parameters affect system security and stability:

* Lower swapping reduces performance degradation under attack-load scenarios
* File descriptor tuning helps resist resource exhaustion under heavy connections
* TCP optimizations support stable remote administration and service availability
* Overcommit tuning impacts memory allocation and failure behavior of critical services

---

## 🌍 Real-World Applications

* Production web server tuning (`fs.file-max`, TCP tuning)
* Performance optimization for DB + caching workloads
* Hardening and stability improvements in cloud environments
* Baseline OS tuning before running Kubernetes / containers

---

## ✅ Conclusion

In this lab, I practiced **safe kernel tuning** using `sysctl`, applied both **runtime and persistent changes**, and validated the effect using monitoring and stress tools. This is a foundational skill for enterprise Linux administration and performance troubleshooting.
