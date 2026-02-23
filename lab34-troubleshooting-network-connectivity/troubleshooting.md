
# 🛠 Troubleshooting Guide – Lab 34: Network Connectivity

> This document outlines common network issues encountered during the lab and the systematic steps used to diagnose and resolve them.

---

# 🔎 1️⃣ No Network Connectivity at All

## ❌ Problem
System cannot reach any external host.

## 🔍 Step-by-Step Diagnosis

### 1. Check Loopback Interface
```bash
ping -c 2 127.0.0.1
````

If this fails → TCP/IP stack issue.

---

### 2. Check Interface Status

```bash
nmcli device status
ip addr show
```

Look for:

* Interface state: connected
* IP address assigned

If interface is down:

```bash
sudo nmcli device connect eth0
```

---

### 3. Check Default Gateway

```bash
ip route show default
```

If no default route exists:

* Reconfigure via DHCP
* Or manually set gateway

---

### 4. Test Gateway Reachability

```bash
ping -c 4 <gateway-ip>
```

If this fails:

* Network cable issue (VM misconfig)
* VLAN mismatch
* Incorrect subnet mask

---

# 🌐 2️⃣ Can Ping IP but Not Domain Name

## ❌ Problem

External IP (8.8.8.8) works, but domain names fail.

## 🔍 Diagnosis

### 1. Check DNS Configuration

```bash
cat /etc/resolv.conf
```

### 2. Test DNS Resolution

```bash
nslookup google.com
nslookup google.com 8.8.8.8
```

## ⚠ Root Cause

DNS misconfiguration.

## ✅ Fix

Update DNS via nmcli:

```bash
sudo nmcli connection modify "System eth0" ipv4.dns "8.8.8.8,8.8.4.4"
sudo nmcli connection up "System eth0"
```

Restart NetworkManager if needed:

```bash
sudo systemctl restart NetworkManager
```

---

# 🔁 3️⃣ Static IP Misconfiguration

## ❌ Problem

After setting static IP, connectivity is lost.

## 🔍 Diagnosis

Check assigned IP:

```bash
ip addr show
```

Verify:

* Correct subnet mask
* Correct gateway
* IP not conflicting

Check routing:

```bash
ip route show
```

## ✅ Fix

Revert to DHCP:

```bash
sudo nmcli connection modify "System eth0" ipv4.method auto
sudo nmcli connection up "System eth0"
```

---

# 🔥 4️⃣ Service Not Accessible (Firewall Issue)

## ❌ Problem

Service running but cannot be accessed remotely.

## 🔍 Diagnosis

### 1. Confirm Service is Listening

```bash
sudo netstat -tlnp
```

### 2. Check Firewall Rules

```bash
sudo firewall-cmd --list-all
sudo firewall-cmd --zone=public --list-ports
```

If port missing → blocked.

---

## ✅ Fix

Open required port:

```bash
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --reload
```

Verify:

```bash
sudo firewall-cmd --zone=public --list-ports
```

---

# 🚧 5️⃣ Firewall Blocking Unexpected Traffic

## ❌ Problem

Traffic blocked even though service added.

## 🔍 Diagnosis

Check rich rules:

```bash
sudo firewall-cmd --zone=public --list-rich-rules
```

Check firewalld logs:

```bash
sudo journalctl -u firewalld -f
```

---

## ✅ Temporary Testing

Disable firewall temporarily:

```bash
sudo systemctl stop firewalld
```

⚠ Only for testing — re-enable afterward:

```bash
sudo systemctl start firewalld
```

---

# 🧭 6️⃣ Traceroute Shows Packet Drops

## ❌ Problem

Traceroute stops at intermediate hop.

## 🔍 Explanation

Possible reasons:

* ISP filtering ICMP
* Firewall blocking
* Router configured not to respond

Not always an error.

---

# 🧩 7️⃣ Interface Shows "Unmanaged"

## ❌ Problem

nmcli shows device unmanaged.

## 🔍 Cause

NetworkManager not managing the interface.

## ✅ Fix

Restart NetworkManager:

```bash
sudo systemctl restart NetworkManager
```

Ensure interface is not excluded in config files.

---

# 🗂 8️⃣ DNS Cache Issues

## ❌ Problem

Old DNS records still resolving.

## 🔍 Fix

Restart NetworkManager:

```bash
sudo systemctl restart NetworkManager
```

If systemd-resolved exists:

```bash
sudo systemd-resolve --flush-caches
```

---

# 🧠 Systematic Troubleshooting Model Used

The methodology followed in this lab:

1. Loopback test
2. Interface validation
3. Gateway test
4. External IP test
5. DNS resolution
6. Routing verification
7. Firewall inspection
8. Service validation
9. Log inspection

This layered approach isolates issues quickly.

---

# 📌 Best Practices Learned

* Always test in order: local → gateway → external → DNS
* Use `-n` in traceroute to speed up diagnostics
* Use runtime firewall rules for testing before permanent
* Confirm service is listening before blaming firewall
* Verify routing table after static IP configuration
* Keep DNS redundancy configured

---

# ✅ Conclusion

This troubleshooting process ensures:

* Faster root cause identification
* Reduced downtime
* Structured debugging methodology
* Production-ready network diagnostic skills

These practices align directly with RHCSA real-world administration scenarios.

