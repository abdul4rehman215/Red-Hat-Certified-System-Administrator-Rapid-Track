#!/bin/bash
# Lab 22 - File System Navigation
# Commands Executed Sequentially

# -------------------------------
# Task 1: Directory Navigation
# -------------------------------

pwd
ls
ls -l

cd /
ls

cd /home
ls -l

cd ~
pwd

cd ..
pwd

cd -

ls
cd Documents 2>/dev/null || echo "Documents directory doesn't exist yet"

cd ~

find . -type f
find . -type d

find /etc -name "*.conf" -type f 2>/dev/null | head -10

# -------------------------------
# Task 2: Creating Directories
# -------------------------------

cd ~

mkdir lab2_practice
ls -l

mkdir projects documents scripts

mkdir -p lab2_practice/level1/level2/level3

ls -R lab2_practice

cd lab2_practice
pwd

# -------------------------------
# Creating Files
# -------------------------------

touch readme.txt
touch file1.txt file2.txt file3.txt

echo "This is my first Linux file" > welcome.txt

nano myinfo.txt

ls -l

# -------------------------------
# Organizing Files
# -------------------------------

mv file1.txt level1/
mv file2.txt file3.txt level1/level2/

cp welcome.txt level1/level2/level3/

find . -type f

# -------------------------------
# Task 3: File Permissions
# -------------------------------

ls -l

echo "Permission test file" > permissions_test.txt

ls -l permissions_test.txt

stat -c "%a %n" permissions_test.txt

chmod 644 permissions_test.txt
ls -l permissions_test.txt

chmod 744 permissions_test.txt
ls -l permissions_test.txt

chmod g+x permissions_test.txt
chmod o-r permissions_test.txt

ls -l permissions_test.txt

# -------------------------------
# Directory Permissions
# -------------------------------

mkdir permission_test_dir

ls -ld permission_test_dir

chmod 755 permission_test_dir

echo "Directory test" > permission_test_dir/test_file.txt

chmod 644 permission_test_dir

ls permission_test_dir

chmod 755 permission_test_dir

ls permission_test_dir

# -------------------------------
# Script Permission Practice
# -------------------------------

nano myscript.sh

ls -l myscript.sh

./myscript.sh

chmod +x myscript.sh

./myscript.sh

ls -l myscript.sh

# -------------------------------
# Verification Commands
# -------------------------------

pwd
ls -la

tree . 2>/dev/null || find . -type d

stat -c "%a %n" permissions_test.txt
