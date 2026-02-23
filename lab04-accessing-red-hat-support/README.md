# 🧪 Lab 04: Accessing Red Hat Support

---

## 🎯 Objectives

By completing this lab, you will be able to:

- 🛠️ Collect system diagnostic data using open-source Linux tools
- 📦 Package troubleshooting artifacts for support submission
- 🌐 Navigate the Red Hat Customer Portal
- 📑 Submit a structured Red Hat support case
- 📚 Utilize the Red Hat Knowledge Base effectively
- 🚨 Escalate a support case appropriately

---

## 🖥️ Lab Environment

| Component | Value |
|------------|--------|
| OS | CentOS Stream 9 |
| Kernel | 5.14.0-427.el9.x86_64 |
| User | student |
| Hostname | centos-stream9 |
| Shell | -bash-4.2$ |

> 🔎 Note: CentOS Stream 9 was used as an open-source alternative to RHEL 9 for lab simulation.

---

## 📂 Repository Structure

```

lab04-accessing-red-hat-support/
│
├── README.md
├── commands.sh
├── system_diagnostics/
│   ├── system_journal.log
│   ├── dmesg_output.log
│   └── installed_packages.list
│
├── system_diagnostics_20260223.tar.gz
├── output.txt
├── interview_qna.md
└── troubleshooting.md

```

---

## 🧩 Task Overview

### 🔹 Task 1: Collect System Diagnostic Data

- Installed `inxi` for detailed system overview
- Collected:
  - Kernel & OS details
  - CPU, Memory, Storage info
  - Network interface details
- Captured:
  - Journal logs
  - Kernel ring buffer (`dmesg`)
  - Installed packages list
- Archived diagnostic artifacts into a compressed tarball

---

### 🔹 Task 2: Submit a Support Case

- Accessed: https://access.redhat.com
- Opened new support case
- Attached diagnostic tarball
- Selected severity level
- Documented issue clearly
- Received case number confirmation

---

### 🔹 Task 3: Explore Knowledge Base & Escalation

- Searched Knowledge Base for:
  - Podman networking issues
  - SELinux container restrictions
  - Cgroup troubleshooting
- Tested Podman functionality locally
- Escalated support case due to workflow impact

---

## 📦 Diagnostic Artifacts Collected

- `system_journal.log`
- `dmesg_output.log`
- `installed_packages.list`
- `system_diagnostics_20260223.tar.gz`

These artifacts simulate real-world enterprise troubleshooting workflows.

---

## 🔐 Why This Lab Matters (Real-World Relevance)

In enterprise Linux environments:

- Support cases must include structured diagnostics
- Logs and system metadata are mandatory for triage
- Proper severity classification speeds resolution
- Escalation workflows impact production SLAs
- Knowledge Base research reduces downtime

This lab mirrors how Linux administrators interact with Red Hat Support in production environments.

---

## 🏢 Real-World Application

This workflow is critical in:

- OpenShift clusters
- RHEL production servers
- Containerized DevOps environments
- Performance or stability investigations
- Security incident investigations

---

## 📈 Result

✔ Successfully collected system diagnostics  
✔ Created structured support case  
✔ Attached required artifacts  
✔ Explored Knowledge Base resources  
✔ Escalated case appropriately  

---

## 🧠 What I Learned

- Enterprise troubleshooting requires structured evidence
- Log collection and packaging must be systematic
- Red Hat Support workflow follows strict categorization
- Severity levels influence response time
- Escalation should be justified and documented

---

## 🏁 Conclusion

This lab demonstrated the full lifecycle of:

Collect → Analyze → Document → Submit → Escalate

These are essential skills for:

- RHCSA / RHCE professionals
- Enterprise Linux administrators
- DevOps engineers
- Cloud infrastructure teams
- Container platform operators

---

🔴 RHCSA Focus Area:
Support workflows, system diagnostics, log management, and enterprise troubleshooting.
