# 🛠️ Troubleshooting Guide - Lab 33: Confuguring Network & Hostname
(RHEL / CentOS – nmcli + hostnamectl)

---

# 🔎 1️⃣ Connection Fails to Activate

## ❌ Symptom
- `nmcli connection up` fails
- Interface disconnects
- No IP assigned

## 🔍 Diagnosis

Check device status:
```bash
nmcli device status
````

Check connection profiles:

```bash
nmcli connection show
```

Check if another profile is controlling the interface.

## ✅ Fix

Deactivate conflicting profile:

```bash
sudo nmcli connection down "System eth0"
```

Activate intended profile:

```bash
sudo nmcli connection up "static-connection"
```

If wrong interface name:

```bash
nmcli device status
```

Modify profile accordingly.

---

# 🔎 2️⃣ No Internet Connectivity

## ❌ Symptom

* Local network works
* Cannot reach 8.8.8.8

## 🔍 Diagnosis

Check default route:

```bash
ip route
```

Expected:

```
default via 192.168.1.1 dev eth0
```

## ✅ Fix Gateway

```bash
sudo nmcli connection modify "static-connection" ipv4.gateway 192.168.1.1
sudo nmcli connection up "static-connection"
```

---

# 🔎 3️⃣ DNS Not Resolving

## ❌ Symptom

* Ping by IP works
* Ping by domain fails

## 🔍 Diagnosis

Check DNS:

```bash
cat /etc/resolv.conf
```

Check profile DNS:

```bash
nmcli connection show "static-connection"
```

## ✅ Fix DNS

```bash
sudo nmcli connection modify "static-connection" ipv4.dns "8.8.8.8,8.8.4.4"
sudo nmcli connection up "static-connection"
```

Test:

```bash
ping google.com
```

---

# 🔎 4️⃣ IP Address Conflict

## ❌ Symptom

* Intermittent connectivity
* ARP conflicts
* Network unstable

## 🔍 Diagnosis

Ping your own IP:

```bash
ping 192.168.1.100
```

Check for duplicate devices on network.

## ✅ Fix

Assign new IP:

```bash
sudo nmcli connection modify "static-connection" ipv4.addresses 192.168.1.110/24
sudo nmcli connection up "static-connection"
```

---

# 🔎 5️⃣ Hostname Does Not Persist

## ❌ Symptom

Hostname resets after reboot.

## 🔍 Diagnosis

Check:

```bash
cat /etc/hostname
hostnamectl status
```

## ✅ Fix

Set static hostname:

```bash
sudo hostnamectl set-hostname lab-server-01
```

Ensure correct permissions:

```bash
sudo chmod 644 /etc/hostname
```

Restart hostnamed:

```bash
sudo systemctl restart systemd-hostnamed
```

---

# 🔎 6️⃣ Hostname Resolution Fails

## ❌ Symptom

Cannot ping local hostname.

## 🔍 Diagnosis

Check hosts file:

```bash
cat /etc/hosts
```

Expected entry:

```
192.168.1.100 lab-server-01.localdomain lab-server-01
```

## ✅ Fix

Edit:

```bash
sudo nano /etc/hosts
```

Add correct mapping.

---

# 🔎 7️⃣ Multiple Profiles Conflict

## ❌ Symptom

Interface connects to wrong profile.

## 🔍 Diagnosis

```bash
nmcli connection show
nmcli connection show --active
```

## ✅ Fix Autoconnect Priority

Enable primary:

```bash
sudo nmcli connection modify "static-connection" connection.autoconnect yes
sudo nmcli connection modify "static-connection" connection.autoconnect-priority 10
```

Disable backup:

```bash
sudo nmcli connection modify "backup-connection" connection.autoconnect no
```

---

# 🔎 8️⃣ NetworkManager Not Running

## ❌ Symptom

nmcli not responding.

## 🔍 Diagnosis

```bash
systemctl status NetworkManager
```

## ✅ Fix

```bash
sudo systemctl start NetworkManager
sudo systemctl enable NetworkManager
```

---

# 🧠 Systematic Network Troubleshooting Flow

1. Check interface state → `nmcli device status`
2. Check IP address → `ip addr`
3. Check route → `ip route`
4. Check DNS → `/etc/resolv.conf`
5. Test ping by IP
6. Test ping by hostname
7. Check hostname settings
8. Restart NetworkManager if needed

---

# ⚠️ High-Risk Configuration Files

| File                    | Risk   |
| ----------------------- | ------ |
| /etc/hostname           | Medium |
| /etc/hosts              | Medium |
| /etc/resolv.conf        | High   |
| NetworkManager profiles | High   |

---

# ✅ Final Administrator Rule

When troubleshooting networking:

✔ Always test IP first
✔ Then test gateway
✔ Then test DNS
✔ Verify hostname resolution separately
✔ Avoid editing resolv.conf manually (managed by NetworkManager)

---

# 🏁 Lab 13 Completed

I now understand:

* Static IP configuration using nmcli
* Multiple network profile management
* DNS and gateway configuration
* Hostname management (static/pretty/transient)
* Persistence verification
* Structured network troubleshooting

These are core RHCSA networking skills and foundational for enterprise Linux administration.
