
---

# 📄 2️⃣ commands.sh (ONLY commands executed)

```bash
#!/bin/bash
# Lab 20: Configuring and Mounting NFS (RHEL 9)

########################################
# Client (192.168.56.20) - Connectivity
########################################
ping -c 3 192.168.56.10

########################################
# Server (192.168.56.10) - NFS Setup
########################################
sudo dnf install nfs-utils -y

sudo systemctl enable --now nfs-server
sudo systemctl status nfs-server

sudo mkdir /shared
sudo chown nobody:nobody /shared
sudo chmod 777 /shared

sudo nano /etc/exports
# Added:
# /shared 192.168.56.20(rw,sync,no_root_squash)

sudo exportfs -arv
sudo exportfs -v

# Optional firewall steps
sudo firewall-cmd --permanent --add-service=nfs
sudo firewall-cmd --reload

########################################
# Client (192.168.56.20) - Mount Share
########################################
sudo dnf install nfs-utils -y

sudo mkdir -p /mnt/nfs
sudo mount -t nfs 192.168.56.10:/shared /mnt/nfs

df -hT | grep nfs

sudo touch /mnt/nfs/testfile
ls -l /mnt/nfs

########################################
# Server - Verify file appears
########################################
ls -l /shared

########################################
# Client - Persistent Mount
########################################
sudo nano /etc/fstab
# Added:
# 192.168.56.10:/shared  /mnt/nfs  nfs  defaults  0  0

sudo mount -a
df -hT | grep nfs

sudo reboot

# After reboot
df -hT | grep nfs
