# 🧪 Lab 22: File System Navigation

---

## 📌 Lab Overview

This lab focuses on mastering Linux file system navigation and understanding file permissions in a CentOS/RHEL environment. The exercises reinforce essential RHCSA-level command-line skills required for daily Linux system administration.

All tasks were performed on a cloud-based RHEL/CentOS lab environment using Bash shell.

---

# 🎯 Objectives

By completing this lab, I developed the ability to:

- Navigate the Linux file system using `cd`, `ls`, and `find`
- Understand directory hierarchy from root (`/`)
- Create and organize directories using `mkdir` and `mkdir -p`
- Create and manage files using `touch`, `echo`, and `nano`
- Move and copy files using `mv` and `cp`
- Analyze file permissions using `ls -l` and `stat`
- Modify permissions using numeric and symbolic `chmod`
- Understand directory execute permission behavior
- Troubleshoot permission-related access issues

---

# 🖥️ Lab Environment

- OS: CentOS / RHEL (Cloud-based environment)
- Shell: Bash 4.2
- User: `centos`
- Access: Full terminal access
- Tools Used:
  - cd
  - ls
  - find
  - mkdir
  - touch
  - echo
  - nano
  - mv
  - cp
  - chmod
  - stat
  - tree / find

---

# 📂 Repository Structure 

```

lab22-file-system-navigation/
│
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
├── troubleshooting.md
│
└── workspace/
├── readme.txt
├── welcome.txt
├── myinfo.txt
├── permissions_test.txt
├── myscript.sh
│
├── level1/
│   ├── file1.txt
│   └── level2/
│       ├── file2.txt
│       ├── file3.txt
│       └── level3/
│           └── welcome.txt
│
└── permission_test_dir/
└── test_file.txt

```

---

# 🧩 Tasks Performed (Overview)

## 🧭 Task 1 – Directory Navigation

- Verified current location using `pwd`
- Navigated root `/`
- Explored `/home`
- Used `cd ..` and `cd -`
- Tested relative vs absolute paths
- Used `find` to locate files and directories
- Filtered `.conf` files inside `/etc`

---

## 📁 Task 2 – Directory & File Creation

- Created `lab2_practice` directory
- Built nested directory structure using `mkdir -p`
- Created multiple files using `touch`
- Created content using `echo`
- Created multi-line file using `nano`
- Organized files using `mv` and `cp`
- Verified structure using `find`

---

## 🔐 Task 3 – File Permissions

- Analyzed permission format (`rwx`)
- Viewed numeric permissions using `stat`
- Modified permissions using numeric mode:
  - 644
  - 744
  - 755
- Used symbolic mode:
  - `chmod g+x`
  - `chmod o-r`
- Demonstrated directory execute permission impact
- Restored access after permission removal
- Created and executed script after applying execute permission

---

# 🔍 Key Concepts Reinforced

## 1️⃣ File Permission Breakdown

Permission format:

```

-rwxr-x--

```

| Section | Meaning |
|----------|----------|
| First char | File type (- file, d directory) |
| Next 3 | Owner permissions |
| Next 3 | Group permissions |
| Last 3 | Others permissions |

Numeric Mapping:

| Permission | Value |
|------------|-------|
| r | 4 |
| w | 2 |
| x | 1 |

Example:

- 755 = rwxr-xr-x
- 750 = rwxr-x---

---

# 💡 Real-World Relevance

Understanding file system navigation and permissions is critical for:

- Securing Linux servers
- Managing application access
- Controlling script execution
- Protecting sensitive configuration files
- Managing production system directories
- Diagnosing permission errors in enterprise systems

---

# 🏆 Skills Gained

- Confident navigation of Linux directory tree
- Deep understanding of file vs directory permissions
- Practical chmod usage (numeric & symbolic)
- Ability to diagnose permission-related errors
- Efficient file organization in CLI environment
- Preparedness for RHCSA exam scenarios

---

# 🧠 Why This Matters for RHCSA

The RHCSA exam heavily tests:

- Directory traversal
- Permission manipulation
- File creation & organization
- Script execution permissions
- Understanding access control

This lab directly aligns with those requirements.

---

# ✅ Result

Successfully created structured directory hierarchy, managed files, modified permissions, tested execution rights, and validated system behavior through real command-line operations.

All objectives achieved in a controlled cloud lab environment.

---
