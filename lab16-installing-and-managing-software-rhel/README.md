# 🧪 Lab 16: Installing and Managing Software in RHEL

## 📌 Overview

This lab demonstrates enterprise package management in **Red Hat Enterprise Linux 9**, using the modern `dnf` package manager.

The lab covers:

- Installing and removing software
- Updating systems
- Managing repositories
- Resolving dependencies
- Expanding package sources via EPEL

This skill is foundational for RHCSA, system administration, DevOps, and production Linux operations.

---

## 🎯 Objectives

By the end of this lab, you will be able to:

- Install packages using `dnf`
- Update and remove software
- Enable and configure repositories
- Manage dependency resolution
- Verify installed packages using `rpm` and `dnf`

---

## ✅ Prerequisites

- RHEL 8/9 system
- sudo/root access
- Active subscription
- Internet connectivity

---

## 🖥️ Lab Environment

- **OS:** Red Hat Enterprise Linux 9.3
- **User:** student
- **Hostname:** rhel9-pkg-lab
- **Shell:** -bash-4.2$

---

## 🗂️ Repository Structure

```

lab16-installing-and-managing-software-rhel/
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
└── troubleshooting.md

```

---

## 🧩 Tasks Performed

### Task 1: Install Software
- Verified `dnf` and `yum`
- Installed `htop`
- Verified installation

### Task 2: Update & Remove Packages
- Updated system
- Removed `htop`
- Verified removal

### Task 3: Configure Repositories
- Listed enabled repositories
- Installed EPEL
- Installed `nginx` (with dependency resolution)
- Verified package installation via `rpm`

---

## 🔐 Enterprise Relevance

Package management is critical for:

- Server provisioning
- Patch management
- Security updates
- Dependency handling
- Production software lifecycle management

Modern RHEL uses `dnf` with automatic dependency resolution, transaction tracking, and repository management.

---

## ✅ Conclusion

In this lab, I demonstrated full lifecycle software management using `dnf`, repository configuration, and dependency handling in RHEL 9 — an essential skill for enterprise Linux administration.
