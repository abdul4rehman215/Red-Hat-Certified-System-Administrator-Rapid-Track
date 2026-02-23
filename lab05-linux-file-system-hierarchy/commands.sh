#!/bin/bash
# ============================================
# Lab 05: Linux File System Hierarchy
# Commands Executed During Lab
# ============================================

# -------------------------------
# Task 1: Exploring Root Directory
# -------------------------------

ls /


# -------------------------------
# Exploring /bin and /sbin
# -------------------------------

ls /bin | head

ls /sbin | head


# -------------------------------
# Exploring /etc
# -------------------------------

ls /etc | head

less /etc/passwd


# -------------------------------
# Working with /home
# -------------------------------

cd ~

pwd

touch testfile.txt

ls


# -------------------------------
# Exploring /usr
# -------------------------------

ls /usr | head

ls /usr/bin | wc -l


# -------------------------------
# Exploring /var
# -------------------------------

ls /var

sudo ls /var/log | head


# -------------------------------
# Working with /tmp
# -------------------------------

cd /tmp

touch tempfile

ls


# -------------------------------
# File System Navigation
# -------------------------------

pwd

ls -l

cd ..

cd


# -------------------------------
# Finding Files
# -------------------------------

find /etc -name "*.conf" | head

locate passwd

# (If locate database not updated)
# sudo updatedb


# -------------------------------
# Symbolic Links
# -------------------------------

ls -l /bin | grep '^l'

touch original.txt

ln -s original.txt link_to_original

ls -l link_to_original


# -------------------------------
# Hard Links
# -------------------------------

ln original.txt hardlink_to_original

ls -i original.txt hardlink_to_original


# -------------------------------
# Optional Tool Installation
# -------------------------------

# sudo apt install tree
