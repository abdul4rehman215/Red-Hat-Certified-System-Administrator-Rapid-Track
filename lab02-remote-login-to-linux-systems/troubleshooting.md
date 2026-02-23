# 🛠️ Troubleshooting Guide – Lab 02: Remote Login to Linux Systems (SSH)

---

## 🔎 Overview

This document outlines common issues encountered during SSH setup, key-based authentication, and remote login configuration between Ubuntu (client) and CentOS (server), along with causes, resolutions, and preventive measures.

---

# 1️⃣ Problem: `ssh: connect to host ... port 22: Connection refused`

### 📌 Symptoms
```bash
ssh: connect to host 172.31.10.88 port 22: Connection refused
````

### 🧠 Possible Causes

* SSH service (`sshd`) not running
* SSH server not installed
* Firewall blocking port 22
* Wrong IP address

### ✅ Resolution

1. Verify SSH service status on remote server:

```bash
sudo systemctl status sshd
```

2. Start SSH service if stopped:

```bash
sudo systemctl start sshd
```

3. Enable SSH service at boot:

```bash
sudo systemctl enable sshd
```

4. Check firewall rules:

```bash
sudo firewall-cmd --list-all
```

5. Allow SSH through firewall:

```bash
sudo firewall-cmd --add-service=ssh --permanent
sudo firewall-cmd --reload
```

### 🔐 Prevention

* Always enable `sshd` after installation
* Confirm firewall configuration during server setup
* Verify correct remote IP address

---

# 2️⃣ Problem: `Permission denied (publickey)`

### 📌 Symptoms

```bash
Permission denied (publickey).
```

### 🧠 Possible Causes

* Public key not copied correctly
* Incorrect permissions on `.ssh` directory
* `authorized_keys` missing
* Password authentication disabled before key setup

### ✅ Resolution

1. Verify public key exists on server:

```bash
cat ~/.ssh/authorized_keys
```

2. Fix permissions:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

3. Temporarily enable password authentication if locked out:

Edit `/etc/ssh/sshd_config`:

```bash
PasswordAuthentication yes
```

Restart SSH:

```bash
sudo systemctl restart sshd
```

Then re-copy key:

```bash
ssh-copy-id student@172.31.10.88
```

### 🔐 Prevention

* Copy keys before disabling password authentication
* Maintain correct file permissions
* Test SSH login before hardening

---

# 3️⃣ Problem: SSH Hangs / Times Out

### 📌 Symptoms

```bash
ssh: connect to host 172.31.10.88 port 22: Operation timed out
```

### 🧠 Possible Causes

* Firewall blocking port 22
* Security group (cloud firewall) not configured
* Network routing issue
* SSH running on different port

### ✅ Resolution

1. Verify firewall configuration:

```bash
sudo firewall-cmd --list-services
```

2. Check cloud security group (if EC2-style setup)
3. Confirm SSH is listening:

```bash
sudo ss -tlnp | grep ssh
```

4. Check SSH port in configuration:

```bash
sudo grep Port /etc/ssh/sshd_config
```

### 🔐 Prevention

* Always open port 22 in firewall/security group
* Verify network connectivity before troubleshooting SSH

---

# 4️⃣ Problem: `ssh-keygen: command not found`

### 📌 Symptoms

```bash
ssh-keygen: command not found
```

### 🧠 Possible Causes

* OpenSSH client not installed

### ✅ Resolution

On Ubuntu:

```bash
sudo apt install openssh-client -y
```

On CentOS:

```bash
sudo yum install openssh-clients -y
```

### 🔐 Prevention

* Install SSH client tools during initial system setup

---

# 5️⃣ Problem: SSH Fails After Editing `sshd_config`

### 📌 Symptoms

* SSH service fails to start
* Configuration errors
* Service inactive

### 🧠 Possible Causes

* Syntax error in `/etc/ssh/sshd_config`
* Incorrect directive spelling
* Misconfigured authentication settings

### ✅ Resolution

1. Validate configuration:

```bash
sudo sshd -t
```

If error appears, fix syntax.

2. Restart SSH service:

```bash
sudo systemctl restart sshd
```

3. Check service status:

```bash
sudo systemctl status sshd
```

### 🔐 Prevention

* Always validate configuration before restarting
* Keep a backup of original config:

```bash
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
```

---

# 6️⃣ Problem: SSH Denied Due to Incorrect Permissions

### 📌 Symptoms

```bash
Bad ownership or modes for directory /home/student/.ssh
```

### 🧠 Possible Causes

* `.ssh` directory too permissive
* `authorized_keys` file wrong permissions

### ✅ Resolution

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
chown -R student:student ~/.ssh
```

Restart SSH:

```bash
sudo systemctl restart sshd
```

### 🔐 Prevention

* Always enforce strict SSH permissions
* Avoid using `chmod 777` on sensitive directories

---

# 7️⃣ Problem: Root Login Still Allowed

### 📌 Symptoms

* Able to SSH as root

### 🧠 Possible Causes

* `PermitRootLogin` still set to `yes`
* SSH service not restarted

### ✅ Resolution

Edit:

```bash
sudo nano /etc/ssh/sshd_config
```

Set:

```bash
PermitRootLogin no
```

Restart:

```bash
sudo systemctl restart sshd
```

Verify:

```bash
sudo grep PermitRootLogin /etc/ssh/sshd_config
```

### 🔐 Prevention

* Disable root login immediately after server setup
* Enforce least privilege access

---

# 🧾 Diagnostic Commands Summary

```bash
systemctl status sshd
ss -tlnp | grep ssh
firewall-cmd --list-all
sshd -t
journalctl -xe
```

---

# 🧠 Key Takeaways

* SSH must be running and enabled.
* Key permissions are critical for authentication.
* Firewall configuration directly impacts connectivity.
* Always validate `sshd_config` before restarting.
* Disable password and root login only after confirming key-based access works.

---

🟥 RHCSA Focus:
Troubleshooting SSH access is a core administrative skill required for managing secure Linux servers in enterprise and cloud environments.

