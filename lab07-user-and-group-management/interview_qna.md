
# 🎤 Interview Q&A – Lab 07: User and Group Management in Linux

> This section covers commonly asked interview questions related to Linux user and group administration (RHCSA-focused).

---

## 1️⃣ What file stores user account information in Linux?

**Answer:**

User account details are stored in:

```

/etc/passwd

```

It contains:
- Username
- UID
- GID
- Home directory
- Default shell

---

## 2️⃣ Where are encrypted passwords stored?

**Answer:**

Encrypted passwords are stored in:

```

/etc/shadow

````

This file is readable only by root for security reasons.

---

## 3️⃣ What is the difference between `useradd` and `adduser`?

**Answer:**

- `useradd` → Low-level command (standard across distributions)
- `adduser` → User-friendly wrapper (interactive on Debian/Ubuntu)

For RHCSA, `useradd` is preferred.

---

## 4️⃣ What does the `-m` option do in `useradd -m`?

**Answer:**

It creates a home directory for the user.

Example:

```bash
sudo useradd -m username
````

Without `-m`, no home directory is created (unless configured otherwise).

---

## 5️⃣ What is a UID?

**Answer:**

UID (User ID) is a unique numeric identifier assigned to each user.

* Root user always has UID 0.
* Regular users usually start from UID 1000.

---

## 6️⃣ What is the difference between primary and secondary groups?

**Answer:**

* **Primary group** → Defined in `/etc/passwd`
* **Secondary groups** → Additional groups user belongs to

Use:

```bash
groups username
```

To view group membership.

---

## 7️⃣ What does `usermod -aG` do?

**Answer:**

* `-a` → Append (important to prevent overwriting groups)
* `-G` → Specify supplementary groups

Example:

```bash
sudo usermod -aG developers labuser1
```

Without `-a`, existing groups would be removed.

---

## 8️⃣ How do you remove a user from a group?

**Answer:**

Using:

```bash
sudo gpasswd -d username groupname
```

---

## 9️⃣ How do you delete a user and their home directory?

**Answer:**

```bash
sudo userdel -r username
```

`-r` removes the home directory.

---

## 🔟 Why might `userdel` fail?

**Answer:**

Common reasons:

* User is currently logged in
* User has running processes

Solution:

```bash
sudo pkill -u username
```

Then retry deletion.

---

## 1️⃣1️⃣ How do you change a user's default shell?

**Answer:**

```bash
sudo usermod -s /bin/bash username
```

Verify with:

```bash
grep username /etc/passwd
```

---

## 1️⃣2️⃣ What is the purpose of `/etc/group`?

**Answer:**

It stores:

* Group names
* GIDs
* Group members

Format:

```
groupname:x:GID:members
```

---

## 1️⃣3️⃣ Why is group management important?

**Answer:**

Groups enable:

* Role-based access control
* Shared directory permissions
* Simplified permission management
* Enterprise-level access control

---

## 1️⃣4️⃣ What happens if you forget `-a` when using `usermod -G`?

**Answer:**

The user's existing supplementary groups are replaced.

Example mistake:

```bash
sudo usermod -G developers username
```

This removes user from all other groups.

---

## 1️⃣5️⃣ Why is user and group management critical in enterprise systems?

**Answer:**

Because it controls:

* Access privileges
* Security boundaries
* Data protection
* Compliance policies
* Multi-user server integrity

Improper user management can lead to privilege escalation and security breaches.

---

# 🧠 Final Interview Insight

A strong Linux administrator:

* Understands UID/GID mapping
* Knows system files (`/etc/passwd`, `/etc/group`, `/etc/shadow`)
* Uses `usermod -aG` safely
* Cleans up unused accounts
* Applies least privilege principle

User and group management is a core RHCSA competency.
