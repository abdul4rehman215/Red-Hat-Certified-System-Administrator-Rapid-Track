# 🧪 Lab 11: Introduction to SELinux

---

## 🎯 Objectives

By completing this lab, I was able to:

- 🔐 Install and verify SELinux components
- 🔄 Understand and switch between SELinux modes
- 🏷️ View and modify SELinux file contexts
- 🛠 Troubleshoot SELinux denials

---

## 🖥️ Lab Environment

| Component | Value |
|------------|--------|
| OS | Red Hat Enterprise Linux 9.3 |
| User | student |
| Hostname | rhel9-selinux-lab |
| Shell | Bash |

---

## 📂 Repository Structure

```

lab11-introduction-to-selinux/
│
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
└── troubleshooting.md

```

---

# 🧩 Task Overview

---

## 🔹 Task 1: Verify SELinux Installation

- Checked installed SELinux packages
- Verified policy type (targeted)
- Confirmed enforcing mode

---

## 🔹 Task 2: Understand SELinux Modes

SELinux operates in three modes:

| Mode | Description |
|------|------------|
| Enforcing | Policies enforced |
| Permissive | Violations logged but allowed |
| Disabled | SELinux completely turned off |

Performed:
- Temporary mode switching (`setenforce`)
- Permanent configuration via `/etc/selinux/config`
- Verified after reboot

---

## 🔹 Task 3: Check and Modify Contexts

- Viewed file contexts using `ls -Z`
- Modified context using `chcon`
- Restored default context using `restorecon`
- Investigated denials using `ausearch`
- Generated custom policy module using `audit2allow`

---

# 🔐 Security Relevance

SELinux provides **Mandatory Access Control (MAC)**.

Unlike traditional Linux permissions (DAC):

- SELinux restricts even root processes.
- Policies define allowed interactions between processes and resources.
- Prevents lateral movement and privilege escalation.

---

# 🏢 Enterprise Application

SELinux is critical in:

- RHEL production servers
- Financial and healthcare systems
- Government compliance environments
- OpenShift container nodes
- Kubernetes infrastructure

It protects against:

- Compromised services
- Web server exploits
- Unauthorized file access
- Container escape attacks

---

# 📈 Results

✔ Verified SELinux is installed and active  
✔ Switched between enforcing and permissive modes  
✔ Permanently configured SELinux mode  
✔ Viewed and modified file contexts  
✔ Generated custom policy module  
✔ Restored default security context  

---

# 🧠 What I Learned

- SELinux enforces Mandatory Access Control
- `sestatus` and `getenforce` check modes
- `setenforce` changes mode temporarily
- `ls -Z` shows security context
- `chcon` modifies context
- `restorecon` resets to default
- `audit2allow` generates policy modules

---

# 🏁 Conclusion

SELinux adds an advanced security layer beyond standard Linux permissions.

Understanding:

- SELinux modes
- Security contexts
- Policy enforcement
- Denial troubleshooting

Is essential for RHCSA and enterprise Linux security administration.

---

🔴 RHCSA Focus:
SELinux management, context handling, policy enforcement.
