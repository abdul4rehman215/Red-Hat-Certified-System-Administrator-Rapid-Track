# 🎤 Interview Q&A — Lab 28: Installing and Managing Software Packages

---

## 1️⃣ What is the difference between RPM, YUM, and DNF?

- **RPM** is the low-level package management system that installs `.rpm` files and maintains the package database.
- **YUM** is a higher-level package manager that handles dependency resolution and repository management.
- **DNF** is the modern replacement for YUM in RHEL 8+, offering better performance and improved dependency handling.

RPM does not resolve dependencies automatically, while YUM/DNF do.

---

## 2️⃣ How do you check if a package is installed?

You can use:

```bash
rpm -q package_name
````

or

```bash
yum list installed package_name
```

If installed, it will display the package version.

---

## 3️⃣ How do you find which package owns a specific file?

Use:

```bash
rpm -qf /path/to/file
```

This is useful for troubleshooting binaries and verifying software origin.

---

## 4️⃣ How do you search for a package in repositories?

```bash
yum search keyword
```

This searches package names and descriptions.

---

## 5️⃣ How do you check package dependencies?

```bash
yum deplist package_name
```

This shows required libraries, binaries, and dependent packages.

---

## 6️⃣ What is a package group?

A package group is a collection of related packages installed together.

Example:

```bash
yum groupinstall "Development Tools"
```

This installs compilers, build tools, and related dependencies.

---

## 7️⃣ How do you remove a package safely?

```bash
sudo yum remove package_name -y
```

YUM resolves dependencies and removes the package while protecting critical system components.

---

## 8️⃣ How do you check for available updates?

```bash
yum check-update
```

This lists packages that have newer versions available in enabled repositories.

---

## 9️⃣ How do you update all packages on a system?

```bash
sudo yum update -y
```

This upgrades all installed packages to the latest available versions.

---

## 🔟 How do you clean the package cache?

```bash
sudo yum clean all
```

Cache is stored under:

```bash
/var/cache/yum/
```

Cleaning helps free disk space and resolve metadata issues.

---

## 1️⃣1️⃣ How can you see the history of package transactions?

```bash
yum history list
```

This shows installs, updates, removals, and transaction IDs.

---

## 1️⃣2️⃣ What is the difference between `yum update` and `yum upgrade`?

In CentOS 7:

* `yum update` updates packages.
* `yum upgrade` behaves similarly.

In modern systems (DNF-based), `upgrade` may handle obsolete packages differently.

---

## 1️⃣3️⃣ How do you reinstall a package?

```bash
sudo yum reinstall package_name
```

Useful if files are corrupted or missing.

---

## 1️⃣4️⃣ Why is package management important for security?

* Security patches are delivered via repositories.
* Updating packages reduces vulnerabilities.
* Ensures verified and signed software installations.
* Allows audit and compliance tracking via transaction history.

---

## 1️⃣5️⃣ What repositories were enabled in this lab?

* base
* extras
* updates
* epel

Repositories determine what software is available to the system.

---

# ✅ Summary

This lab validates core RHCSA-level skills in:

* Installing packages
* Querying and auditing packages
* Managing repositories
* Updating systems securely
* Removing software safely
* Handling dependencies and cache cleanup

These skills are essential for production Linux administration.
