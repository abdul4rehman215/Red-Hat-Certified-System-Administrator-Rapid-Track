#!/bin/bash
# Lab 31: Controlling the Boot Process (systemd + GRUB2)
# Notes:
# - This file contains ONLY the commands executed (no outputs).
# - Reboot/GRUB interactive edits are documented as comments.

# -------------------------------
# Task 1: View systemd services/targets
# -------------------------------
systemctl --version
systemctl status

systemctl list-units --type=service --state=active
systemctl list-units --type=service --all

systemctl status sshd
systemctl show sshd

systemctl list-units --type=target
systemctl get-default
systemctl list-dependencies
systemctl list-dependencies graphical.target

systemctl status chronyd
sudo systemctl stop chronyd
systemctl status chronyd
sudo systemctl start chronyd
systemctl status chronyd

systemctl is-enabled chronyd
sudo systemctl disable chronyd
sudo systemctl enable chronyd

# -------------------------------
# Task 2: GRUB2 boot parameters
# -------------------------------
sudo cat /etc/default/grub
sudo cat /boot/grub2/grub.cfg | head -50

# Reboot (temporary GRUB edit):
# - At GRUB menu press 'e'
# - Add: systemd.unit=multi-user.target
# - Boot with Ctrl+X
sudo reboot

# After reconnect
systemctl get-default
systemctl list-units --type=target --state=active

# Permanent GRUB change
sudo cp /etc/default/grub /etc/default/grub.backup
sudo nano /etc/default/grub
sudo grep ^GRUB_CMDLINE_LINUX /etc/default/grub

# BIOS grub config generation
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# UEFI attempt (path may not exist in BIOS VMs)
sudo grub2-mkconfig -o /boot/efi/EFI/centos/grub.cfg

# Set default target permanently
sudo systemctl set-default multi-user.target
systemctl get-default

# -------------------------------
# Task 3: Rescue mode + emergency mode troubleshooting
# -------------------------------
sudo reboot
# GRUB interactive (rescue):
# - Edit kernel line and add: systemd.unit=rescue.target
# - Boot with Ctrl+X

# In rescue
systemctl list-units --type=target --state=active
systemctl list-units --type=service --state=active
df -h
journalctl -b

# Simulate a boot issue via fstab
sudo mount -o remount,rw /
sudo cp /etc/fstab /etc/fstab.backup
echo "/dev/nonexistent /mnt/fake ext4 defaults 0 2" | sudo tee -a /etc/fstab

# Attempt to switch to default target (may be blocked)
systemctl default

# Reboot to observe impact
sudo reboot

# Back to rescue again to fix
sudo mount -o remount,rw /
sudo sed -i '/nonexistent/d' /etc/fstab
cat /etc/fstab
cp /etc/fstab.backup /etc/fstab

# Emergency mode (GRUB interactive):
# - Add: systemd.unit=emergency.target
# - Boot with Ctrl+X
systemctl list-units --type=target --state=active
mount
sudo mount -o remount,rw /

# Password recovery style actions
sudo mount -o remount,rw /
sudo passwd root
sudo useradd -m testuser
sudo passwd testuser
sudo usermod -aG wheel testuser

# Return to graphical target (if desired)
sudo systemctl set-default graphical.target
sudo systemctl reboot

# -------------------------------
# Verification
# -------------------------------
systemctl get-default
journalctl -b | tail -15
systemctl status
sudo cat /etc/default/grub
