# 🧪 Lab 35: Managing SELinux Policies (RHEL 9 / CentOS Stream 9)

> **Focus:** SELinux fundamentals, contexts, booleans, ports, audit denials, and real-world troubleshooting using `semanage`, `restorecon`, `ausearch`, `sealert`, and `audit2allow`.

---

## 📌 Lab Metadata

- **Environment:** RHEL 9 / CentOS Stream 9 (Cloud Lab Environment)
- **User:** `centos` (sudo privileges)
- **Shell Prompt:** `-bash-4.2$`
- **SELinux Mode (during lab):** `Enforcing`
- **Policy:** `targeted`

---

## 🎯 Objectives

By the end of this lab, I was able to:

- Understand SELinux concepts and the MAC (Mandatory Access Control) model
- Check SELinux status and mode using `sestatus` and `getenforce`
- Inspect SELinux contexts for files, users, and processes
- Manage file context rules using `semanage fcontext` + `restorecon`
- Manage port contexts using `semanage port`
- Manage SELinux booleans using `getsebool` and `setsebool`
- Investigate and resolve SELinux denials using audit logs (`ausearch`, `sealert`)
- Apply best practices (fix with correct labeling first, avoid unnecessary policy modules)

---

## 🧠 Why This Matters (Security Relevance)

SELinux provides **mandatory access controls** that remain effective even if:
- file permissions are too permissive,
- an application is misconfigured,
- or a service is compromised.

This lab mirrors real enterprise scenarios where services fail due to SELinux labeling, ports, or policy restrictions—and teaches how to solve them **without disabling SELinux**.

---

## ✅ Prerequisites

- Basic Linux CLI usage
- Understanding of permissions/ownership
- Comfort reading logs
- Sudo/root access in a Red Hat-based system

---

## 🧩 Tasks Overview (High-Level)

### ✅ Task 1 — Validate SELinux Status & Contexts
- Verified `sestatus`, `getenforce`, and `/etc/selinux/config`
- Checked file contexts (`ls -Z`), process contexts (`ps -eZ`), and user context (`id -Z`)

### ✅ Task 2 — Policy Management with `semanage`
- Installed SELinux management utilities
- Created and applied custom file context mappings
- Updated/validated port labeling for HTTP services
- Enabled and persisted SELinux booleans
- Reviewed SELinux login mappings and SELinux users

### ✅ Task 3 — Troubleshoot SELinux Denials (Audit Workflow)
- Installed troubleshooting tools (`setroubleshoot-server`)
- Generated a realistic denial scenario using Apache + non-standard document root
- Pulled AVC denials from audit logs
- Used `sealert` + `ausearch` to identify root cause
- Resolved issue using correct content type labeling (`httpd_sys_content_t`)
- Demonstrated policy module generation (`audit2allow`) and noted when **not** to use it

---

## 📁 Repository Structure

```text
lab35-managing-selinux-policies/
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
├── troubleshooting.md
├── scripts/
│   └── selinux-monitor.sh
└──  configs/
│   └── testsite.conf

```

---

## 📄 Files Explained

* **`README.md`** → Portfolio-style summary of the lab
* **`commands.sh`** → All commands executed (in order)
* **`output.txt`** → Full outputs captured from the terminal + tool outputs
* **`scripts/selinux-monitor.sh`** → SELinux status/denial monitoring helper
* **`configs/testsite.conf`** → Apache virtual host used for denial scenario
* **`interview_qna.md`** → Common interview questions (SELinux-focused)
* **`troubleshooting.md`** → Practical troubleshooting guide and fixes
* **`.gitignore`** → Keeps irrelevant/temporary artifacts out of git history

---

## ✅ Verification Summary

Key confirmations performed during the lab:

* `sestatus` confirmed **enabled + enforcing**
* `ls -Z`, `ps -eZ`, `id -Z` confirmed contexts for files/processes/user
* `restorecon` applied labels successfully after `semanage fcontext`
* `semanage port -l` confirmed HTTP port labeling for `8080`
* `ausearch -m avc -ts recent` showed denials after Apache test scenario
* `curl http://localhost/` returned **403 (blocked)** before fix and **valid HTML** after correct labeling

---

## 🧾 What I Learned

* SELinux denials often look like “app is broken”, but the fix is usually:

  1. **labeling** (best practice),
  2. then **booleans** (selective enablement),
  3. only then consider **custom policy modules** (last resort).

* The most important field in contexts is the **type**:

  * Example: `httpd_sys_content_t`, `httpd_config_t`, `user_home_t`

* Audit workflow is critical:

  * `ausearch` → find AVC
  * `sealert` → interpret denial and recommended actions
  * `restorecon` / `semanage` → apply correct persistent fixes

---

## 🧹 Cleanup Notes

This lab included cleanup steps:

* Removed test directories and Apache config
* Removed custom `semanage fcontext` rules
* Removed custom port mapping
* Restarted Apache to return system to normal state

---

## 🏁 Conclusion

This lab strengthened real-world SELinux administration skills:

* interpreting denials,
* safely fixing access issues in enforcing mode,
* and maintaining strong system security posture without disabling SELinux.

SELinux is a core enterprise requirement and a common RHCSA/RHCE topic—this lab is directly aligned with real troubleshooting workflows in production Linux environments.
