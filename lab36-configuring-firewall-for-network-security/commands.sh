#!/bin/bash
# Lab 36: Configuring Firewalld for Network Security
# Commands Executed

# ----------------------------
# Task 1: Install + Start firewalld
# ----------------------------

rpm -qa | grep firewalld
sudo dnf install firewalld -y

sudo systemctl start firewalld
sudo systemctl enable firewalld

sudo systemctl status firewalld
sudo firewall-cmd --state

# ----------------------------
# Task 1.2: Inspect firewalld configuration
# ----------------------------

sudo firewall-cmd --list-all
sudo firewall-cmd --get-zones
sudo firewall-cmd --get-default-zone
sudo firewall-cmd --get-active-zones

# ----------------------------
# Task 1.3: Basic rules (services + ports)
# ----------------------------

sudo firewall-cmd --add-service=http
sudo firewall-cmd --add-service=http --permanent
sudo firewall-cmd --add-service=https --permanent

sudo firewall-cmd --add-port=8080/tcp --permanent
sudo firewall-cmd --add-port=3000-3005/tcp --permanent

sudo firewall-cmd --reload
sudo firewall-cmd --list-all

# ----------------------------
# Task 1.4: Advanced rules (sources + rich rules)
# ----------------------------

sudo firewall-cmd --add-source=192.168.1.100 --permanent
sudo firewall-cmd --add-source=192.168.1.0/24 --permanent

sudo firewall-cmd --add-rich-rule='rule source address="192.168.1.50" drop' --permanent
sudo firewall-cmd --add-rich-rule='rule source address="192.168.1.100" service name="ssh" accept' --permanent

sudo firewall-cmd --reload
sudo firewall-cmd --list-all

# ----------------------------
# Task 2: Install testing tools + web server for validation
# ----------------------------

sudo dnf install nmap telnet nc -y

sudo dnf install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd

echo "<h1>Firewall Test Page</h1>" | sudo tee /var/www/html/index.html

# ----------------------------
# Task 2.2: Test HTTP + Port access
# ----------------------------

curl http://localhost
curl http://52.14.201.88

nmap -p 80 localhost
telnet localhost 8080

# ----------------------------
# Task 2.3: Test SSH access
# ----------------------------

sudo firewall-cmd --list-services | grep ssh

ssh localhost
nmap -p 22 localhost

# ----------------------------
# Task 2.4: Test blocked ports
# ----------------------------

telnet localhost 3306
nmap localhost
nc -zv localhost 3306

# ----------------------------
# Task 3: Zones + secure communication policy
# ----------------------------

sudo firewall-cmd --list-all-zones

sudo firewall-cmd --zone=public --list-all
sudo firewall-cmd --zone=internal --list-all
sudo firewall-cmd --zone=dmz --list-all

sudo firewall-cmd --new-zone=webserver --permanent
sudo firewall-cmd --reload

sudo firewall-cmd --get-zones

sudo firewall-cmd --zone=webserver --add-service=http --permanent
sudo firewall-cmd --zone=webserver --add-service=https --permanent
sudo firewall-cmd --zone=webserver --add-service=ssh --permanent

sudo firewall-cmd --zone=webserver --add-port=8080/tcp --permanent

sudo firewall-cmd --zone=webserver --set-description="Web Server Zone for HTTP/HTTPS traffic" --permanent

sudo firewall-cmd --reload
sudo firewall-cmd --zone=webserver --list-all

ip addr show
sudo firewall-cmd --get-active-zones

sudo firewall-cmd --zone=webserver --change-interface=eth0 --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --get-active-zones

sudo firewall-cmd --zone=internal --add-service=ssh --permanent
sudo firewall-cmd --zone=internal --add-service=samba --permanent
sudo firewall-cmd --zone=internal --add-service=nfs --permanent

sudo firewall-cmd --zone=internal --add-source=192.168.1.0/24 --permanent
sudo firewall-cmd --zone=internal --add-source=10.0.0.0/8 --permanent

sudo firewall-cmd --zone=dmz --add-service=http --permanent
sudo firewall-cmd --zone=dmz --add-service=https --permanent
sudo firewall-cmd --zone=dmz --add-port=8080/tcp --permanent

sudo firewall-cmd --reload
sudo firewall-cmd --zone=internal --list-all
sudo firewall-cmd --zone=dmz --list-all

# ----------------------------
# Task 3.5: Rich rules (advanced security)
# ----------------------------

sudo firewall-cmd --add-rich-rule='rule source address="192.168.1.0/24" service name="ssh" accept' --permanent

sudo firewall-cmd --zone=internal --add-rich-rule='rule source address="0.0.0.0/0" drop' --permanent
sudo firewall-cmd --zone=internal --add-rich-rule='rule source address="192.168.1.0/24" accept' --permanent

sudo firewall-cmd --add-rich-rule='rule service name="ssh" accept limit value="3/m"' --permanent
sudo firewall-cmd --add-rich-rule='rule drop log prefix="FIREWALL-DROP: " level="warning"' --permanent

sudo firewall-cmd --reload
sudo firewall-cmd --list-rich-rules

# ----------------------------
# Task 3.6: Validate zone behavior + logging
# ----------------------------

sudo firewall-cmd --zone=public --list-services
sudo firewall-cmd --zone=internal --list-services

nmap -p 22,80,443 localhost
sudo journalctl -u firewalld -f

sudo firewall-cmd --get-active-zones
sudo firewall-cmd --list-all-zones | grep -A 10 "webserver"

# ----------------------------
# Troubleshooting + verification commands
# ----------------------------

sudo systemctl status iptables
sudo systemctl stop iptables
sudo systemctl disable iptables

sudo systemctl restart firewalld

sudo firewall-cmd --reload
sudo firewall-cmd --list-all --permanent

sudo firewall-cmd --get-default-zone
sudo firewall-cmd --list-services
sudo firewall-cmd --get-active-zones

sudo firewall-cmd --get-zones
sudo firewall-cmd --zone=webserver --list-all

sudo firewall-cmd --reload

sudo systemctl status firewalld
sudo firewall-cmd --state

sudo firewall-cmd --list-all
sudo firewall-cmd --zone=internal --list-all

sudo firewall-cmd --list-rich-rules

nmap -p 80 localhost
telnet localhost 3306
