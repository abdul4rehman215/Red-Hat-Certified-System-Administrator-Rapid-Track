# 🧪 Lab 10: Managing Special Permission Bits

---

## 🎯 Objectives

By completing this lab, I will:

- 📌 Apply the **Sticky Bit** on shared directories
- 🔐 Configure **setuid** on executables
- 👥 Configure **setgid** on executables
- 🧪 Verify special permission behavior in Linux

---

## 🖥️ Lab Environment

| Component | Value |
|------------|--------|
| OS | Ubuntu 24.04.1 LTS |
| User | toor |
| Host | ip-172-31-10-266 |
| Shell | Bash |

Prompt used:

```

toor@ip-172-31-10-266:~$

```

---

## 📂 Repository Structure

```

lab10-managing-special-permission-bits/
│
├── README.md
├── commands.sh
├── scripts/
│   └── show_euid
├── output.txt
├── interview_qna.md
└── troubleshooting.md

```

---

# 🧩 Task Overview

---

## 🔹 Task 1: Sticky Bit on Shared Directory

- Created `/tmp/shared_dir`
- Applied full access (777)
- Enabled sticky bit using `chmod +t`
- Verified `t` in permission string
- Confirmed that non-owners cannot delete others’ files

---

## 🔹 Task 2: setuid on Executable

- Created executable script `show_euid`
- Assigned root ownership
- Applied setuid (`chmod u+s`)
- Verified execution with effective UID = 0
- Confirmed privilege elevation behavior

---

## 🔹 Task 3: setgid on Executable

- Created new group
- Changed group ownership
- Applied setgid (`chmod g+s`)
- Verified group-based execution control

---

# 🔐 Security Relevance

Special permission bits are critical in multi-user systems.

### Sticky Bit
Prevents unauthorized file deletion in shared directories.

Used in:
```

/tmp

```

### setuid
Allows execution with file owner privileges.

Example:
```

/usr/bin/passwd

````

### setgid
Enforces group-based execution context.

Common in shared project directories.

---

# 🏢 Enterprise Application

These permissions are used in:

- RHEL production systems
- Multi-user servers
- Shared development environments
- Container runtime environments
- OpenShift volume permissions
- Controlled privilege escalation tools

---

# ⚠ Security Warning

Improper use of setuid can lead to:

- Privilege escalation vulnerabilities
- Root compromise
- Exploitable binaries

Always audit setuid files:

```bash
find / -perm -4000 2>/dev/null
````

---

# 📈 Results

✔ Sticky bit enforced directory protection
✔ setuid elevated privileges correctly
✔ setgid applied group execution control
✔ Verified permission bits numerically (4755)

---

# 🧠 What I Learned

* Sticky bit restricts deletion rights
* setuid executes with file owner's privileges
* setgid enforces group-based execution
* Permission string shows special bits as `s` or `t`
* `stat` command reveals numeric permission values
* Mount options like `nosuid` affect behavior

---

# 🏁 Conclusion

Special permission bits provide controlled privilege mechanisms in Linux.

Understanding:

* Sticky bit
* setuid
* setgid

Is essential for:

* Secure system administration
* RHCSA certification
* Enterprise Linux security

---

🔴 RHCSA Focus:
Special permission bits, privilege control, sticky directories.
