#!/bin/bash
# Lab 21 - Introduction to the Bash Shell
# Commands Executed During Lab (Sequential)

# =========================
# Task 1: Environment Verification
# =========================
echo $SHELL
bash --version
whoami
date

# =========================
# Task 2: Basic Bash Commands
# =========================
pwd
ls
ls -l
ls -la

cd /
ls

cd ~
pwd

# =========================
# Task 2.2: Directory Management
# =========================
mkdir lab1-practice
cd lab1-practice
pwd

mkdir scripts documents backups
mkdir -p projects/web/html projects/web/css
ls -R

# =========================
# Task 2.3: File Management
# =========================
touch readme.txt
echo "Welcome to Bash Shell Lab" > welcome.txt
cat welcome.txt

nano system-info.txt
cat system-info.txt

# =========================
# Task 2.4: Copy, Move, Rename, Remove
# =========================
cp welcome.txt documents/
cp welcome.txt welcome-backup.txt
mv readme.txt documents/
mv welcome-backup.txt welcome-copy.txt
rm welcome-copy.txt

ls
ls documents/

# =========================
# Task 3.1: Output Redirection
# =========================
ls -la > file-listing.txt
cat file-listing.txt

date >> file-listing.txt
echo "--- End of listing ---" >> file-listing.txt
cat file-listing.txt

# =========================
# Task 3.2: Input Redirection
# =========================
nano numbers.txt
sort < numbers.txt
sort < numbers.txt > sorted-numbers.txt
cat sorted-numbers.txt

# =========================
# Task 3.3: Pipes
# =========================
ls | wc -l
ps aux | grep bash
du -h | sort -hr
cat /etc/passwd | grep root
ls -la | grep "^d" | wc -l

# =========================
# Task 3.4: Advanced Redirection
# =========================
ls /nonexistent-directory > output.txt 2> error.txt
cat output.txt
cat error.txt

ls /nonexistent-directory > combined.txt 2>&1
cat combined.txt

ls -la | tee directory-listing.txt

# =========================
# Task 4: Scripting
# =========================
cd ~/lab1-practice/scripts
pwd

nano hello-world.sh
chmod +x hello-world.sh
./hello-world.sh

nano system-report.sh
chmod +x system-report.sh
./system-report.sh

nano user-info.sh
chmod +x user-info.sh
./user-info.sh
ls -la

nano file-manager.sh
chmod +x file-manager.sh
./file-manager.sh

# =========================
# Verification & Validation
# =========================
cd ~/lab1-practice
find . -type d
ls -la scripts/

cd scripts
./hello-world.sh
./system-report.sh

ls -la *.txt
