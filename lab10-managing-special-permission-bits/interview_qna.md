# 🎤 Interview Q&A – Lab 10: Managing Special Permission Bits

---

## 1️⃣ What are special permission bits in Linux?

Linux provides three special permission bits:

- **Sticky Bit**
- **setuid (Set User ID)**
- **setgid (Set Group ID)**

These extend the standard rwx permission model to provide controlled privilege behavior.

---

## 2️⃣ What is the Sticky Bit?

The sticky bit is applied to directories and ensures:

> Only the file owner (or root) can delete files within the directory.

Even if the directory has 777 permissions.

Example:
```bash
chmod +t /tmp/shared_dir
````

---

## 3️⃣ Where is the Sticky Bit commonly used?

The most common example:

```
/tmp
```

Permissions:

```
drwxrwxrwt
```

The `t` at the end indicates sticky bit enabled.

---

## 4️⃣ What is setuid?

setuid allows a user to execute a file with the **file owner’s privileges**, rather than their own.

Example:

```bash
chmod u+s file
```

Permission appears as:

```
-rwsr-xr-x
```

---

## 5️⃣ Give a real-world example of setuid.

The `passwd` command:

```
/usr/bin/passwd
```

It runs with root privileges so users can change their password (which updates `/etc/shadow`).

---

## 6️⃣ What is setgid?

setgid has two behaviors:

### On Executables:

Runs the program with the file's group privileges.

### On Directories:

New files created inside inherit the directory’s group.

---

## 7️⃣ How do you verify special permission bits?

Using:

```bash
ls -l
```

Or:

```bash
stat filename
```

Numeric mode:

* 4 → setuid
* 2 → setgid
* 1 → sticky bit

Example:

```
4755
```

---

## 8️⃣ What does permission 4755 mean?

Breakdown:

* 4 → setuid
* 7 → rwx (owner)
* 5 → r-x (group)
* 5 → r-x (others)

Displayed as:

```
-rwsr-xr-x
```

---

## 9️⃣ What happens if the filesystem is mounted with `nosuid`?

setuid and setgid bits are ignored.

Check:

```bash
mount | grep nosuid
```

---

## 🔟 Why can setuid be dangerous?

Improperly written setuid programs may lead to:

* Privilege escalation
* Root compromise
* Exploitable vulnerabilities

This is a common attack vector in penetration testing.

---

## 1️⃣1️⃣ How do you find all setuid files on a system?

```bash
find / -perm -4000 2>/dev/null
```

This is commonly used in security auditing.

---

## 1️⃣2️⃣ What is the difference between `s` and `S` in permissions?

* `s` → execute bit is present
* `S` → execute bit missing (misconfiguration)

Example:

```
-rwSr--r--
```

Means setuid set but no execute permission — usually incorrect.

---

## 1️⃣3️⃣ How does setgid work on directories?

If setgid is applied to a directory:

* All newly created files inherit the directory's group.
* Useful for shared project directories.

Example:

```bash
chmod g+s project_dir
```

---

## 1️⃣4️⃣ Why is Sticky Bit important in multi-user systems?

Without sticky bit:

Any user could delete another user’s file in a shared directory.

Sticky bit enforces deletion control and prevents abuse.

---

## 1️⃣5️⃣ How are these concepts relevant in enterprise environments?

Used in:

* RHEL production servers
* Shared DevOps environments
* OpenShift volumes
* Multi-user HPC systems
* Secure system utilities

Understanding special permission bits is essential for RHCSA certification and enterprise Linux security.

---

# 🏁 Final Interview Insight

Special permission bits enable:

* Controlled privilege elevation (setuid)
* Group-level execution control (setgid)
* Shared directory protection (sticky bit)

Improper configuration can cause severe security risks.
Proper configuration ensures secure multi-user Linux operations.
