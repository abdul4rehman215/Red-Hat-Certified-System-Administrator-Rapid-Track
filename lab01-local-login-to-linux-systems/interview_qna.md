# 🎓 Interview Q&A – Lab 01: Local Login to Linux Systems

---

## 1️⃣ What is a TTY in Linux?

A TTY (Teletype Terminal) represents a terminal session in Linux. It allows users to interact with the system through a command-line interface. Linux systems typically provide multiple virtual terminals (tty1–tty6 by default).

---

## 2️⃣ How do you switch between virtual terminals?

You can switch between virtual terminals using:

Ctrl + Alt + F1–F6

Each function key corresponds to a different TTY session.

---

## 3️⃣ What command identifies the current active terminal?

The command:

```bash
tty
````

It displays the terminal device file currently in use, such as:

```
/dev/tty2
```

---

## 4️⃣ What does the `who` command display?

The `who` command lists:

* Logged-in users
* Terminal session (TTY)
* Login time

It helps administrators monitor active user sessions.

---

## 5️⃣ What is the difference between `who` and `w`?

* `who` shows basic login session information.
* `w` shows additional details like system uptime, load average, and what each user is currently doing.

---

## 6️⃣ What happens after successful authentication?

After successful login:

* The system starts a user shell (e.g., bash)
* The user lands in their home directory
* A shell prompt appears

Example:

```
[user1@localhost ~]$
```

---

## 7️⃣ Why is it recommended to log in as a non-root user?

Logging in as a non-root user:

* Reduces security risks
* Prevents accidental system modifications
* Enforces the principle of least privilege

Administrative tasks should be performed using `sudo` when necessary.

---

## 8️⃣ What file manages local user accounts in Linux?

Local user account information is stored in:

```
/etc/passwd
```

Passwords are securely stored (hashed) in:

```
/etc/shadow
```

---

## 9️⃣ How many virtual terminals are available by default?

Most Linux distributions provide:

* tty1 through tty6 (text consoles)
* tty7 may be used for graphical interface

The number can vary depending on configuration.

---

## 🔟 What is the purpose of the login prompt?

The login prompt ensures:

* Authentication before system access
* User identity verification
* Secure multi-user system operation

It prevents unauthorized access.

---

## 1️⃣1️⃣ What happens if you switch TTY without logging out?

Switching TTY does not terminate sessions. Each terminal remains active independently until explicitly logged out.

---

## 1️⃣2️⃣ How can an administrator monitor login activity?

Administrators can use:

```bash
who
w
last
```

These commands help track login history and active sessions.

---

## 1️⃣3️⃣ Why are virtual terminals important in server environments?

Virtual terminals are critical because:

* Many servers operate without GUI
* They allow multiple concurrent sessions
* They enable troubleshooting when graphical environments fail

---

## 1️⃣4️⃣ What is displayed in the shell prompt?

Typical shell prompt components:

* Username
* Hostname
* Current working directory
* Privilege level ($ for user, # for root)

Example:

```
[user1@localhost ~]$
```

---

## 1️⃣5️⃣ What is the role of PAM in Linux login?

PAM (Pluggable Authentication Modules):

* Handles authentication policies
* Manages password verification
* Enforces security rules like account lockout

It controls how login authentication is processed.

---

🟥 RHCSA Focus:
Understanding local login, TTY management, and user session monitoring is foundational for Red Hat system administration and troubleshooting tasks.
