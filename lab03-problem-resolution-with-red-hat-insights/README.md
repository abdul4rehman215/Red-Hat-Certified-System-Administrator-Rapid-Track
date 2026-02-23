# 🧪 Lab 03 – Problem Resolution with Red Hat Insights

## 🎯 Objective

This lab focuses on proactive system monitoring and remediation using **Red Hat Insights**.

By completing this lab, I achieved the ability to:

- Register a RHEL system with Red Hat Subscription Manager (RHSM)
- Install and configure the `insights-client`
- Upload system metadata for health analysis
- Review categorized recommendations (Security, Performance, Stability, Availability)
- Apply recommended fixes
- Validate remediation via Insights dashboard

This lab reinforces enterprise-level system management and security posture improvement skills required in RHCSA environments.

---

## 🖥️ Lab Environment

| Component | Value |
|------------|--------|
| OS | Red Hat Enterprise Linux 8.9 (Ootpa) |
| Hostname | rhel8-lab |
| User | student |
| Subscription | Active |
| Insights Client Version | 3.1.5-1.el8 |
| Prompt Style | `[student@rhel8-lab ~]$` |

---

## 📂 Repository Structure

lab03-problem-resolution-with-red-hat-insights/
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
└── troubleshooting.md

---

# 🧩 Task Overview & Execution Summary

---

## 🔹 Task 1 – Register and Subscribe the System

### ✔ Step 1.1 – Register with RHSM

The system was registered using `subscription-manager` with valid credentials.

- Registration successful
- Unique system ID generated
- System name assigned

### ✔ Step 1.2 – Attach Subscription

Used:

```bash
sudo subscription-manager attach --auto
````

System successfully subscribed to RHEL for x86_64.

---

## 🔹 Task 2 – Install and Configure Red Hat Insights Client

### ✔ Installed `insights-client`

Installed via `dnf` from RHEL AppStream repository.

### ✔ Registered System with Insights

Used:

```bash
sudo insights-client --register
```

System successfully registered and visible in Red Hat Console inventory.

### ✔ Performed Initial System Analysis

Uploaded metadata and configuration details to Insights dashboard.

---

## 🔹 Task 3 – Investigate Health Checks and Recommendations

Accessed:

```
https://console.redhat.com
```

Navigated to:

Insights → Systems → rhel8-lab

Insights categorized findings as:

* 🔴 Security
* 🟠 Important
* 🟡 Moderate
* 🔵 Availability
* 🟢 Stability

Identified issues:

| Severity     | Issue                   |
| ------------ | ----------------------- |
| 🔴 Critical  | SSH root login enabled  |
| 🟠 Important | Kernel update available |
| 🟡 Moderate  | Outdated bash package   |

---

## 🔹 Task 4 – Implement Recommended Fixes

### ✔ Updated Outdated Package

Upgraded `bash` package via:

```bash
sudo dnf update bash -y
```

### ✔ Hardened SSH Configuration

Edited:

```
/etc/ssh/sshd_config
```

Changed:

```
PermitRootLogin no
```

Restarted SSH service.

---

## 🔹 Task 5 – Verify Fixes

Re-ran:

```bash
sudo insights-client
```

Uploaded updated configuration.

Dashboard confirmed:

✔ SSH misconfiguration resolved
✔ Bash update recommendation cleared

---

# 📊 Result

* System successfully registered with RHSM
* Insights client installed and configured
* Health analysis performed
* Security and package issues identified
* Remediation applied successfully
* Dashboard reflected resolved status

All tasks completed successfully.

---

# 🧠 What I Learned

* How Red Hat Insights integrates with RHEL systems
* Importance of subscription registration
* Insights provides proactive remediation guidance
* Security misconfigurations can be automatically detected
* System updates improve stability and reduce vulnerabilities
* Enterprise systems rely on automated health analysis tools

---

# 🛡️ Why This Matters

Red Hat Insights reduces:

* Manual troubleshooting
* Security misconfigurations
* Outdated package risks
* Operational downtime

It enables proactive system health monitoring.

---

# 🌍 Real-World Applications

* Enterprise fleet management
* Compliance validation
* Security hardening
* Automated patch management
* Risk assessment
* Infrastructure auditing

---

# 🔎 Real-World Relevance

In enterprise environments:

* Hundreds or thousands of RHEL systems require monitoring
* Manual checks are inefficient
* Insights provides centralized visibility
* Security teams rely on dashboards for posture management

This lab simulates real-world proactive Linux system administration.

---

# ✅ Conclusion

In this lab, I:

✔ Registered a RHEL system with RHSM
✔ Installed and configured insights-client
✔ Uploaded system data for analysis
✔ Reviewed categorized recommendations
✔ Applied security and package updates
✔ Verified resolution via Insights dashboard

This lab strengthened my RHCSA-level system management and proactive troubleshooting skills.

---

📌 Lab Status: Completed Successfully
🟥 Track: RHCSA Rapid Track
