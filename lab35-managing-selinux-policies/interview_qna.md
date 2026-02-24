# 🎤 Interview Q&A – Lab 35: Managing SELinux Policies (RHCSA Level)

---

## 1️⃣ What is SELinux?

**Answer:**
SELinux (Security-Enhanced Linux) is a Mandatory Access Control (MAC) security mechanism built into the Linux kernel.  
Unlike traditional file permissions (DAC), SELinux enforces policy-based access controls that restrict what processes can access, even if UNIX permissions allow it.

---

## 2️⃣ What are the three SELinux modes?

**Answer:**

| Mode        | Description |
|-------------|-------------|
| Enforcing   | Policy is enforced. Access violations are blocked and logged. |
| Permissive  | Violations are logged but not blocked. |
| Disabled    | SELinux is completely turned off. |

Command to check:
```bash
getenforce
````

---

## 3️⃣ What does `sestatus` show?

**Answer:**
`sestatus` displays:

* SELinux status (enabled/disabled)
* Current mode
* Policy name
* MLS status
* Policy version

It provides a full overview of SELinux configuration.

---

## 4️⃣ What is an SELinux context?

**Answer:**
An SELinux context has four parts:

```
user:role:type:level
```

Example:

```
system_u:system_r:httpd_t:s0
```

The **type field is most important** in access decisions.

---

## 5️⃣ Why is the "type" field important?

**Answer:**
SELinux primarily makes access decisions based on the **type**.
For example:

* `httpd_t` → Apache process
* `httpd_sys_content_t` → Web content
* `user_home_t` → User home files

If types don’t match expected policy rules, access is denied.

---

## 6️⃣ How do you permanently change a file’s SELinux context?

**Answer:**
Use `semanage fcontext` + `restorecon`.

```bash
sudo semanage fcontext -a -t httpd_sys_content_t "/path(/.*)?"
sudo restorecon -R -v /path
```

`chcon` is temporary and not persistent across relabel.

---

## 7️⃣ What is the purpose of `semanage port`?

**Answer:**
It manages SELinux port labeling.

Example:

```bash
sudo semanage port -a -t http_port_t -p tcp 8080
```

This allows services like Apache to bind to non-standard ports.

---

## 8️⃣ What are SELinux booleans?

**Answer:**
Booleans are toggle switches that enable or disable specific policy behaviors.

Example:

```bash
getsebool httpd_can_network_connect
sudo setsebool -P httpd_can_network_connect on
```

They allow controlled flexibility without modifying policies.

---

## 9️⃣ How do you check SELinux denials?

**Answer:**
Use audit tools:

```bash
sudo ausearch -m avc -ts recent
sudo sealert -a /var/log/audit/audit.log
```

AVC (Access Vector Cache) messages indicate denials.

---

## 🔟 What is `audit2allow` used for?

**Answer:**
`audit2allow` converts SELinux denial logs into policy rules.

Example:

```bash
grep denied /var/log/audit/audit.log | audit2allow -M mymodule
```

It generates a custom policy module.

⚠ Best practice: Use only if labeling or booleans cannot solve the issue.

---

## 1️⃣1️⃣ Why should you avoid disabling SELinux?

**Answer:**
Disabling SELinux:

* Removes kernel-level protection
* Increases attack surface
* Violates enterprise security standards

Best practice: Fix the policy issue instead.

---

## 1️⃣2️⃣ What is the difference between `restorecon` and `chcon`?

| Command    | Persistent | Recommended       |
| ---------- | ---------- | ----------------- |
| chcon      | ❌ No       | Temporary testing |
| restorecon | ✅ Yes      | Production fix    |

---

## 1️⃣3️⃣ What is the difference between DAC and MAC?

**Answer:**

| DAC (Discretionary Access Control) | MAC (Mandatory Access Control) |
| ---------------------------------- | ------------------------------ |
| Controlled by file owner           | Controlled by system policy    |
| Uses rwx permissions               | Uses SELinux types/policies    |
| Can be bypassed by root            | Even root is restricted        |

SELinux implements MAC.

---

## 1️⃣4️⃣ What command shows process contexts?

```bash
ps -eZ
```

This displays SELinux labels for running processes.

---

## 1️⃣5️⃣ What is the correct way to fix Apache 403 caused by SELinux?

**Answer:**

1. Check audit logs
2. Identify file context mismatch
3. Apply correct type:

```bash
sudo semanage fcontext -a -t httpd_sys_content_t "/path(/.*)?"
sudo restorecon -R -v /path
```

Avoid installing custom modules unless necessary.

---

# ✅ Summary

This lab demonstrates:

* Understanding SELinux architecture
* Context-based access control
* Managing file, port, and boolean policies
* Reading and fixing AVC denials
* Applying enterprise-grade security practices

These are core RHCSA and production Linux administration skills.
