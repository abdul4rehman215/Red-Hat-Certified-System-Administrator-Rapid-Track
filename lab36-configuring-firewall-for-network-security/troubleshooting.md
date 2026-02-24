# 🛠 Troubleshooting Guide – Lab 36: COnfiguring Firewall for Network Security (Firewalld)

---

# 🔥 Issue 1: Firewalld Service Not Starting

## ❌ Problem
`firewalld` fails to start.

## 🔎 Diagnosis

```bash
sudo systemctl status firewalld
````

Check for conflicting services:

```bash
sudo systemctl status iptables
```

## ✅ Resolution

If iptables is running:

```bash
sudo systemctl stop iptables
sudo systemctl disable iptables
sudo systemctl restart firewalld
```

---

# 🚫 Issue 2: Rules Not Taking Effect

## ❌ Problem

Rules were added but not working.

## 🔎 Check

```bash
sudo firewall-cmd --list-all
```

Check permanent configuration:

```bash
sudo firewall-cmd --list-all --permanent
```

## ✅ Fix

Reload firewall:

```bash
sudo firewall-cmd --reload
```

---

# 🔐 Issue 3: Service Not Accessible

## ❌ Problem

HTTP or SSH not reachable.

## 🔎 Steps

1. Verify service is allowed:

```bash
sudo firewall-cmd --list-services
```

2. Check active zone:

```bash
sudo firewall-cmd --get-active-zones
```

3. Confirm interface assignment:

```bash
sudo firewall-cmd --zone=webserver --list-all
```

---

# 🌐 Issue 4: Port Still Blocked

## ❌ Problem

Custom port inaccessible.

## 🔎 Check

```bash
sudo firewall-cmd --list-ports
```

## ✅ Add port

```bash
sudo firewall-cmd --add-port=8080/tcp --permanent
sudo firewall-cmd --reload
```

---

# 🧠 Issue 5: Rich Rules Conflicting

## ❌ Problem

Traffic unexpectedly blocked.

## 🔎 Check

```bash
sudo firewall-cmd --list-rich-rules
```

Rich rules are processed in order — a drop rule may override accept rules.

## ✅ Fix

Remove incorrect rule:

```bash
sudo firewall-cmd --remove-rich-rule='rule source address="X.X.X.X" drop' --permanent
sudo firewall-cmd --reload
```

---

# 📊 Issue 6: Zone Assignment Problems

## ❌ Problem

Correct rules exist but still not applied.

## 🔎 Check zone assignment

```bash
sudo firewall-cmd --get-active-zones
```

## ✅ Assign interface

```bash
sudo firewall-cmd --zone=webserver --change-interface=eth0 --permanent
sudo firewall-cmd --reload
```

---

# 🧪 Testing Commands Reference

```bash
curl http://localhost
nmap -p 22,80,443 localhost
telnet localhost 3306
nc -zv localhost 8080
```

---

# 🛡 Best Practices

* Always use `--permanent` for production rules
* Reload after changes
* Use zones for segmentation
* Prefer services over ports
* Use rich rules carefully
* Log dropped traffic
* Verify using network tools

---

# 🏁 Final Notes

This troubleshooting approach ensures:

* Firewall is correctly configured
* Services remain accessible
* Security policies are enforced
* Network segmentation is effective

Firewalld is foundational for Linux server security and RHCSA certification readiness.
