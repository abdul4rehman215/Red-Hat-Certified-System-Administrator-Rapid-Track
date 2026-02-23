# 🛠️ Troubleshooting Guide – Lab 01: Local Login to Linux Systems

---

## 🔎 Overview

This document outlines common issues encountered during local login and virtual terminal usage in a Linux (RHEL/CentOS-based) environment, along with their causes, resolutions, and preventive measures.

---

# 1️⃣ Problem: Login Fails with “Login incorrect”

### 📌 Symptoms
- After entering username and password, system returns:
  
```

Login incorrect

````

### 🧠 Possible Causes
- Incorrect username
- Incorrect password
- Caps Lock enabled
- Account locked
- Expired password

### ✅ Resolution
1. Re-enter username carefully.
2. Ensure correct password (Linux passwords are case-sensitive).
3. Check if Caps Lock is enabled.
4. If still failing, switch to root or administrator account and verify:
 
 ```bash
 sudo passwd user1
````

5. Check account lock status:

   ```bash
   sudo faillog -u user1
   ```

### 🔐 Prevention

* Use strong but memorable passwords.
* Avoid repeated incorrect attempts.
* Monitor account lock policies.

---

# 2️⃣ Problem: Unable to Switch Virtual Terminals

### 📌 Symptoms

* Pressing Ctrl + Alt + F2–F6 does nothing.
* System remains on graphical interface.

### 🧠 Possible Causes

* Keyboard shortcut conflict
* VM capture issue (VirtualBox/VMware)
* Minimal Linux environment without multiple TTY enabled
* Incorrect function key mapping

### ✅ Resolution

1. Ensure VM window is active.

2. Try Host key + F2 (for some virtualization platforms).

3. Check if getty services are running:

   ```bash
   systemctl status getty@tty2.service
   ```

4. Start TTY manually if required:

   ```bash
   sudo systemctl start getty@tty2.service
   ```

### 🔐 Prevention

* Verify TTY services are enabled:

  ```bash
  sudo systemctl enable getty@tty2.service
  ```

---

# 3️⃣ Problem: `tty` Command Returns Unexpected Terminal

### 📌 Symptoms

* Output shows different tty than expected.
* Example:

  ```
  /dev/pts/0
  ```

### 🧠 Possible Causes

* Logged in via SSH (pseudo-terminal)
* Not using physical console

### ✅ Resolution

* Confirm login method.

* For physical console, expected format:

  ```
  /dev/tty2
  ```

* For SSH, it will show:

  ```
  /dev/pts/X
  ```

### 🔐 Prevention

* Always verify connection type before troubleshooting.

---

# 4️⃣ Problem: `who` Does Not Show Expected Sessions

### 📌 Symptoms

* `who` shows fewer sessions than expected.
* No output displayed.

### 🧠 Possible Causes

* User logged out from other TTY.
* System recently rebooted.
* utmp file corrupted.

### ✅ Resolution

1. Verify sessions with:

   ```bash
   w
   ```

2. Check login history:

   ```bash
   last
   ```

3. Restart login services if necessary:

   ```bash
   sudo systemctl restart systemd-logind
   ```

### 🔐 Prevention

* Avoid improper shutdowns.
* Monitor system logs:

  ```bash
  sudo journalctl -xe
  ```

---

# 5️⃣ Problem: System Boots to Blank Screen

### 📌 Symptoms

* No login prompt visible.
* Black screen after boot.

### 🧠 Possible Causes

* Boot target misconfigured
* Graphical service failure
* Kernel boot issue

### ✅ Resolution

1. Switch to multi-user target:

   ```bash
   sudo systemctl set-default multi-user.target
   sudo reboot
   ```

2. Check default target:

   ```bash
   systemctl get-default
   ```

3. Review boot logs:

   ```bash
   journalctl -b
   ```

### 🔐 Prevention

* Avoid improper kernel updates.
* Monitor boot configurations.
* Maintain stable system packages.

---

# 6️⃣ Problem: Account Locked After Multiple Attempts

### 📌 Symptoms

* Login denied even with correct password.
* PAM lockout policy triggered.

### 🧠 Possible Causes

* Too many failed login attempts.
* Security policy enforced.

### ✅ Resolution

1. Unlock account (as root):

   ```bash
   sudo faillog -r -u user1
   ```

2. Review PAM configuration:

   ```bash
   cat /etc/pam.d/system-auth
   ```

### 🔐 Prevention

* Avoid brute-force attempts.
* Configure reasonable lockout thresholds.

---

# 🧾 Diagnostic Commands Summary

```bash
tty
who
w
last
systemctl status getty@tty2.service
journalctl -xe
```

---

# 🧠 Key Takeaways

* Virtual terminals must be active and running.
* Login authentication depends on PAM.
* Multiple sessions operate independently.
* Proper system monitoring prevents authentication issues.
* Understanding TTY vs PTS is critical in RHCSA environments.

---

🟥 RHCSA Focus:
Troubleshooting login and terminal issues is essential for system recovery, user management, and maintaining secure server access in enterprise Red Hat environments.
