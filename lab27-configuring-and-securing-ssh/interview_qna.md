# 🎤 Interview Q&A — Lab 27: Configuring and Securing SSH

> This section covers important SSH concepts frequently asked in RHCSA, Linux admin, and security interviews.

---

## 1️⃣ What is SSH and why is it important?

SSH (Secure Shell) is a cryptographic network protocol used for secure remote login and command execution over an unsecured network.

It provides:
- Encrypted communication
- Secure authentication
- Protection against eavesdropping and man-in-the-middle attacks

SSH is the primary method for remote Linux system administration.

---

## 2️⃣ What service manages SSH on RHEL/CentOS systems?

The SSH daemon:

```

sshd

```

Managed via:

```

systemctl start|stop|restart|status sshd

```

---

## 3️⃣ Where is the SSH server configuration file located?

```

/etc/ssh/sshd_config

```

After modifying it, always validate:

```

sshd -t

```

Then restart:

```

systemctl restart sshd

```

---

## 4️⃣ How do you disable root login over SSH?

In `/etc/ssh/sshd_config`:

```

PermitRootLogin no

```

This prevents attackers from targeting the root account directly.

---

## 5️⃣ Why is key-based authentication more secure than passwords?

Key-based authentication:

- Uses asymmetric cryptography
- Cannot be brute-forced easily
- Eliminates password guessing attacks
- Allows disabling password authentication entirely

---

## 6️⃣ How do you generate an SSH key pair?

On the client machine:

```

ssh-keygen -t rsa -b 4096

```

This creates:

- `~/.ssh/id_rsa` (private key)
- `~/.ssh/id_rsa.pub` (public key)

---

## 7️⃣ How do you copy a public key to a server?

```

ssh-copy-id user@server-ip

```

It appends the key to:

```

~/.ssh/authorized_keys

```

---

## 8️⃣ What are the correct permissions for SSH keys?

On the client:

```

~/.ssh           → 700
id_rsa           → 600
id_rsa.pub       → 644

```

On the server:

```

~/.ssh           → 700
authorized_keys  → 600

```

Incorrect permissions cause authentication failure.

---

## 9️⃣ How do you disable password authentication?

In `/etc/ssh/sshd_config`:

```

PasswordAuthentication no

```

Then:

```

sshd -t
systemctl restart sshd

```

---

## 🔟 How do you restrict SSH access to specific users?

Use:

```

AllowUsers username

```

Example:

```

AllowUsers testuser

```

Only listed users can log in via SSH.

---

## 1️⃣1️⃣ How do you change the default SSH port?

In `sshd_config`:

```

Port 2222

```

Then update firewall:

```

firewall-cmd --permanent --add-port=2222/tcp
firewall-cmd --reload

```

---

## 1️⃣2️⃣ How do you troubleshoot SSH connection refused?

Check:

```

systemctl status sshd
ss -tuln | grep :22
firewall-cmd --list-services

```

If SSH isn’t listening, service may be stopped.

---

## 1️⃣3️⃣ Where are SSH login attempts logged?

On RHEL/CentOS:

```

/var/log/secure

```

Or:

```

journalctl -u sshd

```

---

## 1️⃣4️⃣ What does this error mean?
```

Permission denied (publickey)

```

Possible causes:

- Public key not copied correctly
- Wrong permissions on `.ssh`
- Incorrect ownership
- PasswordAuthentication disabled but key missing

---

## 1️⃣5️⃣ What are common SSH hardening practices?

- Disable root login
- Disable password authentication
- Use strong ciphers
- Restrict users with AllowUsers
- Set MaxAuthTries
- Set LoginGraceTime
- Use firewall restrictions
- Monitor logs regularly

---

# 🎯 RHCSA Relevance

SSH configuration is directly tested in RHCSA:

- Editing `sshd_config`
- Managing firewall rules
- Creating users
- Testing remote access
- Troubleshooting authentication failures

Understanding SSH deeply is critical for Linux system administrators.

---
