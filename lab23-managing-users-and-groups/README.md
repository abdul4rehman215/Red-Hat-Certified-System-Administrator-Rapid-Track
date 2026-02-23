
# 🧪 Lab 23: Managing Users and Groups

---

## 📌 Lab Overview

This lab covers **core Linux identity and access management** tasks required for RHCSA-level system administration. The workflow includes creating users with different `useradd` options, setting passwords, modifying users with `usermod`, managing groups using `groupadd/groupmod`, and cleaning up accounts safely using `userdel/groupdel`.

All tasks were executed on a **CentOS/RHEL cloud lab environment** with root privileges via `sudo`.

---

# 🎯 Objectives

By the end of this lab, I was able to:

- Create user accounts using `useradd` with different options (UID, shell, home, comments)
- Set and verify user passwords using `passwd`
- Modify existing user settings using `usermod`
- Create and manage groups using `groupadd` and `groupmod`
- Add/remove users to/from groups and verify memberships (`groups`, `id`, `getent`)
- Delete users and groups safely using `userdel` and `groupdel`
- Understand and validate the structure of:
  - `/etc/passwd`
  - `/etc/group`
  - `/etc/shadow`
- Apply security best practices:
  - account lock/unlock
  - password aging (`chage`)
  - account expiration controls

---

# 🖥️ Lab Environment

- OS: CentOS/RHEL (Cloud VM)
- Shell: Bash 4.2
- Primary User: `centos`
- Privilege Escalation: `sudo su -` (root shell)
- Tools/Commands Used:
  - `useradd`, `usermod`, `userdel`
  - `passwd`, `chage`
  - `groupadd`, `groupmod`, `groupdel`, `gpasswd`
  - `id`, `groups`, `getent`, `grep`
  - `cat`, `head`, `cut`, `sort`
  - `yum` (package installation for `zsh`, `finger`)

---

# 📂 Repository Structure (Lab 03)

```

lab23-managing-users-and-groups/
│
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
├── troubleshooting.md
│
└── notes/
└── redaction_policy.md

```

> 📌 Note: This lab interacts with system databases like `/etc/shadow`. Any sensitive password hashes are **redacted** in documentation to follow security best practices.

---

# 🧩 Tasks Performed (Overview)

## 👤 Task 1 — Create User Accounts (`useradd`)

- Reviewed existing users in `/etc/passwd`
- Switched to root shell (`sudo su -`)
- Created users:
  - `john` (basic)
  - `jane` (custom home with `-m -d`)
  - `mike` (explicit shell)
  - `sarah` (comment/full name)
  - `tom` (custom UID)
  - `alice` (multi-option account creation)
- Verified user creation via `/etc/passwd`, `/home`, and `id`

---

## 🔑 Task 2 — Passwords & User Modifications

- Set passwords (`passwd`) for selected users
- Modified accounts using `usermod`:
  - updated comment (`-c`)
  - moved home directory (`-d -m`)
  - installed `zsh`, updated login shell (`-s`)
  - changed UID (`-u`)
  - locked/unlocked accounts (`-L`, `-U`)
- Verified changes using:
  - `grep /etc/passwd`
  - `passwd -S`
  - `su - john` login test

---

## 👥 Task 3 — Create & Manage Groups

- Created groups:
  - `developers`, `testers`, `managers`
  - `admins` (custom GID)
  - `sysops` (system group)
- Added users to groups using:
  - `usermod -g` (primary)
  - `usermod -G` / `-aG` (secondary/append)
  - `gpasswd -a` and `gpasswd -M`
- Verified group memberships using:
  - `groups`, `id`, `getent group`
- Modified groups using `groupmod`:
  - renamed `developers` → `development`
  - resolved GID conflict by assigning `admins` a new GID

---

## 🧹 Task 4 — Delete Users & Groups Safely

- Removed users from groups (`gpasswd -d`, `usermod -G ""`)
- Deleted users:
  - `userdel tom` (kept home)
  - `userdel -r alice` (removed home)
  - `userdel -f mike` (forced)
- Demonstrated real-world outcomes:
  - leftover home directory when not using `-r`
  - mail spool warnings (common in minimal systems)
- Deleted groups:
  - removed `testers`
  - handled expected failure deleting `development` due to primary group assignment
  - fixed by changing primary group, then deleting group
- Cleaned remaining test users and groups (`john`, `jane`, `sarah`, `managers`, `admins`, `sysops`)

---

## 📘 Advanced Concepts — Core User DB Files

- Reviewed `/etc/passwd` structure (account metadata)
- Reviewed `/etc/group` structure (group memberships)
- Reviewed `/etc/shadow` structure (password hashes)
  - **Hashes redacted** in notes/output for security

---

## 🔐 Security Best Practices Demonstrated

- Password aging controls with `chage`
  - max days, min days, warning window
- Account expiration (`chage -E`)
- Account disable without deletion (`usermod -L -e 1`)
- Verified security status with `passwd -S` and `chage -l`

> ⚠️ Realistic behavior noted: locked status can remain `LK` depending on whether a password is set or the account is expired.

---

# 💡 Real-World Relevance

User/group management is fundamental for:

- Access control and least privilege
- Secure onboarding/offboarding
- Managing service accounts and system users
- Permission models for files/services (ownership, group-based access)
- Compliance and audit readiness in enterprise Linux environments

---

# ✅ Result

Successfully performed complete lifecycle of:

- user creation → password setup → account modification → group assignment
- secure cleanup of users/groups
- verification of system identity databases and security controls

📌 Lab completed on a cloud-based CentOS/RHEL environment with root privileges.
