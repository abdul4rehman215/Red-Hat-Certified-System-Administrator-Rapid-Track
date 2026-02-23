#!/bin/bash
# 🧪 Lab 12: Troubleshooting SELinux
# OS: RHEL 9.3
# Hostname: rhel9-selinux-troubleshoot
# User: student

# --------------------------------------------------
# Install Required SELinux Troubleshooting Packages
# --------------------------------------------------

sudo dnf install -y policycoreutils-python-utils setools-console audit


# --------------------------------------------------
# Verify SELinux Status
# --------------------------------------------------

sestatus

# If not enforcing, enable enforcing mode
sudo setenforce 1


# --------------------------------------------------
# Simulate SELinux Denial Scenario
# --------------------------------------------------

# Create web directory and test file
sudo mkdir -p /var/www/html
sudo touch /var/www/html/test.html

# Intentionally assign incorrect context
sudo chcon -t default_t /var/www/html/test.html


# --------------------------------------------------
# Identify SELinux AVC Denials
# --------------------------------------------------

# Search recent AVC denials
sudo ausearch -m avc -ts recent

# Alternative: Search audit log manually
sudo grep "avc:.*denied" /var/log/audit/audit.log


# --------------------------------------------------
# Generate Custom Policy Module
# --------------------------------------------------

sudo ausearch -m avc -ts recent | audit2allow -M mypolicy


# --------------------------------------------------
# Install Custom Policy Module
# --------------------------------------------------

sudo semodule -i mypolicy.pp


# --------------------------------------------------
# Verify Installed Policy Module
# --------------------------------------------------

sudo semodule -l | grep mypolicy


# --------------------------------------------------
# Generate Human-Readable SELinux Rules
# --------------------------------------------------

sudo ausearch -m avc -ts recent | audit2allow


# --------------------------------------------------
# Automatically Generate and Apply Another Policy
# --------------------------------------------------

sudo ausearch -m avc -ts recent | audit2allow -M mynewpolicy
sudo semodule -i mynewpolicy.pp


# --------------------------------------------------
# Verify No New AVC Denials
# --------------------------------------------------

sudo ausearch -m avc -ts recent


# --------------------------------------------------
# Optional: Restore Correct Context (Preferred Fix)
# --------------------------------------------------

sudo restorecon -v /var/www/html/test.html


# --------------------------------------------------
# Verify File Context
# --------------------------------------------------

ls -Z /var/www/html/test.html


# --------------------------------------------------
# Cleanup (Optional)
# --------------------------------------------------

sudo semodule -r mypolicy
sudo semodule -r mynewpolicy
sudo rm -f mypolicy.te mypolicy.mod mypolicy.pp
sudo rm -f mynewpolicy.te mynewpolicy.mod mynewpolicy.pp
sudo rm -f /var/www/html/test.html
