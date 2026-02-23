# 🎤 Interview Q&A – Lab 23: Managing Users and Groups

---

## 1️⃣ What is the purpose of the `useradd` command?

`useradd` is used to create a new user account in Linux.

Example:

```bash
useradd john
````

It creates:

* An entry in `/etc/passwd`
* A group with the same name (if default behavior enabled)
* A home directory (if `-m` is used)

---

## 2️⃣ What is the structure of `/etc/passwd`?

Format:

```
username:x:UID:GID:comment:home_directory:shell
```

Example:

```
john:x:1001:1001:John Doe:/home/john:/bin/bash
```

Field Breakdown:

* Username
* Placeholder for password (`x`)
* UID
* GID
* Comment (GECOS)
* Home directory
* Default shell

---

## 3️⃣ What is `/etc/shadow` used for?

It stores encrypted password hashes and password aging information.

Format:

```
username:hash:last_change:min:max:warn:inactive:expire
```

Only root can read `/etc/shadow`.

---

## 4️⃣ Difference Between `useradd` and `usermod`?

| Command   | Purpose                |
| --------- | ---------------------- |
| `useradd` | Creates new user       |
| `usermod` | Modifies existing user |

Example:

```bash
usermod -s /bin/zsh sarah
```

---

## 5️⃣ How do you set a user password?

```bash
passwd username
```

Example:

```bash
passwd john
```

---

## 6️⃣ What does `usermod -L` do?

It locks a user account by disabling the password.

```bash
usermod -L username
```

To unlock:

```bash
usermod -U username
```

---

## 7️⃣ What is the difference between primary and secondary groups?

* **Primary group** → Assigned at user creation (shown in `/etc/passwd`)
* **Secondary groups** → Additional groups (stored in `/etc/group`)

Check with:

```bash
id username
```

---

## 8️⃣ How do you change a user’s primary group?

```bash
usermod -g groupname username
```

---

## 9️⃣ How do you append a user to additional groups without removing existing ones?

```bash
usermod -a -G group1,group2 username
```

⚠️ Without `-a`, existing secondary groups are overwritten.

---

## 🔟 What does `groupadd -r` do?

Creates a **system group** (low GID range).

Example:

```bash
groupadd -r sysops
```

---

## 1️⃣1️⃣ Why did `groupdel development` fail initially?

Error:

```
groupdel: cannot remove the primary group of user 'john'
```

Because `development` was John’s primary group.

Solution:

1. Change primary group
2. Then delete the group

---

## 1️⃣2️⃣ What is `chage` used for?

Manages password aging policies.

Examples:

```bash
chage -M 90 username   # Max days
chage -m 7 username    # Min days
chage -W 7 username    # Warning days
```

---

## 1️⃣3️⃣ What happens if you run `userdel username` without `-r`?

* User account is deleted
* Home directory remains

To remove home:

```bash
userdel -r username
```

---

## 1️⃣4️⃣ What command checks password status?

```bash
passwd -S username
```

Output codes:

* `PS` → Password set
* `LK` → Locked
* `NP` → No password

---

## 1️⃣5️⃣ Why is user and group management critical in enterprise Linux?

Because it ensures:

* Access control enforcement
* Principle of least privilege
* Secure onboarding/offboarding
* Compliance and auditing
* Service account isolation
* Multi-user system integrity

Improper management can lead to:

* Privilege escalation
* Unauthorized access
* Security breaches

---

# 🎯 Interview Readiness Summary

After this lab, I can confidently:

* Create and manage Linux user accounts
* Implement group-based access control
* Enforce password aging policies
* Securely disable accounts
* Clean up users/groups without breaking system integrity
* Troubleshoot identity-related errors

This aligns directly with RHCSA exam objectives and real-world Linux system administration responsibilities.
