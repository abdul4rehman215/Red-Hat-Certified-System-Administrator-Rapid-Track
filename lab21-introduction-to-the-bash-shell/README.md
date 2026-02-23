# 🧪 Lab 21: Introduction to the Bash Shell (RHCSA Rapid Track)

---

## 📌 Lab Summary

This lab introduces the **Bash shell** as the primary command-line interface used in CentOS/RHEL environments.  
It covers **core navigation**, **file/directory operations**, **redirection & piping**, and **basic shell scripting** — foundational skills required for **RHCSA** and real-world Linux administration.

---

## 🎯 Objectives

By the end of this lab, I was able to:

- Access and navigate the Linux CLI using Bash
- Execute core Bash commands for directory and file operations
- Use **input/output redirection** and **piping** to chain commands
- Create, edit, and execute simple shell scripts
- Apply command-line skills essential for Red Hat system administration
- Build confidence with commands commonly used in RHCSA exam tasks

---

## 📋 Prerequisites

Before starting this lab, the following was assumed:

- Basic understanding of file/folder concepts
- Familiarity with text editing basics
- No prior Linux CLI experience required
- Access to the Al Nafi cloud-based lab environment

---

## 🖥️ Lab Environment

| Component | Details |
|----------|---------|
| Platform | Al Nafi Cloud Lab |
| OS | CentOS / RHEL-based |
| Shell | Bash (`-bash-4.2$`) |
| Bash Version | 4.2.46 |
| User | `centos` |
| Access | Root-capable environment (administrative tasks supported) |
| Timezone | UTC (cloud environment default) |

---

## 📂 Repository Structure

```text
lab21-introduction-to-the-bash-shell/
│── README.md
│── commands.sh
│── output.txt
│── interview_qna.md
│── troubleshooting.md
└── scripts/
    ├── hello-world.sh
    ├── system-report.sh
    ├── user-info.sh
    └── file-manager.sh
````

> 📌 Note: All outputs from the terminal and scripts are captured in `output.txt` exactly as produced in the lab.

---

## 🧩 Lab Tasks Overview

### ✅ Task 1: Access the Command Line Interface

* Connected to the cloud terminal environment
* Verified default shell (`$SHELL`)
* Confirmed Bash version (`bash --version`)
* Checked identity (`whoami`) and system time (`date`)

---

### ✅ Task 2: Use Basic Bash Commands

**Filesystem navigation and management**

* Verified working directory (`pwd`)
* Explored file listings (`ls`, `ls -l`, `ls -la`)
* Navigated between `/`, `~`, and lab working folders using `cd`
* Created structured directories (`mkdir`, `mkdir -p`, `ls -R`)
* Created and managed files (`touch`, `echo`, `nano`, `cat`)
* Copied, moved, renamed, and deleted files (`cp`, `mv`, `rm`)

---

### ✅ Task 3: Practice Redirection and Piping

**Output redirection**

* Sent command output to files using `>`
* Appended content using `>>`
* Captured and inspected results using `cat`

**Input redirection**

* Sorted input using `<`
* Demonstrated default string-based sort behavior

**Pipes**

* Used pipes to chain commands:

  * `ls | wc -l`
  * `ps aux | grep bash`
  * `du -h | sort -hr`
  * `cat /etc/passwd | grep root`
  * `ls -la | grep "^d" | wc -l`

**Advanced redirection**

* Captured stdout and stderr separately:

  * `> output.txt 2> error.txt`
* Combined stdout and stderr:

  * `> combined.txt 2>&1`
* Used `tee` to display and save output simultaneously

---

### ✅ Task 4: Create and Execute Simple Scripts

Created multiple Bash scripts inside `scripts/`:

1. **hello-world.sh**

   * Printed greeting, date, and user

2. **system-report.sh**

   * Printed system summary:

     * uptime
     * disk usage (`df -h`)
     * memory usage (`free -h`)
     * file count (`ls | wc -l`)

3. **user-info.sh**

   * Interactive input script using `read`
   * Generated a personalized output file (`<name>-info.txt`)

4. **file-manager.sh**

   * Created dated backup directory
   * Copied `*.txt` files into backup directory using a `for` loop

---

## ✅ Verification & Validation

Lab validation steps included:

* Verified directory structure using:

  * `find . -type d`
* Confirmed scripts are executable using:

  * `ls -la scripts/`
* Successfully executed scripts:

  * `./hello-world.sh`
  * `./system-report.sh`
* Confirmed redirection output files exist and contain expected content:

  * `file-listing.txt`, `directory-listing.txt`, `combined.txt`, `error.txt`, etc.

---

## ✅ Result

* Bash environment verified and used successfully
* Directory hierarchy created cleanly under `~/lab1-practice`
* File management operations completed (create/copy/move/delete)
* Redirection and piping demonstrated across multiple real commands
* Multiple executable scripts created and executed successfully
* Lab confirmed completed using validation commands

---

## 🌍 Why This Matters (RHCSA Relevance)

Bash is the default command-line interface for Red Hat-based systems.
Mastering these fundamentals directly supports RHCSA exam objectives, including:

* Efficient filesystem navigation
* File and directory management
* Command chaining and output handling
* Simple automation via shell scripts

These are daily-use skills for Linux system administrators in production.

---

## 🚀 Real-World Applications

Skills practiced here apply to:

* Managing Linux servers via CLI (SSH sessions)
* Automating repetitive admin tasks using scripts
* Collecting system diagnostics quickly (uptime, disk, memory)
* Auditing filesystem layouts and file listings
* Troubleshooting using logs and command pipelines

---

## 🎓 Conclusion

This lab established strong Bash foundations by practicing:

✅ Core Linux commands
✅ Redirection & piping
✅ Script creation and execution
✅ Validation techniques

These building blocks are essential for progressing into deeper RHCSA topics like permissions, users/groups, services, storage, networking, and SELinux.

---

✅ **Lab Completed Successfully**
CentOS/RHEL Cloud Lab Environment — Bash 4.2
