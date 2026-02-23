# 🎓 Interview Q&A – Lab 16: Installing and Managing Software in RHEL

---

## 1️⃣ What is DNF in RHEL?

DNF (Dandified Yum) is the next-generation package manager used in RHEL 8 and 9.

It:
- Installs, updates, and removes packages
- Resolves dependencies automatically
- Tracks transaction history
- Manages repositories

---

## 2️⃣ What is the difference between yum and dnf?

In RHEL 8/9:

- `yum` is a symbolic link to `dnf`
- DNF provides better dependency resolution
- DNF supports modularity and improved performance

---

## 3️⃣ How do you install a package?

```bash
sudo dnf install package_name
````

Example:

```bash
sudo dnf install nginx -y
```

---

## 4️⃣ How do you remove a package?

```bash
sudo dnf remove package_name
```

---

## 5️⃣ How do you update the entire system?

```bash
sudo dnf update -y
```

Or:

```bash
sudo dnf upgrade -y
```

---

## 6️⃣ How do you check which repositories are enabled?

```bash
sudo dnf repolist
```

---

## 7️⃣ What is EPEL?

EPEL (Extra Packages for Enterprise Linux) provides additional community-supported packages for RHEL.

Installed via:

```bash
sudo dnf install epel-release -y
```

---

## 8️⃣ How does DNF handle dependencies?

DNF automatically:

* Resolves package dependencies
* Downloads required packages
* Installs them in the correct order
* Prevents dependency conflicts

---

## 9️⃣ How do you verify if a package is installed?

Using DNF:

```bash
dnf list installed | grep package_name
```

Using RPM:

```bash
rpm -qa | grep package_name
```

---

## 🔟 What is the difference between dnf and rpm?

| Tool | Purpose                                                     |
| ---- | ----------------------------------------------------------- |
| dnf  | High-level package manager with dependency resolution       |
| rpm  | Low-level package tool (no automatic dependency resolution) |

---

## 1️⃣1️⃣ How do you view package information?

```bash
rpm -qi package_name
```

---

## 1️⃣2️⃣ How do you list files installed by a package?

```bash
rpm -ql package_name
```

---

## 1️⃣3️⃣ What is dnf history?

DNF keeps transaction history:

```bash
sudo dnf history
```

You can undo transactions:

```bash
sudo dnf history undo <transaction_id>
```

---

## 1️⃣4️⃣ What is modularity in DNF?

Modularity allows multiple versions of software streams.

Example:

```bash
dnf module list
```

Useful for:

* Selecting specific runtime versions
* Managing application stacks

---

## 1️⃣5️⃣ Why is proper repository management important?

Incorrect repository configuration may cause:

* Broken dependencies
* Security risks
* Package conflicts
* Unsupported software installation

Production systems should use:

* Official RHEL repositories
* Approved internal mirrors
* Controlled EPEL usage

---

# 🏁 Interview Summary

Key knowledge areas:

✔ dnf vs rpm
✔ Repository management
✔ Dependency resolution
✔ EPEL configuration
✔ Transaction history
✔ Enterprise package lifecycle management

Package management is a core RHCSA and enterprise Linux administration skill.
