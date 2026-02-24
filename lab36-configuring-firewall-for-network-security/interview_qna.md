# 🎤 Interview Q&A – Lab 36: Firewalld (RHCSA Level)

---

## 1️⃣ What is firewalld?

**Answer:**
Firewalld is a dynamic firewall management tool for Linux systems.  
It provides a high-level interface to manage iptables/nftables using zones and services instead of raw rule syntax.

---

## 2️⃣ What is the difference between runtime and permanent configuration?

**Answer:**

| Runtime | Permanent |
|----------|------------|
| Active immediately | Saved across reboots |
| Lost after reboot | Requires `--reload` to apply |
| Default when no `--permanent` is used | Stored in `/etc/firewalld/` |

Example:
```bash
sudo firewall-cmd --add-service=http
sudo firewall-cmd --add-service=http --permanent
sudo firewall-cmd --reload
````

---

## 3️⃣ What are zones in firewalld?

**Answer:**
Zones define the trust level of network connections.

Examples:

* `public` → Untrusted networks
* `internal` → Trusted internal network
* `dmz` → Semi-trusted zone
* `trusted` → All traffic accepted
* `block/drop` → Strict filtering

---

## 4️⃣ How do you check the active zone?

```bash
sudo firewall-cmd --get-active-zones
```

It shows which interfaces are assigned to which zone.

---

## 5️⃣ How do you assign an interface to a zone?

```bash
sudo firewall-cmd --zone=webserver --change-interface=eth0 --permanent
sudo firewall-cmd --reload
```

---

## 6️⃣ How do you allow a service in firewalld?

```bash
sudo firewall-cmd --add-service=http --permanent
sudo firewall-cmd --reload
```

Services are preferred over raw ports because they are predefined and more readable.

---

## 7️⃣ How do you open a specific port?

```bash
sudo firewall-cmd --add-port=8080/tcp --permanent
sudo firewall-cmd --reload
```

---

## 8️⃣ What is a rich rule?

**Answer:**
A rich rule allows granular filtering beyond basic services and ports.

Example:

```bash
sudo firewall-cmd --add-rich-rule='rule source address="192.168.1.50" drop' --permanent
```

Rich rules allow:

* IP-based control
* Logging
* Rate limiting
* Accept/drop rules
* Service restrictions per source

---

## 9️⃣ How do you list all firewall rules?

```bash
sudo firewall-cmd --list-all
sudo firewall-cmd --list-rich-rules
```

---

## 🔟 How do you troubleshoot if rules are not applied?

1. Ensure `--reload` was executed.
2. Check permanent configuration:

```bash
sudo firewall-cmd --list-all --permanent
```

3. Verify active zone:

```bash
sudo firewall-cmd --get-active-zones
```

---

## 1️⃣1️⃣ What command checks firewalld status?

```bash
sudo systemctl status firewalld
sudo firewall-cmd --state
```

---

## 1️⃣2️⃣ How do you log dropped packets?

```bash
sudo firewall-cmd --add-rich-rule='rule drop log prefix="FIREWALL-DROP: " level="warning"' --permanent
sudo firewall-cmd --reload
```

Logs can be viewed using:

```bash
sudo journalctl -u firewalld
```

---

## 1️⃣3️⃣ How can you rate limit SSH connections?

```bash
sudo firewall-cmd --add-rich-rule='rule service name="ssh" accept limit value="3/m"' --permanent
```

This helps prevent brute-force attacks.

---

## 1️⃣4️⃣ Where are firewalld configurations stored?

Permanent configurations are stored in:

```
/etc/firewalld/zones/
/etc/firewalld/services/
```

---

## 1️⃣5️⃣ Why is firewalld important in enterprise environments?

* First line of defense
* Enforces network segmentation
* Reduces attack surface
* Supports logging and monitoring
* Required knowledge for RHCSA

---

# ✅ Summary

This lab demonstrated:

* Service-based rule management
* Port-based control
* Zone-based segmentation
* Rich rule creation
* Testing and validation using network tools
* Secure production-level firewall configuration
