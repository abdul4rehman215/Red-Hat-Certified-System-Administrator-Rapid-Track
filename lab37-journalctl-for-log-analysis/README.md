# 🧪 Lab 37: Using journalctl for Log Analysis

## 🎯 Objectives
By the end of this lab, I was able to:
- Understand the systemd journal and why it’s useful compared to traditional log files
- View and navigate system logs using `journalctl`
- Filter logs by time, service/unit, and priority levels
- Enable persistent journal storage for long-term retention
- Apply log analysis methods for troubleshooting and monitoring

## 📌 Prerequisites
- Basic Linux command line usage
- Basic understanding of systemd services/units
- Basic concepts of logs and log levels
- General troubleshooting mindset (reading errors, tracing causes)

## 🖥 Lab Environment
This lab is performed on:
- CentOS/RHEL 8 (systemd-based)
- Root or sudo access available
- `journalctl` already installed (part of systemd)
- System services generating logs for testing

## ✅ Tasks Overview 
### Task 1: View Logs with journalctl
- Learn how to open and read the system journal
- Navigate recent logs and follow logs live

### Task 2: Filter Logs for Faster Troubleshooting
- Filter logs by:
  - Time ranges (today, last hour, custom range)
  - Priority levels (warning, error, critical)
  - Specific services/units (sshd, NetworkManager, firewalld)
- Combine filters for targeted debugging

### Task 3: Enable Persistent Log Storage
- Understand volatile vs persistent journal storage
- Configure journald to store logs on disk
- Verify persistence and control log size/retention

### Task 4: Advanced Log Analysis
- Search for patterns in logs
- Review logs by boot sessions
- Export logs for external analysis
- Basic monitoring idea using log checks

## ✅ Conclusion (What I Learned)
After completing this lab, I can:
- Use `journalctl` to quickly inspect system/service logs
- Filter logs to isolate real problems faster
- Set up persistent logging for audit/history purposes
- Manage log retention so journaling doesn’t consume too much disk

## 🔐 Why This Matters
- Logs are the first place to look during failures (services, boot issues, auth problems)
- Journal provides structured, searchable logs that improve troubleshooting speed
- Persistent logs are important for auditing, incident review, and compliance

## 🌍 Real-World Relevance
These skills are used in:
- Production server troubleshooting (service crashes, login failures, network issues)
- Security investigations (authentication attempts, suspicious behavior)
- DevOps/SRE monitoring workflows (alerts, log reviews, root cause analysis)
- RHCSA-style troubleshooting and system validation

## ✅ Result
A working ability to analyze systemd journal logs efficiently, with filtering and persistence configured for reliable long-term log access.
