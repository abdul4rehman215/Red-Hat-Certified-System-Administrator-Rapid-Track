#!/bin/bash
# Lab 34 - Troubleshooting Network Connectivity
# Environment: CentOS/RHEL
# Commands Executed During Lab

# ==============================
# TASK 1 - BASIC CONNECTIVITY
# ==============================

ping -c 4 127.0.0.1

ip route show default
ping -c 4 192.168.1.1

ping -c 4 8.8.8.8
ping -c 4 google.com

# ==============================
# TASK 1.2 - TRACEROUTE
# ==============================

sudo dnf install -y traceroute
traceroute google.com
traceroute -n 8.8.8.8

# ==============================
# TASK 1.3 - DNS (NSLOOKUP)
# ==============================

nslookup google.com
nslookup 8.8.8.8
nslookup -type=MX google.com
nslookup -type=NS google.com
nslookup google.com 8.8.8.8

# ==============================
# TASK 2 - NETWORK CONFIG (NMCLI)
# ==============================

nmcli general status
nmcli device status
nmcli device show

nmcli connection show
nmcli connection show --active
nmcli connection show "System eth0"

sudo nmcli connection modify "System eth0" ipv4.dns "8.8.8.8,8.8.4.4"
sudo nmcli connection up "System eth0"

sudo nmcli connection modify "System eth0" ipv4.addresses "192.168.1.100/24"
sudo nmcli connection modify "System eth0" ipv4.gateway "192.168.1.1"
sudo nmcli connection modify "System eth0" ipv4.method manual
sudo nmcli connection up "System eth0"
ip addr show eth0

sudo nmcli connection modify "System eth0" ipv4.method auto
sudo nmcli connection up "System eth0"
ip addr show eth0 | grep inet

sudo nmcli connection add type ethernet con-name "lab-connection" ifname eth0

sudo nmcli connection modify "lab-connection" ipv4.addresses "192.168.1.150/24"
sudo nmcli connection modify "lab-connection" ipv4.gateway "192.168.1.1"
sudo nmcli connection modify "lab-connection" ipv4.dns "8.8.8.8"
sudo nmcli connection modify "lab-connection" ipv4.method manual

sudo nmcli connection up "lab-connection"
ip addr show eth0 | grep inet

# ==============================
# TASK 3 - FIREWALLD
# ==============================

sudo systemctl status firewalld
sudo systemctl start firewalld
sudo systemctl enable firewalld

sudo firewall-cmd --get-default-zone
sudo firewall-cmd --get-zones
sudo firewall-cmd --get-active-zones

sudo firewall-cmd --list-all
sudo firewall-cmd --zone=public --list-all

sudo firewall-cmd --get-services

sudo firewall-cmd --zone=public --add-service=http --permanent
sudo firewall-cmd --zone=public --add-service=https --permanent
sudo firewall-cmd --zone=public --add-service=ssh --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --zone=public --list-services

sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --zone=public --add-port=53/udp --permanent
sudo firewall-cmd --zone=public --add-port=3000-3005/tcp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --zone=public --list-ports

sudo firewall-cmd --zone=public --remove-port=8080/tcp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --zone=public --list-ports

sudo firewall-cmd --permanent --new-service=myapp
sudo firewall-cmd --permanent --service=myapp --set-description="My Custom Application"
sudo firewall-cmd --permanent --service=myapp --set-short="MyApp"
sudo firewall-cmd --permanent --service=myapp --add-port=9090/tcp
sudo firewall-cmd --zone=public --add-service=myapp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --zone=public --list-services

sudo firewall-cmd --zone=public --add-rich-rule='rule family="ipv4" source address="192.168.1.100" service name="ssh" accept' --permanent
sudo firewall-cmd --zone=public --add-rich-rule='rule family="ipv4" source address="192.168.1.200" service name="http" drop' --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --zone=public --list-rich-rules

# ==============================
# SCENARIO TESTING / VALIDATION
# ==============================

ping -c 2 127.0.0.1
ip route show default
ping -c 4 192.168.1.1
nslookup google.com
ping -c 4 8.8.8.8

sudo netstat -tlnp | grep 8080
sudo yum install -y nc
sudo nohup nc -lvp 8080 >/dev/null 2>&1 &
sudo netstat -tlnp | grep 8080

sudo firewall-cmd --list-all
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --zone=public --list-ports

cat /etc/resolv.conf
nslookup google.com 8.8.8.8
nslookup google.com 1.1.1.1
sudo nmcli connection modify "System eth0" ipv4.dns "8.8.8.8,8.8.4.4"
sudo nmcli connection up "System eth0"

nmcli device status
sudo nmcli device connect eth0

sudo journalctl -u firewalld -f
sudo systemctl stop firewalld

sudo systemd-resolve --flush-caches
sudo systemctl restart NetworkManager

ping -c 4 google.com
traceroute google.com

nslookup google.com
nslookup -type=MX google.com

sudo firewall-cmd --list-all
sudo systemctl start firewalld
sudo firewall-cmd --list-all

sudo nmap -p 22,80,443 localhost

nmcli connection show --active
ip addr show
ip route show
