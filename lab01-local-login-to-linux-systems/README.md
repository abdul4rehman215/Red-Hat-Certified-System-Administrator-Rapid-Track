# 🧪 Lab 01 – Local Login to Linux Systems

## 🎯 Objective

This lab focuses on understanding how to locally access and authenticate into a Linux system using virtual terminals.

By completing this lab, I achieved the ability to:

- Access a Linux system via physical or virtual console
- Log in using a non-root user account
- Navigate and switch between multiple virtual terminals (tty)
- Identify active sessions and current terminal
- Verify logged-in users

This lab reinforces fundamental RHCSA-level system access and terminal management skills.

---

## 📋 Prerequisites

Before performing this lab, the following were required:

- A Linux distribution (CentOS 7 used in this lab)
- Physical or virtual machine access
- A configured non-root user account
- Basic command-line familiarity

---

## 🖥️ Lab Environment

| Component | Details |
|------------|----------|
| OS | CentOS Linux 7 (Core) |
| Kernel | 3.10.0-1160.el7.x86_64 |
| Architecture | x86_64 |
| Hostname | localhost |
| Access Method | Local Console (TTY) |
| User Account | user1 (non-root) |

---

## 📂 Repository Structure

lab01-local-login-to-linux-systems/
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
└── troubleshooting.md

---

# 🧩 Task Overview & Execution Summary

---

## 🔹 Task 1: Access the Linux System Physically

### Subtask 1.1 – Power On System

The system was powered on using a virtual machine.

Upon successful boot:

- Login services started
- Login prompt was reached

This confirms the system reached multi-user target successfully.

---

### Subtask 1.2 – Reach Login Prompt

After booting:

- A login prompt appeared
- Switched from graphical interface to text-based console using:

Ctrl + Alt + F2

This opened virtual terminal **tty2**.

---

## 🔹 Task 2: Log In Using Username and Password

### Subtask 2.1 – Enter Username

Entered non-root username:

```

user1

```

### Subtask 2.2 – Enter Password

Password entered successfully.

Upon authentication:

- Shell prompt appeared
- Last login timestamp displayed
- User landed in home directory

Prompt format:

```

[user1@localhost ~]$

```

This confirms successful local authentication.

---

## 🔹 Task 3: Explore Virtual Terminals

---

### Subtask 3.1 – Switch Between Virtual Terminals

Switched to:

- tty3 → Ctrl + Alt + F3
- Logged in again
- Returned to tty2 → Ctrl + Alt + F2

This demonstrates multi-session capability on a single Linux machine.

---

### Subtask 3.2 – Check Active Terminal

Executed:

```

tty

```

Output confirmed current active terminal:

```

/dev/tty2

```

---

### Subtask 3.3 – List Logged-In Users

Executed:

```

who

```

This displayed multiple active sessions across tty2 and tty3.

---

# 📊 Result

- Successful local system login
- Verified terminal switching functionality
- Confirmed multiple concurrent sessions
- Identified active TTY session
- Validated user login sessions

All tasks completed successfully.

---

# 🧠 What I Learned

- Linux supports multiple concurrent virtual terminals
- Each terminal operates independently
- Local authentication occurs before shell access
- The `tty` command identifies current session
- The `who` command lists active user sessions
- Switching between tty sessions does not terminate existing sessions

---

# 🛡️ Why This Matters

Local login and terminal management are foundational system administration skills.

Understanding virtual terminals is critical for:

- Troubleshooting systems without GUI
- Server management in headless environments
- Emergency access when graphical interface fails
- Multi-user system administration

These are core competencies expected in RHCSA environments.

---

# 🌍 Real-World Applications

- Managing Linux servers in data centers
- Accessing systems in recovery mode
- Debugging boot issues
- Handling multiple administrative sessions
- Monitoring concurrent logins

---

# 🔎 Real-World Relevance

In enterprise environments:

- Servers often run without graphical interfaces
- Administrators rely on TTY consoles
- Security teams monitor active login sessions
- Virtual terminals allow parallel administrative work

This lab builds foundational Linux access competency required for production systems.

---

# ✅ Conclusion

In this lab, I:

✔ Logged into a Linux system via console  
✔ Switched between virtual terminals  
✔ Verified active TTY sessions  
✔ Identified logged-in users  
✔ Confirmed system multi-session capability  

This lab strengthened my understanding of Linux authentication flow and terminal management in a Red Hat-based environment.

---

📌 Lab Status: Completed Successfully  
🟥 Track: RHCSA Rapid Track  
```
