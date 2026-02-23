# 🧪 Lab 27: Configuring and Securing SSH (OpenSSH)

This lab covers **installing, configuring, hardening, and troubleshooting SSH** on a CentOS/RHEL-style system using `sshd`, firewall rules, logs, and **key-based authentication**.

---

## 🎯 Objectives

By the end of this lab, I can:

- Install/verify **OpenSSH server** (`openssh-server`)
- Manage SSH service with `systemctl` (start/enable/restart)
- Secure `/etc/ssh/sshd_config` using best-practice settings
- Allow SSH through `firewalld`
- Test SSH locally (`localhost`) and remotely (VM-to-VM)
- Generate SSH keys and configure **key-based login**
- Disable password authentication after key auth works
- Monitor SSH access via `journalctl` and `/var/log/secure`
- Troubleshoot common SSH issues (ports, firewall, permissions, auth failures)

---

## 🖥️ Lab Environment

- OS style: **CentOS/RHEL-like**
- SSH daemon: **sshd**
- Firewall: **firewalld / firewall-cmd**
- Two machines used for realism:
  - **VM1** = SSH Server
  - **VM2** = SSH Client

> Note: This environment uses `yum` (compatible with the lab steps where `dnf` is mentioned).

---

## ✅ What I Configured & Verified

### 1) SSH Installed + Service Healthy
- Verified package: `rpm -qa | grep openssh-server`
- Verified service: `systemctl status sshd`
- Enabled at boot: `systemctl enable sshd`

### 2) Hardened `sshd_config`
Key security lines applied and verified:

- `PermitRootLogin no`
- `PubkeyAuthentication yes`
- `PasswordAuthentication yes` *(initially, for testing)*
- `PermitEmptyPasswords no`
- `MaxAuthTries 3`
- `ClientAliveInterval 300`
- `ClientAliveCountMax 2`

Validated config syntax:

- `sshd -t`

Restarted daemon to apply:

- `systemctl restart sshd`

### 3) Firewall Allowed SSH
- `firewall-cmd --permanent --add-service=ssh`
- (Demonstrated) `firewall-cmd --permanent --add-port=22/tcp`
- `firewall-cmd --reload`
- Verified: `firewall-cmd --list-services`

### 4) Tested SSH (Local + Remote)
- Local test: `ssh testuser@localhost`
- Remote test from VM2: `ssh testuser@<server-ip>`
- Debug test: `ssh -v testuser@<server-ip>`

### 5) Implemented Key-Based Authentication
On client (VM2):
- `ssh-keygen -t rsa -b 4096 -C "your_email@example.com"`

Copied key to server:
- `ssh-copy-id testuser@<server-ip>`

Fixed permissions:
- `chmod 700 ~/.ssh`
- `chmod 600 ~/.ssh/authorized_keys`

Verified login worked **without password prompt**.

### 6) Disabled Password Authentication
After confirming key auth:
- Set `PasswordAuthentication no`
- `sshd -t`
- `systemctl restart sshd`

Confirmed password auth blocked:
- `ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no ...`

### 7) Extra SSH Hardening
Added/verified:

- `Protocol 2`
- `AllowUsers testuser`
- `X11Forwarding no`
- `AllowAgentForwarding no`
- `AllowTcpForwarding no`
- `Ciphers aes256-ctr,aes192-ctr,aes128-ctr`
- `MACs hmac-sha2-256,hmac-sha2-512`
- `LoginGraceTime 30`

---

## 📂 Repo Files for This Lab

- `commands.sh` → all commands used (server + client)
- `output.txt` → terminal outputs captured
- `interview_qna.md` → SSH + hardening interview questions
- `troubleshooting.md` → common SSH issues + fixes

---

## 🔎 Quick Verification Commands

```bash
sudo systemctl status sshd
sudo sshd -t
sudo ss -tuln | grep :22
sudo firewall-cmd --list-services
sudo journalctl -u sshd -n 30
sudo tail -n 30 /var/log/secure
````

---

## ✅ Result

SSH was configured securely with:

* **Root login disabled**
* **Key-based authentication enabled**
* **Password authentication disabled**
* Firewall rules applied
* Access limited using `AllowUsers`
* Logs monitored and validated for both password + key flows
