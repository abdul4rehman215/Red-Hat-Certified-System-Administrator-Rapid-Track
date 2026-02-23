# 🎤 Interview Q&A – Lab 34: Troubleshooting Network Connectivity

---

## 1️⃣ What is the purpose of the `ping` command?

**Answer:**
`ping` tests network connectivity between two hosts using ICMP echo requests.  
It verifies:
- Host reachability
- Packet loss
- Round-trip time (latency)

It is the first step in basic network troubleshooting.

---

## 2️⃣ What does TTL mean in ping output?

**Answer:**
TTL (Time To Live) represents the number of hops a packet can pass before being discarded.  
It prevents infinite routing loops.

Lower TTL in responses usually indicates more hops between source and destination.

---

## 3️⃣ How is `traceroute` different from `ping`?

**Answer:**

| ping | traceroute |
|------|------------|
| Tests reachability | Shows path taken |
| Uses ICMP | Uses ICMP/UDP |
| Shows latency only | Shows each hop |
| Basic check | Path-level troubleshooting |

`traceroute` helps identify where packet loss or delay occurs.

---

## 4️⃣ What does the `-n` option in traceroute do?

**Answer:**
`-n` disables DNS lookups and shows only IP addresses.  
This makes traceroute faster and avoids delays caused by reverse DNS resolution.

---

## 5️⃣ What is the purpose of `nslookup`?

**Answer:**
`nslookup` is used for DNS troubleshooting.  
It performs:
- Forward lookups (domain → IP)
- Reverse lookups (IP → domain)
- Record type queries (MX, NS, etc.)

---

## 6️⃣ How do you check the default gateway in Linux?

**Answer:**

```bash
ip route show default
````

The output shows the gateway IP and associated interface.

---

## 7️⃣ What is `nmcli` and why is it important?

**Answer:**
`nmcli` is the NetworkManager command-line interface tool.

It allows administrators to:

* View device status
* Manage connections
* Configure DNS
* Assign static IPs
* Switch between DHCP and manual configurations

It replaces manual editing of configuration files in modern RHEL systems.

---

## 8️⃣ How do you configure a static IP using nmcli?

**Answer:**

```bash
sudo nmcli connection modify "System eth0" ipv4.addresses "192.168.1.100/24"
sudo nmcli connection modify "System eth0" ipv4.gateway "192.168.1.1"
sudo nmcli connection modify "System eth0" ipv4.method manual
sudo nmcli connection up "System eth0"
```

---

## 9️⃣ What is firewalld?

**Answer:**
`firewalld` is the default firewall management tool in RHEL/CentOS systems.

It provides:

* Dynamic rule management
* Zone-based security model
* Runtime and permanent configurations
* Support for services, ports, and rich rules

---

## 🔟 What is the difference between runtime and permanent firewall rules?

**Answer:**

| Runtime                  | Permanent           |
| ------------------------ | ------------------- |
| Active immediately       | Saved across reboot |
| Lost after reload/reboot | Requires reload     |
| Used for testing         | Used for production |

Example:

```bash
--add-port=8080/tcp
--add-port=8080/tcp --permanent
```

---

## 1️⃣1️⃣ What are firewalld zones?

**Answer:**
Zones define trust levels for network connections.

Common zones:

* public
* home
* internal
* dmz
* trusted

Each zone has its own rules and policies.

---

## 1️⃣2️⃣ What are rich rules in firewalld?

**Answer:**
Rich rules provide advanced filtering capabilities.

Example:

```bash
sudo firewall-cmd --zone=public \
--add-rich-rule='rule family="ipv4" source address="192.168.1.100" service name="ssh" accept' --permanent
```

They allow:

* Source-based filtering
* Protocol filtering
* Logging rules
* Accept/drop/reject actions

---

## 1️⃣3️⃣ How do you check which ports are open on a system?

**Answer:**

Using netstat:

```bash
sudo netstat -tlnp
```

Using nmap:

```bash
sudo nmap -p 22,80,443 localhost
```

---

## 1️⃣4️⃣ If you can ping 8.8.8.8 but not google.com, what is likely the issue?

**Answer:**
DNS resolution problem.

Steps:

1. Check `/etc/resolv.conf`
2. Test using `nslookup`
3. Update DNS via nmcli
4. Restart NetworkManager

---

## 1️⃣5️⃣ What is a systematic network troubleshooting approach?

**Answer:**

1. Test loopback (127.0.0.1)
2. Test gateway
3. Test external IP
4. Test DNS resolution
5. Verify routing
6. Check firewall rules
7. Confirm service listening
8. Validate logs

This structured approach minimizes guesswork.

---

# ✅ Summary

This lab covers essential RHCSA-level network troubleshooting topics:

* Connectivity testing
* DNS debugging
* NetworkManager configuration
* Firewall management
* Systematic incident resolution

