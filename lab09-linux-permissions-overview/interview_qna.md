# 🎤 Interview Q&A – Linux Permissions Overview

---

## 1️⃣ What are Linux file permissions?

Linux file permissions define who can read, write, or execute a file or directory.  
They are divided into three categories:

- Owner
- Group
- Others

Each category can have:
- Read (r)
- Write (w)
- Execute (x)

---

## 2️⃣ What does `-rw-r--r--` mean?

Breakdown:

- `-` → Regular file
- `rw-` → Owner has read & write
- `r--` → Group has read only
- `r--` → Others have read only

---

## 3️⃣ What is the difference between numeric and symbolic chmod?

### Numeric Mode
Uses octal values:
- 4 = Read
- 2 = Write
- 1 = Execute

Example:
```bash
chmod 640 file.txt
````

### Symbolic Mode

Uses letters:

```bash
chmod u+x file.txt
```

---

## 4️⃣ What does `chmod 755` mean?

* Owner → 7 → rwx
* Group → 5 → r-x
* Others → 5 → r-x

Commonly used for executable scripts and directories.

---

## 5️⃣ Why is execute permission required for directories?

Execute permission on a directory allows:

* Entering the directory
* Accessing files inside

Without execute permission, you cannot `cd` into the directory.

---

## 6️⃣ What is the difference between chown and chgrp?

* `chown` → Changes file owner
* `chgrp` → Changes file group

You can combine both:

```bash
chown user:group file.txt
```

---

## 7️⃣ Who can change file ownership?

Only:

* Root user
* User with sudo privileges

Regular users cannot change file ownership arbitrarily.

---

## 8️⃣ What happens if permissions are misconfigured?

Possible risks:

* Unauthorized data access
* Privilege escalation
* Application failures
* Security breaches

---

## 9️⃣ How do you recursively change permissions?

```bash
chmod -R 755 directory/
```

The `-R` flag applies changes to all subdirectories and files.

---

## 🔟 How do you check file ownership and permissions?

```bash
ls -l
```

Displays:

* File type
* Permission bits
* Owner
* Group
* Size
* Timestamp

---

## 1️⃣1️⃣ What is the difference between 640 and 644?

| Mode | Owner | Group | Others |
| ---- | ----- | ----- | ------ |
| 640  | rw-   | r--   | ---    |
| 644  | rw-   | r--   | r--    |

640 is more restrictive.

---

## 1️⃣2️⃣ Why are permissions important in container environments?

In platforms like:

* Red Hat OpenShift
* Docker
* Kubernetes

File permissions ensure:

* Isolation between containers
* Secure volume mounting
* Controlled application access

---

## 1️⃣3️⃣ What command is used if “Permission denied” occurs?

If you own the file:

```bash
chmod +x filename
```

If root privileges required:

```bash
sudo chmod ...
```

---

## 1️⃣4️⃣ What does the first character in `ls -l` output indicate?

| Symbol | Meaning          |
| ------ | ---------------- |
| -      | Regular file     |
| d      | Directory        |
| l      | Symbolic link    |
| c      | Character device |
| b      | Block device     |

---

## 1️⃣5️⃣ How does Linux enforce access control?

Linux enforces:

* Discretionary Access Control (DAC)
* Ownership model
* Permission bits
* Optional: ACLs and SELinux policies

---

# 🏁 Final Interview Insight

Linux permissions are foundational to:

* System security
* User isolation
* Multi-tenant environments
* Enterprise compliance

Mastering permissions is essential for RHCSA and real-world Linux administration.
