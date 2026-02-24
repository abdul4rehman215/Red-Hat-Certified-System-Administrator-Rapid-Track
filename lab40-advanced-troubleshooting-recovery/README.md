
# 🛠 Lab 40: Advanced Troubleshooting and System Recovery

---

## 🎯 Objective

This lab focuses on advanced Linux troubleshooting and full system recovery techniques using systemd, logs, rescue mode, and preventive automation.

By completing this lab, I practiced:

- Log analysis using journalctl
- Diagnosing failing services
- Using rescue mode safely
- Repairing broken systemd services
- Restoring multi-user operation
- Implementing automated configuration backups

---

## 📌 Prerequisites

- RHEL 8 / CentOS 8 system
- Root or sudo privileges
- Basic knowledge of:
  - systemctl
  - journalctl
  - Linux file system structure
  - Service management

---

## 🖥 Lab Environment

- OS: CentOS/RHEL 8
- Access: Full root access
- Scenario: Simulated systemd service failure
- Recovery Method: Rescue mode + service reconfiguration

---

## 🚀 Task Overview

### 🔹 Task 1: Advanced Log Analysis
- Review system logs using journalctl
- Filter error-level logs
- Monitor real-time service failures
- Analyze traditional log files in /var/log
- Diagnose high CPU usage caused by restart loops

### 🔹 Task 2: System Recovery via Rescue Mode
- Simulate a faulty systemd service
- Enter rescue mode safely
- Identify failed services
- Analyze service dependencies
- Investigate root cause using logs

### 🔹 Task 3: Restore System Stability
- Fix incorrect systemd service configuration
- Reload systemd daemon
- Restore multi-user target
- Verify essential services
- Implement automated configuration backup using:
  - Custom backup script
  - systemd service
  - systemd timer
- Document recovery process

---

## 📂 Repository Structure 

```text
lab40-troubleshooting-recovery/
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
├── troubleshooting.md
└── scripts/
    ├── problem-service.service
    ├── problem-service-fixed.service
    ├── backup-configs.sh
    ├── backup-configs.service
    └── backup-configs.timer
````

---

## 🏁 What I Learned

* Always analyze logs before changing configuration
* Restart loops are commonly caused by incorrect ExecStart/ExecStop
* Rescue mode isolates system for safe recovery
* systemctl targets control operating state
* Automated backups prevent configuration loss
* Preventive maintenance reduces downtime

---

## 🌍 Real-World Relevance

This lab simulates real production scenarios such as:

* Services failing repeatedly
* Incorrect systemd configurations
* System instability
* Emergency recovery situations
* Implementing backup automation

These skills are essential for:

* Linux System Administrators
* RHCSA / RHCE candidates
* DevOps Engineers
* Infrastructure Engineers
* Production Support Teams

---

## ✅ Result

✔ Identified restart loop via logs
✔ Entered rescue mode safely
✔ Repaired service configuration
✔ Restored system stability
✔ Implemented automated backup system
✔ Verified no remaining critical errors

---

🎓 **Lab 40 Successfully Completed — Advanced Troubleshooting & Recovery**
