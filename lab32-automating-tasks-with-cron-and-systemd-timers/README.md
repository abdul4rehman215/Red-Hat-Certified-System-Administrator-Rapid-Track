# 🧪 Lab 32: Automating Tasks with Cron and systemd Timers (CentOS/RHEL 8/9)

## 🎯 Objective
This lab focuses on **automating administrative tasks** using two scheduling mechanisms in RHEL-based systems:

- ✅ **cron** (traditional scheduler using crontab syntax)
- ✅ **systemd timers** (modern scheduler integrated with systemd)

By the end of this lab, I implemented and verified:
- Multiple cron jobs with proper logging and maintenance
- System-level systemd `.service` + `.timer` units
- Weekly cleanup automation with randomized timer delay
- User-level systemd timers for personal scheduled tasks
- Debugging techniques for both cron and systemd scheduling

---

## 📌 Prerequisites
Before performing this lab, the following knowledge was required:

- Basic Linux command-line usage
- File permissions and ownership
- Text editor familiarity (nano/vim)
- Basic shell scripting
- Basic understanding of services/processes
- sudo/root access on CentOS/RHEL 8/9

---

## 🧰 Lab Environment
| Item | Value |
|------|------|
| Platform | Cloud Lab Environment |
| OS | CentOS/RHEL 8/9 |
| User | `centos` |
| Scheduler Tools | `crond`, `systemd` |
| Access | sudo/root available |

---

## 📁 Repository Structure

```text
lab32-automating-tasks-with-cron-and-systemd-timers/
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
├── troubleshooting.md
└── scripts/
    ├── system_info.sh
    ├── daily_backup.sh
    ├── log_monitor.sh
    ├── env_test.sh
    ├── debug_cron.sh
    ├── monitor_automation.sh
    ├── personal-backup.sh
    ├── system-status.sh                (installed to /usr/local/bin/system-status.sh)
    └── temp-cleanup.sh                 (installed to /usr/local/bin/temp-cleanup.sh)

systemd-units/                          (tracked in repo for portfolio clarity)
├── system-status.service               (installed to /etc/systemd/system/system-status.service)
├── system-status.timer                 (installed to /etc/systemd/system/system-status.timer)
├── temp-cleanup.service                (installed to /etc/systemd/system/temp-cleanup.service)
└── temp-cleanup.timer                  (installed to /etc/systemd/system/temp-cleanup.timer)

user-systemd-units/                     (installed under ~/.config/systemd/user/)
├── personal-backup.service
└── personal-backup.timer
````

✅ Notes:

* In the lab VM, system-level timer/service files are placed in:

  * `/etc/systemd/system/`
* Scripts used by system services are placed in:

  * `/usr/local/bin/`
* User-level systemd units are placed in:

  * `~/.config/systemd/user/`

---

# ✅ Tasks Overview

### ✅ Task 1: Cron Job Automation

- Verified crond status and reviewed cron configuration locations
- Created multiple cron jobs for monitoring, backups, cleanup, and logging
- Tested cron execution using system logs and generated output files

### ✅ Task 2: systemd Timer Automation

- Reviewed existing system timers and timer storage locations
- Created a system-level timer + service to generate periodic status reports
- Built a weekly cleanup timer with persistence and randomized delay
- Implemented a user-level timer for personal backups

### ✅ Task 3: Testing, Debugging, Monitoring

- Verified cron execution via journald and cron logs
- Debugged cron environment behavior (PATH differences)
- Validated systemd service execution and logs
- Created a monitoring script to summarize automation health

---

## ✅ Result

By completing this lab successfully, I achieved:

* ✅ Cron service validated and actively running
* ✅ Multiple cron jobs created, tested, and verified through logs
* ✅ System-level systemd timers deployed and confirmed active
* ✅ Weekly maintenance timer configured with randomized execution window
* ✅ User-level systemd timer configured and scheduled correctly
* ✅ Debugging techniques applied for both cron and systemd tasks
* ✅ Monitoring report implemented for continued operations validation

---

## 🌍 Why This Matters

Task automation is a foundational system administration skill because it:

* Reduces manual repetitive work
* Improves consistency and reliability
* Helps enforce operational hygiene (cleanup, backups, monitoring)
* Enables scheduled reporting for troubleshooting and auditing

---

## 🧠 Real-World Applications

These automation techniques directly apply to:

* Scheduled backups and retention policies
* System health monitoring and reporting
* Temp/log cleanup procedures
* Compliance checks and periodic verification scripts
* Routine administrative workflows in enterprise Linux environments

---

## 🏁 Conclusion

This lab demonstrated both **traditional cron-based scheduling** and **modern systemd timer automation**, including real-world task patterns like logging, backups, cleanup policies, debugging scheduled environments, and continuous automation monitoring.

