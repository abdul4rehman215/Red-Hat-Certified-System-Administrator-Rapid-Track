#!/bin/bash

# =====================================================
# Lab 15: Kernel Parameter Tuning
# Host: ip-172-31-10-301
# OS: Ubuntu 24.04.1 LTS
# =====================================================

# -----------------------------------------------------
# Task 1: View Kernel Parameters
# -----------------------------------------------------

# List all kernel parameters
sudo sysctl -a

# View specific parameter
sudo sysctl vm.swappiness

# -----------------------------------------------------
# Task 1.2: Temporary Kernel Modification
# -----------------------------------------------------

# Change swappiness temporarily
sudo sysctl -w vm.swappiness=10

# Verify change
sudo sysctl vm.swappiness

# -----------------------------------------------------
# Task 1.3: Persistent Kernel Configuration
# -----------------------------------------------------

# Edit sysctl configuration file
sudo nano /etc/sysctl.conf

# (Add the following line manually inside the file)
# vm.swappiness = 10

# Apply persistent configuration
sudo sysctl -p

# -----------------------------------------------------
# Task 2: Networking Tuning
# -----------------------------------------------------

# Increase maximum file descriptors
sudo sysctl -w fs.file-max=100000

# Enable TCP Fast Open
sudo sysctl -w net.ipv4.tcp_fastopen=3

# Verify network parameters
sudo sysctl fs.file-max net.ipv4.tcp_fastopen

# -----------------------------------------------------
# Task 2.2: Memory Tuning
# -----------------------------------------------------

# Enable memory overcommit
sudo sysctl -w vm.overcommit_memory=1

# Disable hugepages
sudo sysctl -w vm.nr_hugepages=0

# Verify memory parameters
sudo sysctl vm.overcommit_memory vm.nr_hugepages

# -----------------------------------------------------
# Task 3: System Monitoring
# -----------------------------------------------------

# Check memory usage
free -h

# Check network summary
ss -s

# -----------------------------------------------------
# Install stress-ng for testing
# -----------------------------------------------------

sudo apt update
sudo apt install stress-ng -y

# Run memory stress test (60 seconds)
stress-ng --vm 2 --vm-bytes 2G --timeout 60s

# Monitor during stress test
top

# -----------------------------------------------------
# Simulated Network Performance Test
# -----------------------------------------------------

# Install iperf3 if needed
sudo apt install iperf3 -y

# Run network throughput test
iperf3 -c 192.168.1.50

# -----------------------------------------------------
# Final Verification
# -----------------------------------------------------

echo "Lab 15 - Kernel Parameter Tuning completed successfully!"
