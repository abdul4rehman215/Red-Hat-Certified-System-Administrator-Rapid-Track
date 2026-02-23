# 🎓 Interview Q&A – Lab 12: Troubleshooting SELinux

---

## 1️⃣ What is an AVC denial in SELinux?

An AVC (Access Vector Cache) denial occurs when SELinux blocks an action that violates its security policy.  
It is logged when a subject (process) attempts an operation that is not allowed on a target object.

Example:
type=AVC avc: denied { read } for pid=1542 comm="httpd"

---

## 2️⃣ How do you check recent SELinux denials?

Use:

sudo ausearch -m avc -ts recent

Alternatively:

sudo grep "avc:.*denied" /var/log/audit/audit.log

---

## 3️⃣ What is the difference between scontext and tcontext?

- **scontext (source context)** → Context of the process attempting the action.
- **tcontext (target context)** → Context of the file or resource being accessed.

Example:
scontext=system_u:system_r:httpd_t:s0  
tcontext=unconfined_u:object_r:default_t:s0  

---

## 4️⃣ What does audit2allow do?

`audit2allow` analyzes AVC denials and generates SELinux allow rules that would permit the blocked action.

It helps create custom policy modules.

---

## 5️⃣ How do you generate and install a custom SELinux policy module?

Generate module:

sudo ausearch -m avc -ts recent | audit2allow -M mypolicy

Install module:

sudo semodule -i mypolicy.pp

---

## 6️⃣ How do you verify a policy module is installed?

sudo semodule -l | grep mypolicy

---

## 7️⃣ When should you use restorecon instead of audit2allow?

Use `restorecon` when:

- The issue is caused by incorrect file labeling.
- The default policy already allows the action.
- The problem is due to context mismatch.

Creating custom policies should be the last resort.

---

## 8️⃣ Why is disabling SELinux not recommended?

Disabling SELinux removes Mandatory Access Control (MAC) protections, increasing risk of:

- Privilege escalation
- Service compromise
- Container breakout
- Lateral movement

Best practice is to troubleshoot properly, not disable.

---

## 9️⃣ What is the role of semodule?

`semodule` manages SELinux policy modules.

Common operations:
- Install module → semodule -i module.pp
- Remove module → semodule -r module_name
- List modules → semodule -l

---

## 🔟 What does this rule mean?

allow httpd_t default_t:file read;

It allows the httpd process (httpd_t) to read files labeled default_t.

---

## 1️⃣1️⃣ What is the difference between Enforcing and Permissive mode?

| Mode | Behavior |
|------|----------|
| Enforcing | Blocks unauthorized actions |
| Permissive | Logs denials but does not block |
| Disabled | SELinux completely off |

---

## 1️⃣2️⃣ What are best practices when handling SELinux denials?

✔ Check logs first  
✔ Confirm correct file context  
✔ Use restorecon when possible  
✔ Generate minimal policies  
✔ Avoid overly permissive rules  
✔ Keep SELinux in Enforcing mode  

---

## 1️⃣3️⃣ How does SELinux improve container security?

SELinux isolates:

- Containers from host
- Containers from each other
- Services from system files

It prevents unauthorized cross-process access.

---

## 1️⃣4️⃣ What command checks current SELinux mode quickly?

getenforce

---

## 1️⃣5️⃣ What is the structure of an SELinux context?

Format:

user:role:type:level

Example:
system_u:system_r:httpd_t:s0

- user → SELinux user
- role → Role
- type → Domain/type enforcement
- level → MLS level

---

# 🏁 Interview Summary

Key concepts tested in RHCSA & enterprise roles:

- AVC denial analysis
- audit2allow usage
- Policy module management
- Context troubleshooting
- Security-first mindset

SELinux troubleshooting is a high-value enterprise Linux skill.
