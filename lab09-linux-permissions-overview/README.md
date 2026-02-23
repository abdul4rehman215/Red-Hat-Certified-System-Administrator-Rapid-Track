# 🧪 Lab 09: Linux Permissions Overview

---

## 🎯 Objectives

By completing this lab, I will be able to:

- 🔍 Understand Linux file and directory permissions
- 📄 View permissions using `ls -l`
- 🛠 Modify permissions using `chmod`
- 👤 Change ownership using `chown`
- 👥 Modify group ownership using `chgrp`

---

## 🖥️ Lab Environment

| Component | Value |
|------------|--------|
| OS | Ubuntu 24.04.1 LTS |
| User | toor |
| Host | ip-172-31-10-254 |
| Home Directory | /home/toor |
| Shell | Bash |

Prompt used:

```

toor@ip-172-31-10-254:~$

```id="l2p6xt"

---

## 📂 Repository Structure

```

lab09-linux-permissions-overview/
│
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
└── troubleshooting.md

```id="qz4kdn"

---

# 🧩 Task Overview

---

## 🔹 Task 1: Viewing File and Directory Permissions

- Used `ls -l` to inspect permissions
- Identified:
  - File type indicator (`-` or `d`)
  - Owner permissions
  - Group permissions
  - Others permissions
- Interpreted symbolic notation (`rwx`)

---

## 🔹 Task 2: Modifying Permissions with chmod

### Numeric Mode

- Used `chmod 640`
- Understood octal representation:
  - 4 → Read
  - 2 → Write
  - 1 → Execute

### Symbolic Mode

- Added execute permission (`u+x`)
- Removed read permission (`o-r`)
- Verified changes with `ls -l`

---

## 🔹 Task 3: Changing Ownership and Groups

- Created new user
- Changed file owner using `chown`
- Created new group
- Changed group using `chgrp`
- Used combined `chown user:group`
- Verified ownership changes

---

# 🔐 Why This Lab Matters (Security Relevance)

Linux permissions control:

- File access boundaries
- User isolation
- Application security
- Data confidentiality
- Multi-user environment integrity

Misconfigured permissions can lead to:

- Unauthorized access
- Privilege escalation
- Data leakage
- Service compromise

---

# 🏢 Enterprise Application

These concepts are essential for:

- RHEL production systems
- OpenShift container volumes
- Shared application directories
- Log file protection
- Secure DevOps pipelines
- Compliance enforcement

---

# 📈 Result

✔ Interpreted Linux permission notation  
✔ Applied numeric permission changes  
✔ Applied symbolic permission changes  
✔ Modified file ownership  
✔ Managed group assignments  

---

# 🧠 What I Learned

- Permission structure: `rwxrwxrwx`
- Owner, Group, Others model
- Numeric vs symbolic chmod modes
- Ownership directly impacts access control
- `sudo` required for privileged changes
- Permission model enforces security boundaries

---

# 🏁 Conclusion

Linux file permissions form the foundation of system security.

Mastery of:

- `chmod`
- `chown`
- `chgrp`
- Permission interpretation

Is critical for system administrators and security engineers.

---

🔴 RHCSA Focus:
Permission model, numeric notation, ownership management, access control.
