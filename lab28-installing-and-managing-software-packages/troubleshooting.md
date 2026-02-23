# 🛠️ Troubleshooting Guide — Lab 28: Installing and Managing Software Packages

---

## 🔎 Issue 1: Package Not Found

### 🧾 Symptom
```bash
yum install package_name
````

Output:

```
No matches found
```

### 📌 Possible Causes

* Package name is incorrect.
* Required repository is not enabled.
* Repository metadata is outdated.
* Package exists only in external repos (e.g., EPEL).

### ✅ Resolution Steps

1️⃣ Verify correct package name:

```bash
yum search keyword
```

2️⃣ Check enabled repositories:

```bash
yum repolist
```

3️⃣ Enable missing repository (example: EPEL):

```bash
sudo yum install epel-release -y
```

4️⃣ Refresh repository metadata:

```bash
sudo yum clean all
sudo yum makecache
```

---

## 🔎 Issue 2: Dependency Errors During Installation

### 🧾 Symptom

```
Error: Package: xyz requires abc
```

### 📌 Possible Causes

* Required dependency not available in enabled repositories.
* Conflicting package versions installed.
* Corrupted package database.

### ✅ Resolution Steps

1️⃣ Check dependencies:

```bash
yum deplist package_name
```

2️⃣ Check for conflicts:

```bash
rpm -qa | grep conflicting_package
```

3️⃣ Update system:

```bash
sudo yum update -y
```

4️⃣ Clean metadata:

```bash
sudo yum clean all
```

---

## 🔎 Issue 3: Disk Space Issues

### 🧾 Symptom

```
No space left on device
```

### 📌 Verification

```bash
df -h
```

### 📌 Common Causes

* Large cache in `/var/cache/yum/`
* Log files consuming space
* Large package group installations

### ✅ Resolution Steps

1️⃣ Clean yum cache:

```bash
sudo yum clean all
```

2️⃣ Check cache size:

```bash
du -sh /var/cache/yum/
```

3️⃣ Remove unused packages:

```bash
sudo yum autoremove
```

4️⃣ Identify large files:

```bash
du -ah / | sort -rh | head -20
```

---

## 🔎 Issue 4: Repository Metadata Errors

### 🧾 Symptom

```
Cannot retrieve repository metadata
```

### 📌 Possible Causes

* No internet connectivity
* DNS resolution failure
* Repository mirror down

### ✅ Resolution Steps

1️⃣ Test internet connectivity:

```bash
ping -c 4 google.com
```

2️⃣ Check DNS configuration:

```bash
cat /etc/resolv.conf
```

3️⃣ Clean and rebuild cache:

```bash
sudo yum clean all
sudo yum makecache
```

---

## 🔎 Issue 5: Service Not Starting After Installation (Example: httpd)

### 🧾 Symptom

```bash
systemctl start httpd
```

Service fails to start.

### 📌 Possible Causes

* Port 80 already in use
* SELinux blocking service
* Configuration file error
* Missing dependencies

### ✅ Resolution Steps

1️⃣ Check service status:

```bash
systemctl status httpd
```

2️⃣ Check logs:

```bash
journalctl -xe
```

3️⃣ Check port usage:

```bash
ss -tulnp | grep :80
```

4️⃣ Validate configuration:

```bash
apachectl configtest
```

---

## 🔎 Issue 6: RPM Database Corruption

### 🧾 Symptom

```
rpmdb: damaged header
```

### 📌 Possible Causes

* Interrupted transaction
* Disk corruption
* Improper shutdown

### ✅ Resolution Steps

1️⃣ Backup RPM database:

```bash
cp -a /var/lib/rpm /var/lib/rpm.bak
```

2️⃣ Rebuild database:

```bash
rpm --rebuilddb
```

---

## 🔎 Issue 7: Package Version Conflicts

### 🧾 Symptom

```
Package xyz conflicts with abc
```

### 📌 Possible Causes

* Multiple repositories providing different versions
* Manually installed RPM conflicting with repo package

### ✅ Resolution Steps

1️⃣ Check installed version:

```bash
rpm -q package_name
```

2️⃣ Show available versions:

```bash
yum --showduplicates list package_name
```

3️⃣ Remove conflicting version:

```bash
sudo yum remove package_name
```

4️⃣ Install correct version:

```bash
sudo yum install package_name-version
```

---

# 🔐 Security Considerations

* Always verify package source repository.
* Keep systems updated regularly.
* Avoid installing untrusted third-party RPM files.
* Monitor update history using:

```bash
yum history list
```

---

# 📌 Final Notes

This troubleshooting section covers common real-world package management issues:

* Repository problems
* Dependency conflicts
* Disk space constraints
* Service startup failures
* RPM database corruption

These are routine operational challenges for Linux administrators and critical skills for RHCSA-level system management.
