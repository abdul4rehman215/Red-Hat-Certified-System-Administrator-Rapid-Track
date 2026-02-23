# 🎓 Interview Q&A – Lab 02: Remote Login to Linux Systems (SSH)

---

## 1️⃣ What is SSH and why is it used?

SSH (Secure Shell) is a cryptographic network protocol used to securely access and manage remote systems over an unsecured network. It encrypts communication between client and server, preventing eavesdropping and man-in-the-middle attacks.

---

## 2️⃣ What port does SSH use by default?

SSH uses **TCP port 22** by default.

It can be changed in the SSH configuration file:

```bash
/etc/ssh/sshd_config
````

---

## 3️⃣ What is the difference between SSH key-based authentication and password authentication?

| Key-Based Authentication         | Password Authentication        |
| -------------------------------- | ------------------------------ |
| Uses asymmetric cryptography     | Uses plaintext password        |
| More secure                      | Vulnerable to brute-force      |
| Requires private/public key pair | Requires user password         |
| Recommended for servers          | Not recommended for production |

---

## 4️⃣ Where are SSH private and public keys stored?

On the client machine:

```bash
~/.ssh/id_rsa       # Private key
~/.ssh/id_rsa.pub   # Public key
```

Private key must never be shared.

---

## 5️⃣ Where is the public key stored on the remote server?

On the remote server, the public key is stored in:

```bash
~/.ssh/authorized_keys
```

This file contains all allowed public keys for login.

---

## 6️⃣ What are the correct permissions for SSH directories and files?

For security, permissions must be:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

If permissions are too open, SSH will refuse authentication.

---

## 7️⃣ How do you disable root login via SSH?

Edit:

```bash
sudo nano /etc/ssh/sshd_config
```

Set:

```bash
PermitRootLogin no
```

Then restart SSH:

```bash
sudo systemctl restart sshd
```

---

## 8️⃣ How do you disable password authentication?

In `sshd_config`, set:

```bash
PasswordAuthentication no
```

This forces key-based authentication.

---

## 9️⃣ How do you check if SSH service is running?

```bash
sudo systemctl status sshd
```

To start:

```bash
sudo systemctl start sshd
```

To enable at boot:

```bash
sudo systemctl enable sshd
```

---

## 🔟 What command is used to copy a public key to a remote server?

```bash
ssh-copy-id user@remote_ip
```

This automatically appends the public key to the remote `authorized_keys` file.

---

## 1️⃣1️⃣ What is the purpose of the `ssh-keygen` command?

`ssh-keygen` generates a public/private key pair for secure authentication.

Example:

```bash
ssh-keygen -t rsa -b 4096 -C "comment"
```

* `-t rsa` → RSA algorithm
* `-b 4096` → 4096-bit key
* `-C` → Comment

---

## 1️⃣2️⃣ How can you verify the identity of a remote server during first connection?

When connecting for the first time, SSH shows a fingerprint:

```
ECDSA key fingerprint is SHA256:...
```

You must verify it matches the expected server fingerprint to prevent MITM attacks.

---

## 1️⃣3️⃣ What file stores SSH server configuration?

```bash
/etc/ssh/sshd_config
```

Changes require restarting the SSH service.

---

## 1️⃣4️⃣ What happens if port 22 is blocked by firewall?

SSH connection will fail with:

```
Connection refused
```

or

```
Connection timed out
```

To allow SSH:

```bash
sudo firewall-cmd --add-service=ssh --permanent
sudo firewall-cmd --reload
```

---

## 1️⃣5️⃣ Why is SSH security critical in cloud environments?

Because:

* Cloud servers are exposed to the internet
* Port 22 is frequently scanned by attackers
* Weak SSH configs can lead to full system compromise
* Key-based authentication reduces brute-force risks
* Root login must be disabled to reduce attack surface

---

🟥 RHCSA Focus:
Secure SSH configuration and key-based authentication are mandatory skills for Red Hat system administration and enterprise Linux security operations.
