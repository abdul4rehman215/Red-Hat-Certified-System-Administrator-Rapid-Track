#!/bin/bash

# =====================================================
# Lab 16: Installing and Managing Software in RHEL
# Host: rhel9-pkg-lab
# OS: RHEL 9.3
# =====================================================

# -----------------------------------------------------
# Task 1: Verify Package Managers
# -----------------------------------------------------

which dnf yum
dnf --version

# -----------------------------------------------------
# Task 1.2: Install Package (htop)
# -----------------------------------------------------

sudo dnf install htop -y

# Verify installation
which htop

# -----------------------------------------------------
# Task 2: Update System
# -----------------------------------------------------

sudo dnf update -y

# -----------------------------------------------------
# Task 2.2: Remove Package
# -----------------------------------------------------

sudo dnf remove htop -y

# Verify removal
which htop

# -----------------------------------------------------
# Task 3: Repository Management
# -----------------------------------------------------

# List enabled repositories
sudo dnf repolist

# Install EPEL repository
sudo dnf install epel-release -y

# Verify EPEL enabled
sudo dnf repolist | grep epel

# -----------------------------------------------------
# Install nginx (dependency resolution demo)
# -----------------------------------------------------

sudo dnf install nginx -y

# Verify installed packages via RPM
rpm -qa | grep nginx

# -----------------------------------------------------
# Final verification
# -----------------------------------------------------

dnf list installed | grep -E 'nginx|htop'

echo "Lab 16 - Installing and Managing Software completed successfully!"
