#!/bin/bash
# Lab 33 - Configuring IP Addresses and Hostnames
# Commands Executed During Lab

# ----------------------------
# Task 1: Inspect Current Network Configuration
# ----------------------------

nmcli connection show
nmcli connection show --active
ip addr show
systemctl status NetworkManager
nmcli device status

# ----------------------------
# Task 2: Create Static IP Connection
# ----------------------------

sudo nmcli connection add \
 type ethernet \
 con-name "static-connection" \
 ifname eth0 \
 ip4 192.168.1.100/24 \
 gw4 192.168.1.1

sudo nmcli connection modify "static-connection" \
 ipv4.dns "8.8.8.8,8.8.4.4"

sudo nmcli connection modify "static-connection" \
 ipv4.method manual

sudo nmcli connection up "static-connection"

nmcli connection show --active
ip addr show eth0
ping -c 4 8.8.8.8

# ----------------------------
# Task 3: Manage Multiple Profiles
# ----------------------------

nmcli device show

sudo nmcli connection add \
 type ethernet \
 con-name "backup-connection" \
 ifname eth0 \
 ip4 192.168.1.101/24 \
 gw4 192.168.1.1

sudo nmcli connection modify "backup-connection" \
 ipv4.dns "1.1.1.1,1.0.0.1" \
 ipv4.method manual

nmcli connection show

sudo nmcli connection down "static-connection"
sudo nmcli connection up "backup-connection"

ip addr show eth0
ping -c 4 google.com

# ----------------------------
# Task 4: Configure Auto-Connect
# ----------------------------

sudo nmcli connection modify "static-connection" \
 connection.autoconnect yes

sudo nmcli connection modify "static-connection" \
 connection.autoconnect-priority 10

sudo nmcli connection modify "backup-connection" \
 connection.autoconnect no

# ----------------------------
# Task 5: Hostname Configuration
# ----------------------------

hostnamectl status
hostname
cat /etc/hostname

sudo hostnamectl set-hostname "lab-server-01"
sudo hostnamectl set-hostname "Lab Server 01" --pretty
sudo hostnamectl set-hostname "temp-lab-server" --transient

hostnamectl status

sudo nano /etc/hosts
tail -5 /etc/hosts

ping -c 2 lab-server-01
nslookup lab-server-01

# ----------------------------
# Verification
# ----------------------------

sudo systemctl restart NetworkManager

nmcli connection show --active
ip addr show
hostnamectl status
hostname -f

ping -c 4 8.8.8.8
ping -c 4 google.com
ping -c 2 lab-server-01

nslookup google.com
dig google.com

# ----------------------------
# Troubleshooting Checks
# ----------------------------

ip route show
cat /etc/resolv.conf
nmcli connection show
nmcli device status

sudo chmod 644 /etc/hostname
sudo systemctl restart systemd-hostnamed

cat /etc/hosts
cat /etc/resolv.conf

# ----------------------------
# Cleanup (Optional)
# ----------------------------

sudo nmcli connection delete "static-connection"
sudo nmcli connection delete "backup-connection"

sudo hostnamectl set-hostname "localhost.localdomain"

sudo cp /etc/hosts /etc/hosts.backup
sudo nano /etc/hosts
