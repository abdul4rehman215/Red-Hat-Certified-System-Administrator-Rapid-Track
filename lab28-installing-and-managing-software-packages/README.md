# 🧪 Lab 28: Installing and Managing Software Packages

---

## 📌 Lab Summary

This lab focuses on **software package management** in Red Hat-based Linux systems.  
You practiced installing, querying, updating, and removing software using:

- ✅ `yum` (CentOS 7-style environment)
- ✅ `rpm` (low-level package database tool)

> **Environment Reality Note:**  
> This lab run was performed on a **CentOS 7-style system** (`-bash-4.2$`).  
> - `yum` is the primary package manager  
> - `dnf` is **not installed by default**  
> - Where the lab references **dnf**, the **yum equivalent** was used (same outcome)

---

## 🎯 Objectives

By the end of this lab, I was able to:

- Install software packages using `yum` (dnf-equivalent behavior)
- Query installed packages using `rpm` and `yum`
- Search for packages in repositories
- Remove unwanted packages safely
- Update packages to latest versions
- Understand package dependencies and conflicts
- Verify package integrity and installation status
- Manage repository configuration and cache cleanup

---

## 📋 Prerequisites

- Basic Linux command-line usage
- Terminal navigation and filesystem knowledge
- `sudo` privileges / root access
- Understanding of software packages and repositories
- Basic text editor skills (nano/vim)

---

## 🖥️ Lab Environment

**Cloud Lab Provider:** Al Nafi (Ready-to-use machines)

| Component | Details |
|----------|---------|
| OS | CentOS 7-style environment |
| Shell Prompt | `-bash-4.2$` |
| Package Manager | `yum` |
| Low-level Tool | `rpm` |
| Internet | Enabled (repo downloads) |
| Repos Used | base, extras, updates, epel |

---

## 🗂️ Repository Structure

```text
lab28-installing-and-managing-software-packages/
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
└── troubleshooting.md
````

---

## 🧩 Tasks Overview

### ✅ Task 1: Installing Packages Using DNF / YUM (YUM used)

* Verified package manager availability (`which dnf`, `which yum`)
* Updated repository metadata (`yum update -y`)
* Installed individual packages (`nano`, `htop`, `wget`)
* Installed multiple packages at once (`tree`, `zip`, `unzip`, `curl`)
* Worked with **package groups** (`yum groupinstall "Development Tools"`)

### ✅ Task 2: Querying Installed Packages (RPM + YUM)

* Listed installed packages (`rpm -qa`, `yum list installed`)
* Queried package metadata (`rpm -qi`, `yum info`)
* Verified installed files (`rpm -ql`)
* Traced file ownership to packages (`rpm -qf`)
* Checked dependencies (`yum deplist`)
* Checked repos (`yum repolist`, `yum repolist all`)
* Reviewed history (`yum history list`)

### ✅ Task 3: Removing and Updating Packages

* Removed installed packages (`yum remove tree`)
* Installed and removed service packages (`httpd`) to observe dependency handling
* Performed package updates (`yum update nano`, full `yum update -y`)
* Used reinstall (`yum reinstall nano`)
* Cleaned cache (`yum clean all`)
* Verified cache reduction (`du -sh /var/cache/yum/`)

### ✅ Practical Scenario: Web Development Environment

* Installed stack: `httpd`, `php`, `php-mysqlnd`, `mariadb-server`, `git`
* Verified installs with RPM queries
* Started/enabled httpd using systemctl
* Checked updates and applied package upgrades
* Performed cleanup (stop/disable services, remove packages)

---

## 🔎 Verification & Validation Performed

* Confirmed yum availability and version
* Confirmed rpm version
* Verified installed packages using `rpm -q`
* Verified repos enabled using `yum repolist enabled`
* Verified updates using `yum check-update`
* Confirmed cache cleanup effects using `du -sh /var/cache/yum/`

---

## ✅ Result

* Successfully installed and verified packages (`nano`, `htop`, `zip`, `unzip`, `curl`, etc.)
* Installed and validated package groups (Development Tools → gcc available)
* Queried package info, dependencies, installed files, and file ownership
* Removed packages cleanly and safely
* Updated core packages successfully (`glibc`, `openssl`, `python`)
* Managed cache and reduced disk usage (`/var/cache/yum/`)
* Completed a full realistic “install → verify → run → update → cleanup” workflow

---

## 📚 What I Learned

* Difference between **package managers** (`yum/dnf`) and **package database tools** (`rpm`)
* How repositories control what software is available
* How to validate package installation and inspect installed files
* How to manage dependencies, groups, and transaction history
* Why cache cleanup matters in disk-constrained systems

---

## 🧠 Why This Matters

Package management is essential for:

* ✅ system security patching
* ✅ installing administrative tools quickly and consistently
* ✅ verifying system state (what is installed, what changed)
* ✅ troubleshooting dependency conflicts
* ✅ maintaining stable and compliant servers

---

## 🌍 Real-World Relevance

In production environments, admins must:

* Apply security updates without breaking dependencies
* Verify installed binaries and their origin (package ownership)
* Standardize software across servers
* Maintain repository hygiene and caching for performance

---

## 🧰 Real-World Applications

* Installing SOC utilities (`htop`, `wget`, `curl`, `nmap`, etc.)
* Deploying web stacks (Apache/PHP/DB)
* Checking package ownership for security audits (`rpm -qf`)
* Reviewing patch history (`yum history`)
* Enforcing baseline tooling via group installs (“Development Tools”)

---

## 🏁 Conclusion

This lab strengthened my hands-on skills with:

* `yum` for installation, updates, removal, repository management
* `rpm` for package database verification, metadata, and file tracking

These are **core RHCSA-level operational skills** required for maintaining secure, stable, and well-managed Linux systems.

✅ Lab 28 completed successfully on a CentOS 7-style environment.
