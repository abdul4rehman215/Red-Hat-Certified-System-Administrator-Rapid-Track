#!/bin/bash
# 🧪 Lab 13: Process Monitoring
# OS: Ubuntu 24.04.1 LTS
# Host: ip-172-31-10-278
# User: toor

# --------------------------------------------------
# Step 1: Install Required Tools
# --------------------------------------------------

sudo apt update && sudo apt install htop -y


# --------------------------------------------------
# Task 1: View Running Processes
# --------------------------------------------------

# Launch top (exit with q)
top

# Static process listing
ps aux | head

# Launch htop (exit with F10)
htop


# --------------------------------------------------
# Task 2: Identify Resource-Intensive Processes
# --------------------------------------------------

# Sort processes by CPU usage (highest first)
ps aux --sort=-%cpu | head -n 5

# Sort processes by Memory usage (highest first)
ps aux --sort=-%mem | head -n 5

# Check system load average
uptime


# --------------------------------------------------
# Task 3: Optimize System Performance
# --------------------------------------------------

# Gracefully terminate a high CPU process (example PID 2143)
kill 2143

# Verify process termination
ps aux | grep python3


# --------------------------------------------------
# Simulate High CPU Load
# --------------------------------------------------

# Start CPU load process in background
yes > /dev/null &

# Capture PID (example: 2234)
ps aux | grep yes

# Reduce priority (increase niceness)
sudo renice -n 10 -p 2234

# Stop test process
kill 2234


# --------------------------------------------------
# Final Verification
# --------------------------------------------------

echo "Lab 13 - Process Monitoring completed successfully!"
