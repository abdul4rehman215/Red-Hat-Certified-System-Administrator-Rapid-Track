# 🎯 Interview Q&A - Lab 33: Configuring IP Addresses & Hostnames  

---

## 🔹 Basic Level Questions

### 1️⃣ What is NetworkManager?
**Answer:**  
NetworkManager is a service that manages network connections on Linux systems. It simplifies configuring IP addresses, DNS, gateways, and network interfaces. It can be managed via:
- `nmcli` (CLI)
- `nmtui` (Text UI)
- GUI tools

---

### 2️⃣ What is nmcli?
**Answer:**  
`nmcli` (NetworkManager Command Line Interface) is a command-line tool used to configure and manage network connections, devices, and profiles in Linux.

---

### 3️⃣ How do you list all network connections?
```bash
nmcli connection show
````

---

### 4️⃣ How do you check active network connections?

```bash
nmcli connection show --active
```

---

### 5️⃣ Difference between dynamic and static IP?

| Dynamic IP (DHCP)      | Static IP           |
| ---------------------- | ------------------- |
| Assigned automatically | Manually configured |
| May change             | Fixed and permanent |
| Used for clients       | Used for servers    |

---

## 🔹 Intermediate Level Questions

### 6️⃣ How do you configure a static IP using nmcli?

You:

1. Create connection profile
2. Set IPv4 method to manual
3. Define IP, gateway, DNS
4. Activate connection

---

### 7️⃣ Why are connection profiles important?

Connection profiles:

* Store IP configuration
* Allow multiple configurations per interface
* Enable switching between network setups
* Support autoconnect priority

---

### 8️⃣ What is the purpose of connection.autoconnect?

It determines whether a connection profile automatically activates at boot or when the interface becomes available.

---

### 9️⃣ How do you verify the default gateway?

```bash
ip route show
```

Look for:

```
default via <gateway-ip>
```

---

### 🔟 How do you check DNS configuration?

```bash
cat /etc/resolv.conf
```

Or:

```bash
nmcli device show
```

---

## 🔹 Advanced Level Questions

### 1️⃣1️⃣ What is the difference between static, pretty, and transient hostname?

| Type      | Description                                  |
| --------- | -------------------------------------------- |
| Static    | Permanent hostname stored in `/etc/hostname` |
| Pretty    | Human-readable display name                  |
| Transient | Temporary hostname (changes after reboot)    |

---

### 1️⃣2️⃣ Which file stores the system hostname?

```
/etc/hostname
```

---

### 1️⃣3️⃣ What is the purpose of `/etc/hosts`?

It provides local hostname-to-IP resolution before DNS is queried.

Example:

```
192.168.1.100 lab-server-01.localdomain lab-server-01
```

---

### 1️⃣4️⃣ How do you test DNS resolution?

```bash
nslookup google.com
dig google.com
```

---

### 1️⃣5️⃣ How do you troubleshoot no internet connectivity?

Steps:

1. Check IP address (`ip addr`)
2. Check default route (`ip route`)
3. Check DNS (`/etc/resolv.conf`)
4. Test ping by IP (8.8.8.8)
5. Test ping by domain (google.com)

---

## 🔹 Scenario-Based Questions

### 🧠 Scenario 1:

You can ping IP addresses but not domain names. What is wrong?

**Answer:**
DNS configuration issue. Check `/etc/resolv.conf` and connection DNS settings.

---

### 🧠 Scenario 2:

After reboot, static IP is lost. Why?

**Answer:**
Connection profile not set to manual or not enabled for autoconnect.

---

### 🧠 Scenario 3:

Multiple profiles exist on same interface. What happens?

**Answer:**
Only one active connection can control the interface at a time. Conflicts may prevent activation.

---

## 🔹 RHCSA Exam Tips

✔ Remember nmcli syntax
✔ Know difference between profile and device
✔ Understand manual vs auto IPv4 method
✔ Verify using ip + nmcli + route commands
✔ Always test DNS separately

---

# ✅ Final Takeaway

Understanding static IP configuration and hostname management is critical for:

* Server deployment
* Enterprise network configuration
* Cloud VM setup
* Troubleshooting connectivity issues
* RHCSA certification preparation

