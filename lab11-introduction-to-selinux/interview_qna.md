# 🎤 Interview Q&A – Lab 11: Introduction to SELinux

---

## 1️⃣ What is SELinux?

SELinux (Security-Enhanced Linux) is a **Mandatory Access Control (MAC)** security module integrated into the Linux kernel.

It enforces security policies that restrict how processes access files and system resources — even for the root user.

---

## 2️⃣ What is the difference between DAC and MAC?

| DAC (Discretionary Access Control) | MAC (Mandatory Access Control) |
|-----------------------------------|--------------------------------|
| Controlled by file ownership and permissions | Controlled by system-wide policy |
| Owner can modify access | Policies enforced by kernel |
| Root can bypass restrictions | Even root can be restricted |

SELinux implements MAC.

---

## 3️⃣ What are the three SELinux modes?

| Mode | Description |
|------|------------|
| Enforcing | Policies are enforced |
| Permissive | Violations logged but allowed |
| Disabled | SELinux completely turned off |

Check mode:

```bash
getenforce
````

---

## 4️⃣ How do you temporarily change SELinux mode?

```bash
sudo setenforce 0   # Permissive
sudo setenforce 1   # Enforcing
```

This change is temporary until reboot.

---

## 5️⃣ How do you permanently change SELinux mode?

Edit:

```
/etc/selinux/config
```

Example:

```
SELINUX=enforcing
SELINUXTYPE=targeted
```

Then reboot.

---

## 6️⃣ What is an SELinux context?

An SELinux context defines security labeling.

Format:

```
user:role:type:level
```

Example:

```
system_u:object_r:passwd_file_t:s0
```

---

## 7️⃣ How do you view SELinux file contexts?

```bash
ls -Z filename
```

---

## 8️⃣ What is the most important field in a context?

The **Type** field.

Example:

```
httpd_sys_content_t
```

Type enforcement is the core mechanism controlling access.

---

## 9️⃣ What is the difference between chcon and restorecon?

| Command    | Purpose                              |
| ---------- | ------------------------------------ |
| chcon      | Temporarily modifies context         |
| restorecon | Restores default context from policy |

`chcon` changes may not survive relabeling.

---

## 🔟 How do you check SELinux status?

```bash
sestatus
```

Displays:

* Mode
* Policy name
* Config mode
* MLS status

---

## 1️⃣1️⃣ How do you troubleshoot SELinux denials?

Check audit logs:

```bash
sudo ausearch -m avc -ts recent
```

Look for:

```
type=AVC
```

---

## 1️⃣2️⃣ What is audit2allow?

`audit2allow` converts SELinux denial logs into a policy module.

Example:

```bash
sudo ausearch -m avc -ts recent | audit2allow -M mypolicy
sudo semodule -i mypolicy.pp
```

---

## 1️⃣3️⃣ Why should you test in Permissive mode first?

To:

* Identify denials safely
* Avoid breaking production services
* Generate required policy rules

Best practice in enterprise environments.

---

## 1️⃣4️⃣ Why is SELinux important in OpenShift?

OpenShift uses SELinux to:

* Isolate containers
* Prevent container escape
* Protect host filesystem
* Enforce namespace separation

SELinux is foundational in container security.

---

## 1️⃣5️⃣ What happens if SELinux is disabled?

* No MAC enforcement
* Increased attack surface
* Reduced container security
* Non-compliance in enterprise environments

Disabling SELinux is strongly discouraged in production.

---

# 🏁 Final Interview Insight

SELinux adds a powerful mandatory security layer beyond traditional permissions.

Understanding:

* Context labeling
* Type enforcement
* Policy modules
* Enforcement modes

Is essential for RHCSA and enterprise Linux security operations.
