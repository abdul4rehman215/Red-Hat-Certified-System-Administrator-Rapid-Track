# 🧪 Lab 05: Linux File System Hierarchy

---

## 🎯 Objectives

By completing this lab, I was able to:

- 📂 Understand the Linux File System Hierarchy (FHS)
- 🧭 Navigate the filesystem using command-line tools
- 🛠️ Explore critical system directories and their roles
- 🔗 Understand and create symbolic and hard links
- 🧠 Compare inode behavior between link types

---

## 🖥️ Lab Environment

| Component | Value |
|------------|--------|
| OS | Ubuntu 24.04.1 LTS |
| User | toor |
| Host | ip-172-31-10-214 |
| Interface | ens5 |
| Shell | Bash |

Prompt used:

```

toor@ip-172-31-10-214:~$

```

---

## 📂 Repository Structure

```

lab05-linux-file-system-hierarchy/
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

## 🔹 Task 1: Exploring Key Directories

### 📁 Root Directory (/)

- Listed root filesystem
- Identified core directories
- Understood `/` as the top-level filesystem

---

### 📁 /bin and /sbin

- `/bin` → Essential user commands
- `/sbin` → System administration binaries
- Observed command utilities like `bash`, `cp`, `iptables`, `shutdown`

---

### 📁 /etc

- Explored system configuration files
- Viewed `/etc/passwd`
- Identified user account structure

---

### 📁 /home

- Navigated to user home directory
- Created test files
- Verified working directory

---

### 📁 /usr

- Observed application hierarchy
- Counted executables in `/usr/bin`
- Understood `/usr` for user-level applications

---

### 📁 /var

- Identified variable data storage
- Explored `/var/log`
- Understood log storage structure

---

### 📁 /tmp

- Created temporary files
- Understood temporary filesystem behavior

---

# 🧭 Task 2: File System Navigation

- Used `pwd`, `cd`, `ls -l`
- Navigated parent and home directories
- Used `find` to locate configuration files
- Used `locate` to search system-wide files

---

# 🔗 Task 3: Symbolic and Hard Links

- Identified symbolic links in `/bin`
- Created symbolic link
- Created hard link
- Compared inode numbers
- Observed filesystem behavior differences

---

# 🔐 Why This Lab Matters (Real-World Relevance)

Understanding filesystem hierarchy is foundational for:

- Linux system administration
- Troubleshooting misconfigurations
- Log investigation
- Package management
- Container runtime understanding
- Security auditing
- DevOps automation

---

# 🏢 Enterprise Application

This knowledge directly applies to:

- RHEL / Ubuntu production servers
- OpenShift container environments
- Log management systems
- System recovery procedures
- Security hardening practices

---

# 📈 Result

✔ Successfully explored standard Linux filesystem  
✔ Practiced directory navigation  
✔ Located configuration files  
✔ Created symbolic and hard links  
✔ Compared inode behavior  

---

# 🧠 What I Learned

- Linux follows a standardized filesystem hierarchy (FHS)
- Configuration files reside in `/etc`
- Logs are centralized in `/var/log`
- `/usr` contains application binaries
- Hard links share inodes
- Symbolic links reference file paths
- Filesystem knowledge is critical for troubleshooting

---

# 🏁 Conclusion

The Linux File System Hierarchy is the structural backbone of any Linux distribution.

Mastering this structure enables:

- Efficient navigation
- Faster troubleshooting
- Better system understanding
- Secure configuration management
- Advanced administration readiness

---

🔴 RHCSA Focus:
Filesystem structure, navigation, inode understanding, log location awareness.
