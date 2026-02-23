#!/bin/bash
# 🧪 Lab 14: Adjusting Process Priorities
# OS: RHEL 9.3
# Host: rhel9-priority-lab
# User: student

# --------------------------------------------------
# Step 1: Install Monitoring Tools
# --------------------------------------------------

sudo dnf install htop glances -y

# Verify installation
which htop glances


# --------------------------------------------------
# Task 1: Launch Processes with Different Priorities
# --------------------------------------------------

# Launch low-priority CPU-intensive process
nice -n 19 sha1sum /dev/zero &

# Launch high-priority process (requires root)
sudo nice -n -20 sha1sum /dev/zero &

# Verify running processes and priorities
ps -l -p $(pgrep sha1sum)


# --------------------------------------------------
# Task 2: Modify Running Process Priorities
# --------------------------------------------------

# Identify PIDs
pgrep sha1sum

# Increase priority of low-priority process (example PID 4123)
sudo renice -n -10 -p 4123

# Verify priority change
ps -o pid,ni,cmd -p 4123

# Decrease priority of all user processes
renice -n 10 -u $(whoami)


# --------------------------------------------------
# Task 3: Monitor Impact Using htop
# --------------------------------------------------

# Launch htop (exit with F10)
htop


# --------------------------------------------------
# Create Multiple CPU Loads with Different Nice Values
# --------------------------------------------------

for i in {1..4}; do
    nice -n $((i*5)) sha1sum /dev/zero &
done

# Verify processes
pgrep sha1sum
ps -o pid,ni,cmd -C sha1sum


# --------------------------------------------------
# Cleanup Test Processes
# --------------------------------------------------

pkill sha1sum

# Confirm termination
pgrep sha1sum


# --------------------------------------------------
# Final Verification
# --------------------------------------------------

echo "Lab 14 - Process Priority Management completed successfully!"
