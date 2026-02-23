# 🛠 Troubleshooting Guide – Lab 16: Installing and Managing Software in RHEL

---

# 1️⃣ Metadata Expiration / Repository Errors

## ❌ Error
```

Failed to download metadata for repo

````

## 🔎 Possible Causes
- No internet connectivity
- Subscription expired
- Incorrect repository configuration
- DNS resolution issue

## ✅ Fix

Check internet connectivity:
```bash
ping 8.8.8.8
````

Verify subscription:

```bash
sudo subscription-manager status
```

Refresh metadata:

```bash
sudo dnf clean all
sudo dnf makecache
```

---

# 2️⃣ Subscription Not Registered

## ❌ Error

```
This system is not registered with an entitlement server.
```

## ✅ Fix

Register system:

```bash
sudo subscription-manager register
```

Attach subscription:

```bash
sudo subscription-manager attach --auto
```

---

# 3️⃣ Dependency Resolution Failure

## ❌ Error

```
Problem: conflicting requests
```

## 🔎 Causes

* Repository conflicts
* Version mismatch
* Broken package state

## ✅ Fix

Check conflicts:

```bash
sudo dnf check
```

Remove problematic package:

```bash
sudo dnf remove <package>
```

Try:

```bash
sudo dnf install <package> --allowerasing
```

---

# 4️⃣ Package Not Found

## ❌ Error

```
No match for argument: package_name
```

## 🔎 Causes

* Wrong repository enabled
* Typo in package name
* EPEL not installed

## ✅ Search for package

```bash
sudo dnf search package_name
```

Verify repository list:

```bash
sudo dnf repolist
```

---

# 5️⃣ RPM Database Corruption

## ❌ Symptoms

* Installation hangs
* Package queries fail

## ✅ Verify RPM database

```bash
sudo rpm --rebuilddb
```

Check integrity:

```bash
sudo rpm -Va
```

---

# 6️⃣ Too Many Open Files During Install

## ❌ Error

```
Too many open files
```

## 🔎 Check system limit

```bash
ulimit -n
```

Increase limit temporarily:

```bash
ulimit -n 100000
```

Increase permanently:
Edit `/etc/security/limits.conf`

---

# 7️⃣ EPEL Repository Issues

## ❌ EPEL packages unavailable

## 🔎 Verify EPEL

```bash
sudo dnf repolist | grep epel
```

Reinstall:

```bash
sudo dnf reinstall epel-release
```

---

# 8️⃣ Transaction Rollback

## 🔎 View transaction history

```bash
sudo dnf history
```

Undo transaction:

```bash
sudo dnf history undo <ID>
```

Redo transaction:

```bash
sudo dnf history redo <ID>
```

---

# 9️⃣ Verify Package Integrity

## 🔎 Verify installed package files

```bash
rpm -V package_name
```

Reinstall package:

```bash
sudo dnf reinstall package_name
```

---

# 🔟 Best Practices for Enterprise Package Management

✔ Always update metadata before install
✔ Avoid mixing repositories unnecessarily
✔ Use official repositories in production
✔ Track changes with `dnf history`
✔ Test updates in staging before production
✔ Avoid forcing installs with `--nodeps`

---

# 🔎 Diagnostic Checklist

| Check                    | Command                     |
| ------------------------ | --------------------------- |
| List repos               | dnf repolist                |
| Search package           | dnf search name             |
| Check installed packages | dnf list installed          |
| RPM query                | rpm -qa                     |
| Verify package           | rpm -V package              |
| Check subscription       | subscription-manager status |
| Clean metadata           | dnf clean all               |

---

# 🏁 Final Note

Package management directly impacts:

* System stability
* Security posture
* Production uptime
* Dependency integrity

Improper repository management or forced installs may cause:

* Broken systems
* Security vulnerabilities
* Unsupported configurations

Enterprise Linux administration requires disciplined package lifecycle management.
