# 🛠 Troubleshooting Guide – Lab 17: Repository and Subscription Management (RHEL 9)

---

# 1️⃣ System Not Registered

## Error:
This system is not yet registered.

## Fix:
```bash
sudo subscription-manager register
````

---

# 2️⃣ Invalid Credentials

## Error:

Invalid username or password.

## Fix:

* Verify Red Hat login
* Reset password if needed
* Ensure internet connectivity

---

# 3️⃣ No Available Subscriptions

## Error:

No subscriptions available to attach.

## Fix:

* Verify account subscription pool
* Use:

```bash
subscription-manager list --available
```

* Attach manually:

```bash
subscription-manager attach --pool=<POOL_ID>
```

---

# 4️⃣ Repository Not Found

## Error:

Repository not available

## Fix:

* Ensure correct subscription attached
* Check architecture:

```bash
arch
```

* Re-run:

```bash
subscription-manager repos --list
```

---

# 5️⃣ Podman Package Not Found

## Fix:

```bash
dnf repolist
dnf search podman
```

Ensure AppStream repo is enabled.

---

# 6️⃣ SSL / Connectivity Errors

## Check:

```bash
ping subscription.rhsm.redhat.com
```

Check firewall:

```bash
sudo firewall-cmd --list-all
```

---

# 7️⃣ Remove Registration (If Needed)

```bash
sudo subscription-manager unregister
sudo subscription-manager clean
```

---

# 🔐 Enterprise Best Practices

✔ Always register systems before production use
✔ Limit enabled repositories
✔ Avoid unnecessary third-party repos
✔ Monitor subscription expiry
✔ Automate registration using activation keys (for large environments)

---

# 🏁 Final Note

Improper subscription management can lead to:

* Security patch gaps
* Unsupported systems
* Compliance violations
* Production outages

Enterprise Linux requires disciplined entitlement management.
