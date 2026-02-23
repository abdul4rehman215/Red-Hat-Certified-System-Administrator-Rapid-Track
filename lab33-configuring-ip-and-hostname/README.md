# 🧪 Lab 33: Configuring IP Addresses and Hostnames (RHEL)

## 📌 Overview
This lab focuses on configuring **static IPv4 addressing** and **hostnames** on a RHEL/CentOS system using **NetworkManager (nmcli)** and **hostnamectl**. It also includes validation steps and basic troubleshooting practices to ensure changes are persistent.

---

## 🎯 Objectives
By the end of this lab, I was able to:
- Configure a **static IPv4 address** using `nmcli`
- Create and manage **multiple network connection profiles**
- Switch between profiles safely (primary vs backup)
- Configure DNS settings per connection
- Change system hostnames using `hostnamectl` (static/pretty/transient)
- Update `/etc/hosts` for local hostname resolution
- Validate connectivity and confirm persistence

---

## ✅ Prerequisites
To complete this lab, I needed:
- Basic Linux command-line knowledge
- Understanding of IP addressing, subnet masks, and gateways
- Root/sudo privileges
- NetworkManager installed and running
- Internet connectivity for testing

---

## 🖥️ Lab Environment
- OS: RHEL / CentOS (8/9)
- Network: NetworkManager enabled
- Tools Used:
  - nmcli (NetworkManager CLI)
  - ip / ping / dig / nslookup
  - hostnamectl
  - /etc/hosts and /etc/hostname

---

## 🧩 What I Performed (Task Summary)

### Task 1 — Static IP Configuration
- Checked existing network connections and active interface
- Created a new static connection profile
- Assigned static IPv4 address, gateway, and DNS
- Activated the profile and verified IP + connectivity

### Task 2 — Managing Multiple Network Profiles
- Created a backup network profile for failover
- Switched between profiles
- Configured autoconnect priority and behavior

### Task 3 — Hostname Configuration
- Verified current hostname settings
- Configured static, pretty, and transient hostnames
- Updated `/etc/hosts` to ensure local hostname resolution
- Verified hostname persistence

---

## ✅ Verification Checklist
- Interface shows correct static IP after activation
- Default route/gateway is correctly applied
- DNS resolution works (domain ping + dig/nslookup)
- Hostname reflects updated values
- Hostname resolves locally via `/etc/hosts`
- Network changes remain after restarting NetworkManager

---

## 🛠️ Troubleshooting Covered
Common issues addressed in this lab:
- Connection fails to activate due to conflicts
- No internet caused by wrong gateway/DNS
- Hostname not persisting across reboots
- Hostname resolution failures from incorrect hosts entries

(Full troubleshooting steps are documented in `troubleshooting.md`.)

---

## 🧠 What I Learned
- How NetworkManager profiles work and why connection profiles matter
- Why static IP addressing is important for servers and infrastructure
- How hostname types differ (static vs transient vs pretty)
- How `/etc/hosts` can override or supplement DNS resolution
- How to validate configuration changes properly

---

## 🌍 Why This Matters (Real-World Relevance)
These skills are essential because:
- Servers often require **static IPs** for reliable access
- Hostnames are critical for **service identification**, monitoring, and automation
- Correct DNS and routing ensures **stable production networking**
- Multi-profile setup improves **availability and recovery** options

---

## ✅ Result
At the end of this lab:
- The system successfully used a static IPv4 configuration
- Multiple connection profiles were created and managed correctly
- Hostname configuration was applied and verified
- Connectivity and persistence checks confirmed working configuration
