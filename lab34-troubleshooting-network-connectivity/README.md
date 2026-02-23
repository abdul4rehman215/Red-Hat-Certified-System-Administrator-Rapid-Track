# 🧪 Lab 34: Troubleshooting Network Connectivity (CentOS/RHEL)

## 🎯 Objectives
By the end of this lab, I was able to:

- Test connectivity using **ping**, **traceroute**, and **nslookup**
- Interpret common diagnostic output (latency, hops, DNS answers)
- Use **nmcli** to inspect and manage NetworkManager configurations
- Configure and validate firewall rules using **firewalld**
- Apply a systematic approach to identify and fix network issues

---

## 📌 Prerequisites
- Basic Linux CLI experience
- Basic networking (IP, DNS, ports)
- Familiarity with file editing in terminal
- Root/sudo access

---

## 🧰 Lab Environment
| Item | Value |
|------|------|
| OS | CentOS/RHEL-based |
| Access | Cloud Lab Machine (pre-configured) |
| Tools Used | ping, ip, traceroute, nslookup, nmcli, firewalld, netstat, nmap |
| Privileges | sudo/root available |
| Network | Internet access + configured interfaces |

---

## 📁 Repository Structure

```text
lab34-troubleshooting-network-connectivity/
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
├── troubleshooting.md
├── scripts/
│   └── (none required for this lab)
└── notes/
    └── (optional future: diagrams or reference cheatsheets)
````

✅ Notes:

* This lab is primarily command-line based, so **no custom scripts** were required.
* If you later want, we can add a `notes/network-checklist.md` as a personal cheat sheet (optional).

---

## ✅ Tasks Overview

### ✅ Task 1: Basic Connectivity Testing

* Verified loopback, gateway, external IP, and domain connectivity
* Used traceroute to inspect the path and isolate hop-level issues
* Used nslookup for DNS forward/reverse queries and record types

### ✅ Task 2: Network Configuration via nmcli

* Checked NetworkManager health and device states
* Inspected active connections and interface details
* Modified DNS settings, tested static IP configuration, and reverted to DHCP
* Created and activated a new Ethernet connection profile

### ✅ Task 3: Firewall Validation using firewalld

* Verified firewalld status and default zone configuration
* Added services/ports persistently and validated applied rules
* Created a custom service definition and applied it
* Implemented and verified rich rules for allow/drop scenarios

### ✅ Practical Troubleshooting Scenarios

* Diagnosed “can’t browse websites” by isolating local/gateway/DNS/external steps
* Resolved “service not accessible” by validating listener + firewall ports
* Diagnosed DNS issues and corrected resolver configuration via nmcli

---

## ✅ Result

* Confirmed working network path: local → gateway → external IP → DNS resolution
* Demonstrated nmcli-based network modifications and validation
* Implemented firewall rules (services/ports/custom services/rich rules) and verified them
* Practiced real-world troubleshooting patterns for common network incidents

---

## 🌍 Why This Matters

Network troubleshooting is essential for Linux administrators because it directly impacts:

* Availability and uptime
* Security (firewall rules and access control)
* Operational reliability (DNS, routing, interface health)

---

## 🏁 Conclusion

This lab strengthened my ability to troubleshoot connectivity issues end-to-end using Linux-native tools, manage networking through NetworkManager, and enforce access control via firewalld — using a structured, repeatable approach.
