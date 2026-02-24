# 🛡 Lab 36: Configuring Firewalld for Network Security (RHEL/CentOS 8)

> **Category:** RHCSA (Firewall / Network Security)  
> **Environment:** CentOS/RHEL 8 (Cloud Lab)  
> **User:** `centos` (sudo privileges)  

---

## 🎯 Objectives

By the end of this lab, I was able to:

- Understand **firewalld fundamentals** and its role in Linux network security
- Install, start, and manage the **firewalld** service
- Create firewall rules using `firewall-cmd` (services, ports, sources, rich rules)
- Work with **zones**, and assign interfaces to the correct zone
- Validate firewall rules using tools like `nmap`, `telnet`, `nc`, and `curl`
- Implement secure communication policies using zones/services
- Troubleshoot common firewall issues safely and systematically

---

## ✅ Prerequisites

- Basic Linux CLI usage
- Networking basics: IPs, ports, TCP/UDP, services
- Basic system administration commands
- Common services: SSH, HTTP, HTTPS

---

## 🧰 Lab Environment

- CentOS/RHEL 8 system with **root access**
- `firewalld` package already installed
- Network connectivity for testing
- Multiple interfaces available (used for zone configuration in the lab flow)

---

## 📌 Repository Structure

```text
lab-16-configuring-firewalld/
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
└── troubleshooting.md
````

> ✅ **Note:** This lab primarily uses command-line administration.
> No standalone custom scripts were created (only commands + generated configuration state).

---

## 🧩 Task Overview 

### 🔥 Task 1: Create Firewall Rules Using Firewalld (Rule Building)

* Verify firewalld installation and service state
* Inspect current rules, default zone, and active zones
* Add allowed services (`http`, `https`) and ports (`8080/tcp`, `3000-3005/tcp`)
* Apply advanced rules:

  * Allow sources (IP and subnet)
  * Block a specific IP using a rich rule
  * Allow SSH only from a specific trusted IP using rich rules

### 🧪 Task 2: Test Firewall Configuration (Validation)

* Install tools: `nmap`, `telnet`, `nc`
* Install `httpd` and host a test page
* Validate access:

  * Local HTTP test with `curl`
  * Port scans using `nmap`
  * Connectivity checks using `telnet` and `nc`

### 🌐 Task 3: Zones & Secure Communication (Security Architecture)

* Review all zones and their purpose
* Create a custom zone `webserver`
* Configure allowed services/ports in that zone
* Move interface `eth0` into the custom zone
* Configure internal + dmz logic for segmented access policies
* Add additional rich rules (rate limits + logging)

---

## 🔐 Security Relevance 

Firewalld is often the **first line of defense** for Linux servers.

This lab demonstrates:

* **Service-based allowlisting** (more readable than raw ports)
* **Zone-based segmentation** (public vs internal vs dmz vs custom webserver)
* **IP-based access control** (trusted sources)
* **Rich rules** for granular control (drop/accept by IP, rate limiting, logging)
* Testing and verification to prevent accidental lockouts

---

## ✅ Results Achieved 

By the end of the provided run:

* `firewalld` was running and enabled at boot
* Services added: `http`, `https`, `ssh` (plus existing `cockpit`, `dhcpv6-client`)
* Ports added: `8080/tcp`, `3000-3005/tcp`
* Advanced source rules:

  * Allowed: `192.168.1.100`, `192.168.1.0/24`
  * Blocked: `192.168.1.50` (rich rule drop)
  * Allowed SSH from `192.168.1.100` (rich rule accept)
* Testing confirmed open ports and working HTTP content

---

## 🧪 Quick Verification Checklist (What to Check After Setup)

Run these after applying rules:

```bash
sudo firewall-cmd --state
sudo firewall-cmd --get-default-zone
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --list-all
sudo firewall-cmd --list-rich-rules
```

Test access:

```bash
curl http://localhost
nmap -p 22,80,8080 localhost
telnet localhost 8080
nc -zv localhost 3306
```
