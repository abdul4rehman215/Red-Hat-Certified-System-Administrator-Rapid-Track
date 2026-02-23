# 🧪 Lab 06: File and Directory Management

---

## 🎯 Objectives

By completing this lab, I was able to:

- 📁 Create and delete files and directories
- 📦 Move and copy files between locations
- 🧭 Use relative and absolute paths effectively
- 🏗️ Create nested directory structures
- 🔍 Verify filesystem structure using `tree` and `find`

---

## 🖥️ Lab Environment

| Component | Value |
|------------|--------|
| OS | Ubuntu 24.04.1 LTS |
| User | toor |
| Host | ip-172-31-10-229 |
| Home Directory | /home/toor |
| Shell | Bash |

Prompt used:

```

toor@ip-172-31-10-229:~$

```

---

## 📂 Repository Structure

```

lab06-file-and-directory-management/
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

## 🔹 Task 1: Create and Delete Files and Directories

- Created lab working directory
- Created files using `touch`
- Created directories using `mkdir`
- Deleted files using `rm`
- Removed directories using `rm -r`
- Observed restriction of `rmdir` on non-empty directories

---

## 🔹 Task 2: Move and Copy Files

- Moved files using `mv`
- Copied files using `cp`
- Created backup copies
- Verified file placement
- Understood difference between move and copy operations

---

## 🔹 Task 3: Relative and Absolute Paths

- Navigated directories using relative paths
- Created files using absolute paths
- Copied files using full absolute paths
- Verified directory structure

---

## 🚀 Advanced Exercise

- Created nested directory structure using brace expansion
- Moved multiple files using wildcard `*.txt`
- Installed and used `tree` to visualize structure
- Verified directories using `find`

---

# 🔐 Why This Lab Matters (Real-World Relevance)

File management is foundational in:

- Linux system administration
- DevOps CI/CD pipelines
- Backup automation
- Log management
- Container build systems
- Security incident response

---

# 🏢 Enterprise Application

These commands are used daily in:

- Managing application deployments
- Organizing configuration files
- Performing system cleanup
- Preparing production environments
- Automating file operations in scripts

---

# 📈 Result

✔ Created and removed directories safely  
✔ Moved and copied files correctly  
✔ Used both relative and absolute paths  
✔ Built structured project directories  
✔ Verified filesystem layout  

---

# 🧠 What I Learned

- `rm -r` is required for recursive deletion
- `rmdir` works only on empty directories
- `mv` renames or relocates files
- `cp` duplicates file content
- Absolute paths start with `/`
- Relative paths depend on current directory
- Wildcards (`*.txt`) simplify batch operations
- `tree` and `find` help verify structure

---

# 🏁 Conclusion

File and directory management is a core Linux skill.

Mastering these operations ensures:

- Efficient system navigation
- Safe file handling
- Organized project structures
- Readiness for RHCSA-level administration

---

🔴 RHCSA Focus:
File manipulation, recursive operations, path management, directory structure control.
