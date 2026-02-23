#!/bin/bash
# Lab 02 – Remote Login to Linux Systems
# Commands Executed (Local + Remote)
# Sequential Order – No Explanations

# ==============================
# LOCAL MACHINE (Ubuntu 24.04)
# ==============================

ls ~/.ssh/

ssh-keygen -t rsa -b 4096 -C "student@lab.local"

ls ~/.ssh/

sudo apt install openssh-client -y

ssh-copy-id student@172.31.10.88

ssh student@172.31.10.88


# ==============================
# REMOTE MACHINE (CentOS 7)
# ==============================

sudo yum install openssh-server -y

sudo systemctl start sshd

sudo systemctl enable sshd

sudo nano /etc/ssh/sshd_config

sudo systemctl restart sshd

chmod 700 ~/.ssh

chmod 600 ~/.ssh/authorized_keys

whoami

hostname

sudo firewall-cmd --add-service=ssh --permanent

sudo firewall-cmd --reload
