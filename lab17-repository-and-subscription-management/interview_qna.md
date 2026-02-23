# 🎤 Interview Q&A – Lab 17: Repository and Subscription Management (RHEL 9)

---

## 1️⃣ What is Red Hat Subscription Manager (RHSM)?

RHSM manages system registration, entitlements, and repository access for RHEL systems.

---

## 2️⃣ Why is system registration required in RHEL?

To:
- Access official Red Hat repositories
- Receive security updates
- Maintain compliance
- Attach valid subscriptions

---

## 3️⃣ Difference between BaseOS and AppStream repositories?

- BaseOS → Core OS components
- AppStream → Applications, runtimes, development tools

---

## 4️⃣ How do you enable a repository?

```bash
subscription-manager repos --enable=<repo-id>
````

---

## 5️⃣ How do you check enabled repositories?

```bash
dnf repolist enabled
```

---

## 6️⃣ What happens if a system is not registered?

* No access to official repositories
* No updates
* Non-compliant production environment

---

## 7️⃣ How do you check subscription status?

```bash
subscription-manager status
```

---

## 8️⃣ What is CodeReady Builder?

A repository containing:

* Development libraries
* Build dependencies
* Developer tools

Used primarily for:

* Compiling software
* Development environments
