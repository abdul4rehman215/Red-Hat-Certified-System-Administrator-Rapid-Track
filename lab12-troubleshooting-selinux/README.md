# 🧪 Lab 12: Troubleshooting SELinux

---

## 📌 Repository Structure

lab12-troubleshooting-selinux/
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
└── troubleshooting.md

---

# 🎯 Objectives

By the end of this lab, I was able to:

- Identify SELinux AVC denials using system logs
- Analyze SELinux enforcement behavior
- Generate custom SELinux policy modules
- Use audit2allow to create and apply rules
- Install and verify policy modules using semodule

---

# 🖥️ Lab Environment

| Component | Value |
|------------|--------|
| OS | Red Hat Enterprise Linux 9.3 |
| Hostname | rhel9-selinux-troubleshoot |
| User | student |
| SELinux Mode | Enforcing |
| Policy Type | targeted |

Prompt:

-bash-4.2$

---

# ⚙️ Lab Overview

This lab simulates a real-world SELinux denial scenario where:

- A web server (httpd) attempts to access a file
- The file has an incorrect SELinux context
- SELinux blocks the action
- We identify the denial
- Generate a policy module
- Apply and verify the fix

---

# 🧩 Tasks Performed

## 1️⃣ Install SELinux Troubleshooting Tools

Installed required packages:

- policycoreutils-python-utils
- setools-console
- audit

These provide:
- ausearch
- audit2allow
- semodule
- sealert
- SELinux policy utilities

---

## 2️⃣ Identify SELinux Denials

- Verified SELinux mode using `sestatus`
- Simulated denial using incorrect context
- Checked AVC logs using:
  - ausearch
  - grep audit logs

Confirmed denial:
httpd_t denied read access to file labeled default_t

---

## 3️⃣ Generate Custom SELinux Policy Module

Used:

ausearch -m avc -ts recent | audit2allow -M mypolicy

Generated:
- mypolicy.te
- mypolicy.mod
- mypolicy.pp

Installed module using:
semodule -i mypolicy.pp

Verified using:
semodule -l

---

## 4️⃣ Generate Human-Readable Rules

Used:

ausearch -m avc -ts recent | audit2allow

Output:
allow httpd_t default_t:file read;

---

## 5️⃣ Validate Fix

Re-tested operation.
Confirmed:

No new AVC denials detected.

---

# 🏁 Conclusion

In this lab, you successfully:

- Diagnosed SELinux AVC denials
- Understood scontext and tcontext fields
- Created and installed custom policy modules
- Used audit2allow effectively
- Verified enforcement behavior

---

# 🌍 Real-World Relevance

SELinux troubleshooting is critical in:

- Enterprise RHEL environments
- Apache / NGINX deployments
- OpenShift clusters
- Containerized workloads
- Government and regulated infrastructure

Instead of disabling SELinux, administrators must properly:

- Identify denials
- Analyze context mismatches
- Apply minimal, controlled policy adjustments

---

# 🔐 Security Insight

⚠ Never disable SELinux in production.

Always evaluate:

- Is restorecon sufficient?
- Is context misconfiguration the root cause?
- Is a custom policy truly required?

Proper SELinux troubleshooting preserves system integrity while maintaining functionality.

---

# 🎓 RHCSA Exam Relevance

Skills covered:

- Interpreting AVC denials
- Using audit2allow
- Installing policy modules
- Validating SELinux enforcement

These are core RHCSA and enterprise Linux skills.
