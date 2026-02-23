# 🧪 Lab 07: User and Group Management in Linux

---

## 🎯 Objectives

By completing this lab, I was able to:

- 👤 Create and manage local users
- 👥 Create and manage groups
- 🏠 Modify user home directories
- 🖥️ Change default user shells
- 🔐 Assign and remove users from groups
- 🧹 Safely delete users and groups

---

## 🖥️ Lab Environment

| Component | Value |
|------------|--------|
| OS | Ubuntu 24.04.1 LTS |
| User | toor |
| Host | ip-172-31-10-241 |
| Home Directory | /home/toor |
| Shell | Bash |

---

## 📂 Repository Structure

```

lab07-user-and-group-management/
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

## 🔹 Task 1: Create New Users and Groups

### 👤 User Creation

- Created user without home directory
- Created user with automatic home directory
- Verified UID and GID assignments

### 👥 Group Creation

- Created `developers` group
- Verified group entry in `/etc/group`

---

## 🔹 Task 2: Modify User Information

### 🏠 Change Home Directory

- Used `usermod -d -m`
- Moved user content safely
- Verified new home directory

### 🖥️ Change Default Shell

- Updated user shell to `/bin/bash`
- Verified modification via `/etc/passwd`

---

## 🔹 Task 3: Group Assignment and Cleanup

### ➕ Add Users to Group

- Used `usermod -aG`
- Verified membership using `groups`

### ➖ Remove User from Group

- Used `gpasswd -d`
- Confirmed removal

### 🧹 Delete Users and Groups

- Removed user with home directory using `userdel -r`
- Deleted group using `groupdel`
- Verified removal from system files

---

# 🔐 Why This Lab Matters (Real-World Relevance)

User and group management is critical for:

- Access control
- Privilege management
- Role-based security
- Multi-user server environments
- Production infrastructure

---

# 🏢 Enterprise Application

These skills are used daily in:

- Server administration
- Cloud VM management
- OpenShift cluster operations
- DevOps pipelines
- Identity and access management (IAM)
- Security hardening

---

# 📈 Result

✔ Created users with and without home directories  
✔ Managed group membership  
✔ Modified user properties  
✔ Cleanly removed system users  
✔ Verified system configuration files  

---

# 🧠 What I Learned

- Every user has a UID and primary GID
- Groups define shared access permissions
- `/etc/passwd` stores user account info
- `/etc/group` stores group info
- `usermod` modifies account attributes
- `userdel -r` removes user and home directory
- Active processes may block user deletion

---

# 🏁 Conclusion

User and group management is a foundational Linux administration skill.

Mastery of these concepts ensures:

- Secure access control
- Organized permission structures
- Compliance with enterprise security standards
- Readiness for RHCSA-level certification

---

🔴 RHCSA Focus:
User creation, group management, account modification, access control fundamentals.
