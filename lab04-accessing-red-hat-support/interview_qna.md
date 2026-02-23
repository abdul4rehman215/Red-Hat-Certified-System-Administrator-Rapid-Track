# 🎤 Interview Q&A – Lab 04: Accessing Red Hat Support

This section covers practical interview questions related to enterprise Linux support workflows, diagnostics collection, and Red Hat customer support processes.

---

## 1️⃣ What is the purpose of collecting system diagnostic data before opening a support case?

**Answer:**

Collecting diagnostic data helps:

- Provide Red Hat engineers with system context
- Reduce back-and-forth communication
- Speed up root cause analysis
- Capture logs before they rotate
- Preserve evidence for troubleshooting

In enterprise environments, structured diagnostic data is mandatory for effective case resolution.

---

## 2️⃣ What tools can you use to gather system information in RHEL/CentOS?

**Answer:**

Common tools include:

- `inxi` – Detailed system overview
- `uname -a` – Kernel information
- `lscpu` – CPU details
- `free -h` – Memory usage
- `lsblk` – Disk layout
- `journalctl` – System logs
- `dmesg` – Kernel ring buffer
- `rpm -qa` – Installed packages list

These tools provide a full system snapshot.

---

## 3️⃣ What is the purpose of `journalctl --since "1 day ago"`?

**Answer:**

It extracts system logs from the last 24 hours.

This is useful because:

- Recent logs are most relevant to current issues
- It limits unnecessary log size
- It focuses on the incident timeframe

---

## 4️⃣ Why should diagnostic files be compressed before submission?

**Answer:**

Compression:

- Reduces file size
- Makes upload faster
- Preserves file structure
- Allows multiple artifacts in one archive

Using:

```bash
tar -czvf file.tar.gz *
````

is standard enterprise practice.

---

## 5️⃣ What are Red Hat support severity levels?

**Answer:**

Severity levels determine response priority:

* **Severity 1** – Critical system down
* **Severity 2** – Significant impact
* **Severity 3** – Moderate impact
* **Severity 4** – Low impact / informational

Choosing correct severity ensures appropriate response time.

---

## 6️⃣ What is the Red Hat Knowledge Base?

**Answer:**

It is an online repository of:

* Troubleshooting guides
* Known issue documentation
* Security advisories
* Configuration best practices
* Bug reports and fixes

It often resolves issues without needing a support case.

---

## 7️⃣ When should you escalate a support case?

**Answer:**

Escalation is appropriate when:

* Production systems are impacted
* SLAs are at risk
* Business operations are disrupted
* Initial response is delayed

Escalation must include clear business justification.

---

## 8️⃣ What information should always be included in a support case description?

**Answer:**

A proper support case should include:

* Problem description
* Steps to reproduce
* Expected vs actual behavior
* Error messages
* Logs attached
* Business impact
* Troubleshooting already performed

Structured cases are resolved faster.

---

## 9️⃣ Why is Podman testing important before escalation?

**Answer:**

Running:

```bash
podman run --rm hello-world
```

verifies:

* Container runtime functionality
* Network access
* Image pulling capability

This helps determine if issue is systemic or application-specific.

---

## 🔟 What is the difference between CentOS Stream and RHEL in support context?

**Answer:**

* **RHEL** includes official Red Hat support
* **CentOS Stream** is upstream development and does not include paid support
* Support cases require valid RHEL subscription

CentOS can simulate workflow but cannot receive enterprise support.

---

## 1️⃣1️⃣ Why is collecting `rpm -qa` useful?

**Answer:**

It provides:

* Full package inventory
* Version comparison
* Identification of outdated software
* Conflict detection

Critical for dependency-related issues.

---

## 1️⃣2️⃣ What is proactive troubleshooting in enterprise Linux?

**Answer:**

Proactive troubleshooting means:

* Monitoring logs regularly
* Updating systems
* Checking Knowledge Base first
* Collecting structured diagnostics early
* Documenting issues properly

It reduces downtime and improves operational stability.

---

## 🧠 Final Interview Insight

Enterprise Linux administrators must:

* Think methodically
* Document clearly
* Collect structured evidence
* Communicate impact effectively
* Understand escalation protocols

These skills differentiate junior administrators from enterprise-level engineers.
