# 🌐 Lab 02 – Remote Login to Linux Systems (SSH)

## 🎯 Objective

This lab demonstrates how to securely access a remote Linux system using SSH with key-based authentication.

By completing this lab, I achieved the ability to:

- Generate a 4096-bit RSA SSH key pair
- Install and configure an SSH server on a remote CentOS system
- Copy public keys securely to a remote machine
- Harden SSH configuration (disable password and root login)
- Establish a secure key-based remote connection
- Verify authentication and remote system identity

This lab builds foundational RHCSA-level remote administration and SSH security skills.

---

## 🧪 Lab Simulation Architecture

This lab simulates a real-world client-server environment:

- 🖥️ Local Machine (Client): Ubuntu 24.04.1 LTS
- 🌐 Remote Server: CentOS Linux 7 (EC2-style instance)

---

## 🖥️ Local Machine Details

| Component | Value |
|------------|--------|
| OS | Ubuntu 24.04.1 LTS |
| Username | toor |
| IP Address | 172.31.10.201 |
| Role | SSH Client |

---

## 📂 Repository Structure

lab02-remote-login-to-linux-systems/
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
└── troubleshooting.md

---

## 🌐 Remote Server Details

| Component | Value |
|------------|--------|
| OS | CentOS Linux 7 (Core) |
| Username | student |
| IP Address | 172.31.10.88 |
| Kernel | 3.10.0-1160.el7.x86_64 |
| Role | SSH Server |

---

# 🧩 Task Overview & Execution Summary

---

## 🔹 Task 1 – Generate SSH Key Pair (Local Machine)

### ✔ Checked for Existing SSH Keys

Verified that no `.ssh` directory existed in the user’s home directory.

### ✔ Generated a New 4096-bit RSA Key Pair

Used:

- RSA algorithm
- 4096-bit key size
- Comment: student@lab.local
- Passphrase protected private key

Keys generated:

- `~/.ssh/id_rsa` → Private key
- `~/.ssh/id_rsa.pub` → Public key

---

## 🔹 Task 2 – Configure SSH Server on Remote Machine

### ✔ Installed OpenSSH Server

Installed using `yum` package manager.

### ✔ Started and Enabled SSH Service

- Started `sshd`
- Enabled service at boot

Verified systemd symlink creation.

---

## 🔹 Task 3 – Copy Public Key to Remote Server

From the local machine:

- Used `ssh-copy-id`
- Verified host fingerprint
- Authenticated once using password
- Public key added to `authorized_keys`

---

## 🔐 SSH Hardening Configuration

Edited:

```

/etc/ssh/sshd_config

```

Updated security settings:

- `PasswordAuthentication no`
- `PermitRootLogin no`
- `PubkeyAuthentication yes`

Restarted SSH service to apply changes.

Adjusted permissions:

- `chmod 700 ~/.ssh`
- `chmod 600 ~/.ssh/authorized_keys`

---

## 🔹 Task 4 – Test Secure SSH Login

From local system:

- Connected using SSH
- Only key passphrase required
- No password prompt for remote user

Verified:

- `whoami`
- `hostname`

Connection successful.

---

# 📊 Result

- Secure SSH key pair generated
- SSH server installed and configured
- Password-based authentication disabled
- Root login disabled
- Secure key-based authentication established
- Verified remote identity and session

All tasks completed successfully.

---

# 🧠 What I Learned

- SSH uses asymmetric cryptography for secure authentication
- Private keys must remain confidential
- Public keys are stored in `authorized_keys`
- SSH server configuration is controlled via `sshd_config`
- Disabling password authentication reduces brute-force risk
- Proper permissions are critical for SSH to function securely
- Firewall rules may block SSH if not configured properly

---

# 🛡️ Why This Matters

SSH is the backbone of:

- Remote Linux administration
- Cloud server management
- DevOps automation
- Secure file transfer (SCP/SFTP)
- Infrastructure as Code workflows

Securing SSH access is critical in production environments.

---

# 🌍 Real-World Applications

- Managing cloud instances (AWS EC2, Azure VM, GCP)
- Secure remote access to enterprise servers
- CI/CD deployment pipelines
- Infrastructure management via Ansible
- Secure DevOps practices

---

# 🔎 Real-World Relevance

In enterprise environments:

- Password-based SSH is often disabled
- Root login is prohibited
- Key-based authentication is mandatory
- Firewall rules restrict port 22 access
- SSH logs are monitored for intrusion detection

This lab replicates real-world secure SSH configuration standards.

---

# ✅ Conclusion

In this lab, I:

✔ Generated a secure 4096-bit RSA SSH key pair  
✔ Installed and configured OpenSSH server  
✔ Copied public key securely to remote host  
✔ Hardened SSH configuration  
✔ Disabled password and root login  
✔ Successfully established secure remote access  

This lab strengthened my RHCSA-level remote administration and Linux security configuration skills.

---

📌 Lab Status: Completed Successfully  
🟥 Track: RHCSA Rapid Track  
