# 🧪 Lab 24: File and Directory Permissions

---

## 📌 Lab Overview

This lab focuses on **Linux file security fundamentals**, including:

- Standard permission model (rwx)
- Numeric and symbolic `chmod`
- Ownership management with `chown` and `chgrp`
- Advanced permission control using **Access Control Lists (ACLs)**
- Real-world permission troubleshooting

All exercises were performed on a CentOS/RHEL cloud environment using both regular user and root privileges.

---

# 🎯 Objectives

By completing this lab, I successfully:

- Understood and applied Linux permission concepts (r, w, x)
- Modified file and directory permissions using:
  - Numeric notation (`755`, `644`, `600`)
  - Symbolic notation (`u+x`, `g-w`, `o-rwx`)
- Changed ownership using `chown`
- Changed group ownership using `chgrp`
- Applied recursive ownership changes
- Implemented and verified ACLs using:
  - `setfacl`
  - `getfacl`
- Used default ACLs for inherited permissions
- Verified extended ACL presence via `ls -l` (`+` indicator)
- Troubleshot common permission and ACL issues

---

# 🖥️ Lab Environment

- OS: CentOS/RHEL
- User: `centos`
- Root access via `sudo`
- Filesystem: XFS (ACL enabled by default)
- ACL utilities: `/usr/bin/setfacl`, `/usr/bin/getfacl`

---

# 📂 Repository Structure (Lab 04)

```

lab24-file-directory-permissions/
│
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
├── troubleshooting.md
│
└── scripts/
└── permission_test.sh

```

---

# 🧩 Tasks Performed (Overview)

---

## 🔐 Task 1 — File Permissions with `chmod`

### Created Working Environment
- Created directory `~/permissions_lab`
- Created:
  - `textfile.txt`
  - `script.sh`
  - `testdir/`

### Practiced Numeric Permissions
- `chmod 755 script.sh`
- `chmod 600 textfile.txt`

### Practiced Symbolic Permissions
- `chmod g+x,o+x script.sh`
- `chmod g-w textfile.txt`
- `chmod u+rw,g+r,o-rwx textfile.txt`

### Directory Permission Behavior
- Removed execute bit from directory (`chmod -x testdir`)
- Demonstrated inability to `cd` or `ls` inside directory
- Restored access (`chmod +x testdir`)

---

## 👤 Task 2 — Ownership Management with `chown`

### Created Test User & Group
- `testuser`
- `testgroup`
- Added user to group

### Ownership Changes
- Changed file owner
- Changed file owner and group
- Applied recursive ownership (`-R`)
- Used `chgrp` to change only group ownership

---

## 🧾 Task 3 — Access Control Lists (ACLs)

### Verified ACL Support
- `which setfacl getfacl`
- Confirmed filesystem support (XFS)

### Applied Basic ACLs
- Granted specific user permissions
- Granted group ACL entries
- Verified `+` in `ls -l`

### Applied Default ACLs
- Set default ACLs on directory
- Verified inheritance behavior
- Observed ACL mask effects

### Removed ACL Entries
- Removed specific entries (`-x`)
- Removed all ACLs (`-b`)
- Verified removal via `getfacl` and `ls -l`

---

## 🧪 Permission Testing Script

Created and executed:

```
scripts/permission_test.sh
```

This script:
- Displays file permissions
- Displays directory permissions
- Lists ACL-enabled files
- Tests read/execute access
- Shows detailed ACL output

---

# 🔐 Security & Real-World Relevance

Understanding file permissions is critical for:

- Protecting sensitive files
- Preventing privilege escalation
- Enforcing least privilege
- Application access control
- Compliance requirements
- Multi-user server environments

ACLs provide granular access control beyond traditional Unix permission models.

---

# ⚙️ Key Linux Permission Model

| Symbol | Meaning | Value |
|--------|----------|--------|
| r | Read | 4 |
| w | Write | 2 |
| x | Execute | 1 |

Example:

```

rwxr-x--- = 750

```

---

# 🧠 Practical Lessons Learned

- Execute bit on directories is required for traversal.
- `chmod 600` protects sensitive files.
- `-R` must be used carefully with ownership changes.
- ACL mask influences effective permissions.
- `+` in `ls -l` indicates extended ACL entries.
- Always verify using `getfacl`.

---

# 🎯 Result

Successfully demonstrated:

- Standard permission control
- Ownership management
- ACL configuration
- Permission verification
- Real-world troubleshooting scenarios

This lab directly aligns with **RHCSA objectives** related to file permissions, ownership, and ACL management.

---

📌 Lab executed in a cloud-based CentOS/RHEL environment.
