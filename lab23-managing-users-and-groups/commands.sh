#!/bin/bash
# Lab 23: Managing Users and Groups
# All commands executed sequentially in the lab environment
# Environment: CentOS/RHEL Cloud VM
# Shell: Bash 4.2
# Privilege: Root (via sudo su -)

############################################################
# TASK 1: Review Existing Users & Switch to Root
############################################################

cat /etc/passwd | tail -5
whoami
sudo su -

############################################################
# TASK 1: Create Basic Users
############################################################

useradd john
grep john /etc/passwd
ls -la /home/

############################################################
# Create Users with Custom Options
############################################################

useradd -m -d /home/custom_jane jane
useradd -s /bin/bash mike
useradd -c "Sarah Johnson" sarah
useradd -u 1500 tom
useradd -c "Alice Smith" -m -d /home/alice_home -s /bin/bash -u 1501 alice

############################################################
# Verify User Creation
############################################################

grep -E "john|jane|mike|sarah|tom|alice" /etc/passwd
ls -la /home/
id john
id alice

############################################################
# TASK 2: Set User Passwords
############################################################

passwd john
passwd jane
passwd mike
passwd sarah

############################################################
# Modify User Accounts
############################################################

usermod -c "John Doe - Developer" john
usermod -d /home/john_new -m john

yum install -y zsh
usermod -s /bin/zsh sarah

usermod -u 1502 mike

usermod -L tom
usermod -U tom

############################################################
# Verify Modifications
############################################################

grep -E "john|sarah|mike|tom" /etc/passwd
passwd -S john
passwd -S tom

su - john
whoami
pwd
exit

############################################################
# TASK 3: Create Groups
############################################################

groupadd developers
groupadd testers
groupadd managers
groupadd -g 2000 admins
groupadd -r sysops

grep -E "developers|testers|managers|admins|sysops" /etc/group
getent group developers
getent group admins

############################################################
# Add Users to Groups
############################################################

usermod -g developers john
usermod -G testers,managers jane
usermod -a -G developers,admins mike
gpasswd -a sarah developers
gpasswd -M alice,tom testers

############################################################
# Verify Group Membership
############################################################

groups john
groups jane
groups mike

getent group developers
getent group testers
getent group managers

id john
id jane

############################################################
# Modify Group Properties
############################################################

groupmod -n development developers
groupmod -g 2001 admins     # Fails (GID exists)
groupmod -g 2004 admins

getent group development
getent group admins

############################################################
# TASK 4: Remove Users from Groups
############################################################

gpasswd -d tom testers
usermod -G "" alice

groups tom
groups alice

############################################################
# Delete Users
############################################################

userdel tom
userdel -r alice
userdel -f mike

grep -E "tom|alice|mike" /etc/passwd
ls -la /home/

############################################################
# Delete Groups
############################################################

getent group testers
groupdel testers

groupdel development      # Fails (primary group issue)

gpasswd -d john development
gpasswd -d sarah development

usermod -g john john
groupdel development

getent group testers
getent group development

############################################################
# Cleanup Remaining Users
############################################################

userdel -r john
userdel -r jane
userdel -r sarah

groupdel managers
groupdel admins
groupdel sysops

grep -E "john|jane|sarah|tom|alice|mike" /etc/passwd
grep -E "developers|testers|managers|admins|sysops" /etc/group

############################################################
# ADVANCED CONCEPTS: System Files
############################################################

head -5 /etc/passwd
head -5 /etc/group
head -5 /etc/shadow

############################################################
# Security Best Practices Demonstration
############################################################

useradd secuser
passwd secuser

chage -M 90 secuser
chage -m 7 secuser
chage -W 7 secuser
chage -l secuser

chage -E 2026-12-31 secuser
usermod -L -e 1 secuser

############################################################
# Verification Commands
############################################################

cut -d: -f1 /etc/passwd | sort | tail -10
cut -d: -f1 /etc/group | sort | tail -10

id secuser
groups secuser

yum install -y finger
finger secuser

getent group wheel

passwd -S secuser
chage -l secuser

############################################################
# END OF LAB 23
############################################################
