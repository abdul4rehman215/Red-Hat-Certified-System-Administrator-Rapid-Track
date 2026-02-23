#!/bin/bash
# ==========================================
# Lab 28: Installing and Managing Software Packages
# Commands Executed (Sequential / No Explanations)
# Environment: CentOS 7-style (yum primary)
# ==========================================

# --- Identify package manager availability ---
which dnf
which yum
yum --version

# --- Update repository metadata / system packages ---
sudo yum update -y

# --- Install individual packages ---
sudo yum install nano -y
which nano
nano --version

sudo yum install htop -y
htop --version

sudo yum install wget -y
wget --version

# --- Install multiple packages at once ---
sudo yum install tree unzip zip curl -y
tree --version
unzip -v | head -1
zip -v | head -1
curl --version | head -1

# --- Package groups ---
yum grouplist | head -25
sudo yum groupinstall "Development Tools" -y
gcc --version

# --- Query packages with rpm ---
rpm -qa | head -20
rpm -qa | wc -l

rpm -q nano
rpm -qi nano
rpm -ql nano | head -10
rpm -qf /usr/bin/nano

# --- Query/search packages with yum (dnf-equivalent) ---
yum search editor | head -20
yum list nano
yum list installed | head -20
yum info nano
yum deplist nano | head -25
yum check-update | head -25

# --- Advanced queries / providers / history / repos ---
yum provides /usr/bin/python3 | head -20
yum provides "*/bin/gcc" | head -20
yum history list | head -10

yum repolist
yum repolist all | head -25
yum --disablerepo="*" --enablerepo="epel" list available | head -15

# --- Remove packages ---
sudo yum remove tree -y
which tree

# --- Install/remove package with dependencies ---
sudo yum install httpd -y
yum deplist httpd | head -30
sudo yum remove httpd -y
sudo yum autoremove -y

# --- Update packages ---
rpm -q kernel
sudo yum update nano -y
yum info nano

yum check-update | head -15
sudo yum update -y
yum history list | head -5

# --- Reinstall / downgrade check ---
sudo yum reinstall nano -y
yum --showduplicates list nano | tail -5

# --- Cache management ---
du -sh /var/cache/yum/
sudo yum clean all
du -sh /var/cache/yum/

# --- Practical scenario: web development stack ---
sudo yum install httpd php php-mysqlnd mariadb-server git -y
rpm -q httpd php php-mysqlnd mariadb-server git
rpm -ql httpd | grep bin

sudo systemctl start httpd
sudo systemctl enable httpd
systemctl status httpd

yum check-update httpd php php-mysqlnd mariadb-server git
sudo yum update httpd git -y

sudo systemctl stop httpd
sudo systemctl disable httpd
sudo yum remove httpd php php-mysqlnd mariadb-server -y
sudo yum autoremove -y

# --- Troubleshooting / verification commands used ---
yum search package_name | head -5
df -h | head -10

rpm -q nano htop wget curl
yum --version | head -1
rpm --version
yum check-update | head -5
yum repolist enabled
