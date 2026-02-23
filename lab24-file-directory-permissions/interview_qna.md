# 🎤 Interview Q&A — Lab 24: File and Directory Permissions

## 1️⃣ What do the permission bits rwxr-xr-x represent?

This represents:

- **Owner**: `rwx` → Read, Write, Execute  
- **Group**: `r-x` → Read, Execute  
- **Others**: `r-x` → Read, Execute  

Each permission has numeric value:
- r = 4
- w = 2
- x = 1

So `755` = (7 = 4+2+1), (5 = 4+1), (5 = 4+1)

---

## 2️⃣ What is the difference between numeric and symbolic chmod?

### Numeric (Octal)
Uses numbers:
```bash
chmod 755 file.sh
````

### Symbolic

Uses letters:

```bash
chmod u+x,g-w file.sh
```

Numeric is faster for full permission resets.
Symbolic is safer for incremental changes.

---

## 3️⃣ Why is execute (x) required on directories?

On directories:

* `r` → List directory contents
* `x` → Enter/traverse directory
* `w` → Create/delete files inside

Without execute permission, you cannot access files inside the directory even if you have read permission.

---

## 4️⃣ What does the “+” symbol mean in `ls -l` output?

Example:

```bash
-rw-rw-r--+ 1 centos centos 17 acltest.txt
```

The `+` indicates **extended ACLs** are applied to the file.

Use:

```bash
getfacl filename
```

To view detailed ACL entries.

---

## 5️⃣ What is the difference between chown and chgrp?

* `chown` → Changes file owner
* `chgrp` → Changes file group

Examples:

```bash
chown user file
chown user:group file
chgrp group file
```

---

## 6️⃣ What happens if you remove execute permission from a directory?

You cannot:

* `cd` into it
* Access files inside
* List contents properly

Example error:

```
Permission denied
```

---

## 7️⃣ What is umask and how does it affect file creation?

Umask subtracts permissions from default creation mode.

Default creation:

* Files → 666
* Directories → 777

If umask = 0022:

Files:

```
666 - 022 = 644
```

Directories:

```
777 - 022 = 755
```

---

## 8️⃣ What are ACLs and why are they used?

ACL (Access Control List) allows granular permissions beyond owner/group/others.

Example:

```bash
setfacl -m u:testuser:rw file.txt
```

Use when:

* Multiple users need different access levels
* Standard Unix permissions are insufficient

---

## 9️⃣ What is the ACL mask and why is it important?

The mask limits the **maximum effective permissions** for named users and groups.

Example:

```
mask::rw-
```

Even if a user has `rwx`, effective permission may be restricted by mask.

---

## 🔟 What are default ACLs?

Default ACLs apply to **new files inside a directory**.

Example:

```bash
setfacl -m d:u:testuser:rwx testdir
```

Files created inside `testdir` inherit those ACLs.

---

## 1️⃣1️⃣ How do you remove ACL entries?

Remove specific entry:

```bash
setfacl -x u:testuser file.txt
```

Remove all ACLs:

```bash
setfacl -b file.txt
```

---

## 1️⃣2️⃣ Why might a user still be unable to execute a file even if it has 755 permissions?

Possible reasons:

* User is on mounted filesystem with noexec
* SELinux blocking execution
* Parent directory lacks execute permission
* ACL mask restricting permissions

Check:

```bash
ls -Z filename
getenforce
```

---

## 1️⃣3️⃣ What is the principle of least privilege?

Grant only the minimum permissions necessary for a task.

Example:

* Config files → 600
* Scripts → 750
* Public executables → 755

This reduces attack surface.

---

## 1️⃣4️⃣ What are common production permission standards?

| File Type        | Typical Permission |
| ---------------- | ------------------ |
| Executables      | 755                |
| Config Files     | 644                |
| Sensitive Data   | 600                |
| Directories      | 755                |
| Private SSH Keys | 600                |

---

## 1️⃣5️⃣ How do you troubleshoot permission denied errors?

Step-by-step:

```bash
ls -l filename
getfacl filename
groups
id
mount | grep noexec
getenforce
```

Check:

* Ownership
* Group membership
* ACLs
* SELinux
* Filesystem mount options

---

# ✅ Interview Readiness Summary

After this lab, I can confidently explain:

* Numeric vs symbolic permissions
* Directory execute behavior
* Ownership management
* ACL usage and masks
* Permission troubleshooting workflow
* Security best practices in Linux

These are core RHCSA-level objectives.
