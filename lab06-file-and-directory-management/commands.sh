#!/bin/bash
# ============================================
# Lab 06: File and Directory Management
# Commands Executed During Lab
# ============================================

# -------------------------------
# Setup: Verify Current Directory
# -------------------------------

pwd

mkdir file_management_lab
cd file_management_lab
pwd


# -------------------------------
# Task 1: Create Files & Directories
# -------------------------------

mkdir documents

touch file1.txt file2.txt file3.txt

ls -l


# -------------------------------
# Task 1: Delete Files & Directories
# -------------------------------

rm file3.txt

rmdir documents

rm -r documents


# -------------------------------
# Task 2: Move and Copy Files
# -------------------------------

mkdir documents backups

touch file1.txt file2.txt

mv file1.txt documents/

ls documents/

cp file2.txt backups/

cp file2.txt file2_backup.txt

ls backups/
ls


# -------------------------------
# Task 3: Relative Path Navigation
# -------------------------------

cd documents
pwd

cd ..

ls backups/


# -------------------------------
# Task 3: Absolute Path Operations
# -------------------------------

pwd

touch /home/toor/file_management_lab/absolute_example.txt

cp /home/toor/file_management_lab/absolute_example.txt \
   /home/toor/file_management_lab/backups/


# -------------------------------
# Advanced Exercise
# -------------------------------

mkdir -p projects/{src,doc,bin}

mv *.txt projects/doc/

sudo apt install tree -y

tree

find . -type d -print


# -------------------------------
# Cleanup
# -------------------------------

cd ..
rm -rf file_management_lab
