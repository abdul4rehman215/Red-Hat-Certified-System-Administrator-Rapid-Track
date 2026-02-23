# 🎓 Interview Q&A – Lab 03: Problem Resolution with Red Hat Insights

---

## 1️⃣ What is Red Hat Insights?

Red Hat Insights is a proactive system management and analytics tool for RHEL systems.  
It analyzes system configuration, security posture, performance data, and compliance status to provide actionable remediation recommendations.

---

## 2️⃣ What is the role of `subscription-manager` in RHEL?

`subscription-manager` is used to:

- Register a RHEL system with Red Hat Subscription Manager (RHSM)
- Attach subscriptions
- Enable repositories
- Manage entitlements

Without subscription registration, official Red Hat repositories cannot be accessed.

---

## 3️⃣ How do you register a RHEL system?

```bash
sudo subscription-manager register --username <user> --password <password>
````

This connects the system to Red Hat’s subscription infrastructure.

---

## 4️⃣ What does `subscription-manager attach --auto` do?

It automatically attaches the best-matching available subscription to the registered system.

This ensures access to:

* BaseOS repository
* AppStream repository
* Updates and security patches

---

## 5️⃣ What is the `insights-client` package?

`insights-client` is the local agent installed on RHEL systems that:

* Collects system metadata
* Sends configuration and health data to Red Hat
* Enables centralized analysis in the Insights dashboard

---

## 6️⃣ How do you register a system with Red Hat Insights?

```bash
sudo insights-client --register
```

This registers the system with Red Hat Insights and links it to the console dashboard.

---

## 7️⃣ How do you trigger a system analysis manually?

```bash
sudo insights-client
```

This collects and uploads updated system metadata for evaluation.

---

## 8️⃣ What types of issues does Red Hat Insights categorize?

Insights categorizes issues into:

* 🔴 Security
* 🟠 Performance
* 🔵 Availability
* 🟢 Stability
* 🟡 Compliance

This helps administrators prioritize remediation efforts.

---

## 9️⃣ Why was disabling `PermitRootLogin` important?

Allowing root login over SSH increases security risk.

By setting:

```bash
PermitRootLogin no
```

We reduce:

* Brute-force attack exposure
* Unauthorized root access
* Privilege escalation risk

---

## 🔟 Why is updating the bash package important?

Outdated packages may:

* Contain vulnerabilities
* Lack security patches
* Be incompatible with newer system components

Updating ensures:

* Stability
* Security
* Compliance

---

## 1️⃣1️⃣ What file controls SSH server configuration?

```bash
/etc/ssh/sshd_config
```

Changes require restarting the SSH service.

---

## 1️⃣2️⃣ How do you verify SSH configuration syntax before restarting?

```bash
sudo sshd -t
```

This checks for syntax errors in the SSH configuration file.

---

## 1️⃣3️⃣ Why is Red Hat Insights useful in enterprise environments?

Because it:

* Reduces manual troubleshooting
* Centralizes fleet monitoring
* Provides actionable remediation steps
* Improves compliance posture
* Reduces downtime

---

## 1️⃣4️⃣ What is proactive system management?

Proactive system management means identifying and resolving issues before they cause outages or security incidents.

Red Hat Insights supports this by continuously analyzing system health.

---

## 1️⃣5️⃣ How does Insights improve security posture?

Insights improves security by:

* Detecting misconfigurations
* Identifying outdated packages
* Highlighting known vulnerabilities
* Providing guided remediation steps
* Tracking issue resolution status

---

🟥 RHCSA Focus:
Understanding system registration, subscription management, package updates, and security hardening is essential for enterprise Red Hat administration.
