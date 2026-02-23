#!/bin/bash
# ============================================
# Lab 04: Accessing Red Hat Support
# Commands Executed During Lab
# ============================================

# -------------------------------
# Task 1: Install System Info Tool
# -------------------------------

sudo dnf install -y inxi


# -------------------------------
# Task 1: Collect System Overview
# -------------------------------

inxi -Fxz

uname -a

cat /etc/os-release

lscpu

free -h

lsblk


# -------------------------------
# Task 1: Create Diagnostics Directory
# -------------------------------

mkdir ~/system_diagnostics
cd ~/system_diagnostics


# -------------------------------
# Task 1: Collect Logs & System Data
# -------------------------------

journalctl --since "1 day ago" > system_journal.log

dmesg > dmesg_output.log

rpm -qa > installed_packages.list


# -------------------------------
# Task 1: Create Compressed Archive
# -------------------------------

tar -czvf system_diagnostics_$(date +%Y%m%d).tar.gz *

ls -lh


# -------------------------------
# Task 3: Podman Functional Test
# -------------------------------

podman run --rm hello-world


# -------------------------------
# Final Cleanup
# -------------------------------

rm -rf ~/system_diagnostics
