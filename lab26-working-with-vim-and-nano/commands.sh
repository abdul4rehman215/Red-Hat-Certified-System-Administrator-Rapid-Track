#!/bin/bash
# Lab 26: Working with vim and nano
# commands.sh — ONLY commands executed in terminal

# ----------------------------------------
# Task 1: Setup
# ----------------------------------------

mkdir ~/text-editor-lab
cd ~/text-editor-lab
pwd

# Verify editors installed
which vim
which nano
vim --version | head -1
nano --version | head -1

# ----------------------------------------
# Task 2: nano editor
# ----------------------------------------

# Create configuration file
nano server-config.txt

# Verify file creation
ls -la server-config.txt
cat server-config.txt

# Reopen and modify file
nano server-config.txt

# Verify appended security settings
tail -n 8 server-config.txt

# ----------------------------------------
# Task 3: vim editor
# ----------------------------------------

# Create network configuration
vim network-settings.conf

# Verify file creation
ls -la network-settings.conf
cat network-settings.conf

# Reopen for additional practice
vim network-settings.conf

# ----------------------------------------
# Task 4: Comparison files
# ----------------------------------------

nano comparison-nano.txt
vim comparison-vim.txt

# View both files
cat comparison-nano.txt
echo "---"
cat comparison-vim.txt

# ----------------------------------------
# Task 5: Practical scenarios
# ----------------------------------------

# Quick configuration edit (nano)
nano /tmp/httpd.conf
ls -la /tmp/httpd.conf
head -n 12 /tmp/httpd.conf

# Complex editing (vim)
vim /tmp/complex-config.conf

# Verify final file
cat /tmp/complex-config.conf

# ----------------------------------------
# Task 6: Cheat sheets
# ----------------------------------------

nano nano-cheatsheet.txt
vim vim-cheatsheet.txt

# ----------------------------------------
# Lab Verification
# ----------------------------------------

ls -la ~/text-editor-lab/
cat ~/text-editor-lab/server-config.txt
cat ~/text-editor-lab/network-settings.conf
cat /tmp/complex-config.conf
