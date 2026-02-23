# 🛠️ Troubleshooting Guide — Lab 27: Configuring and Securing SSH

> This document covers common SSH issues, real-world error messages, and step-by-step fixes.

---

# 1️⃣ Connection Refused

## ❌ Error
```

ssh: connect to host 172.31.18.204 port 22: Connection refused

```

## 🔎 Possible Causes
- sshd service not running
- Wrong port
- Firewall blocking SSH
- Incorrect IP address

## ✅ Troubleshooting Steps

Check service:
```

sudo systemctl status sshd

```

Start service:
```

sudo systemctl start sshd

```

Check listening ports:
```

sudo ss -tuln | grep :22

```

Check firewall:
```

sudo firewall-cmd --list-services
sudo firewall-cmd --list-ports

```

---

# 2️⃣ Permission Denied (Password)

## ❌ Error
```

Permission denied (password).

```

## 🔎 Causes
- Wrong password
- PasswordAuthentication disabled
- User does not exist
- User locked

## ✅ Fix

Verify user:
```

id testuser

```

Reset password:
```

sudo passwd testuser

```

Check sshd_config:
```

grep PasswordAuthentication /etc/ssh/sshd_config

```

---

# 3️⃣ Permission Denied (Publickey)

## ❌ Error
```

Permission denied (publickey).

```

## 🔎 Causes
- Key not copied
- Wrong permissions
- Incorrect ownership
- Wrong private key used

## ✅ Fix

Check permissions (client):
```

ls -la ~/.ssh/

```

Should be:
- `.ssh` → 700
- `id_rsa` → 600

Check server:
```

sudo -u testuser ls -la /home/testuser/.ssh/

```

Fix permissions:
```

chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
chown -R testuser:testuser /home/testuser/.ssh

```

---

# 4️⃣ Authentication Refused: Bad Ownership

## ❌ Log Error
```

Authentication refused: bad ownership or modes for directory /home/testuser/.ssh

```

## ✅ Fix

```

sudo chown -R testuser:testuser /home/testuser/.ssh
sudo chmod 700 /home/testuser/.ssh
sudo chmod 600 /home/testuser/.ssh/authorized_keys

```

Then retry login.

---

# 5️⃣ SSH Configuration Error

## ❌ Error After Restart
```

sshd: /etc/ssh/sshd_config line XX: Bad configuration option

```

## ✅ Fix

Validate config before restarting:
```

sudo sshd -t

```

This prevents locking yourself out.

---

# 6️⃣ Locked Out After Disabling PasswordAuthentication

## ❌ Problem
You disabled passwords but key login doesn't work.

## ✅ Recovery

1. Access server console (cloud/VM console)
2. Re-enable:
```

PasswordAuthentication yes

```
3. Restart:
```

sudo systemctl restart sshd

```

---

# 7️⃣ Firewall Blocking SSH

## ❌ Problem
SSH works locally but not remotely.

## ✅ Fix

Allow SSH:
```

sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload

```

If custom port:
```

sudo firewall-cmd --permanent --add-port=2222/tcp
sudo firewall-cmd --reload

```

---

# 8️⃣ SELinux Blocking SSH Keys

## ❌ Symptom
Key copied correctly but still denied.

## ✅ Fix

Restore SELinux contexts:
```

sudo restorecon -R /home/testuser/.ssh/

```

Check SELinux status:
```

getenforce

```

---

# 9️⃣ Debugging SSH Client

Use verbose mode:
```

ssh -v testuser@server-ip

```

Look for:
- `Offering RSA public key`
- `Authentication succeeded (publickey)`
- `Permission denied`

---

# 🔟 Check SSH Logs

On RHEL/CentOS:

```

sudo journalctl -u sshd

```

Or:
```

sudo tail -n 50 /var/log/secure

```

Look for:
- Accepted password
- Accepted publickey
- Authentication failures
- Bad ownership

---

# 1️⃣1️⃣ SSH Listening on Wrong Port

Check:
```

sudo ss -tuln | grep ssh

```

If changed port:
```

grep ^Port /etc/ssh/sshd_config

```

---

# 🔐 SSH Security Best Practices Recap

- Disable root login
- Disable password authentication
- Restrict users (AllowUsers)
- Use strong ciphers/MACs
- Set MaxAuthTries
- Monitor logs
- Use firewall restrictions
- Use key-based authentication only

---

# 🎯 RHCSA Exam Tip

Always:

1. Test SSH config:
```

sshd -t

```
2. Restart service:
```

systemctl restart sshd

```
3. Verify port:
```

ss -tuln | grep :22

```

Never restart sshd without validating syntax.

---

# ✅ Final Verification Checklist

```

sudo systemctl status sshd
sudo sshd -t
sudo firewall-cmd --list-services
sudo ss -tuln | grep :22
ssh testuser@server-ip

```

If all succeed → SSH configured securely and correctly.

---

# 🏁 Lab 27 Completed

I successfully:

- Installed and verified OpenSSH
- Configured secure sshd settings
- Enabled firewall rules
- Created user access
- Implemented key-based authentication
- Disabled password authentication
- Applied advanced hardening
- Troubleshot real SSH issues

SSH is now securely configured according to enterprise best practices.
