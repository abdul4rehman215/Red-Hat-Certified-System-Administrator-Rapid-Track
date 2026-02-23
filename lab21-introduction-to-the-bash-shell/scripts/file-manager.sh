#!/bin/bash
# Simple File Management Script

echo "File Management Utility"
echo "======================"

# Create backup directory
backup_dir="backup-$(date +%Y%m%d)"
mkdir -p "$backup_dir"

# List current files
echo "Current files in directory:"
ls -la
echo

echo "Creating backup of .txt files..."

# Backup all .txt files
for file in *.txt; do
    if [ -f "$file" ]; then
        cp "$file" "$backup_dir/"
        echo "Backed up: $file"
    fi
done

echo
echo "Backup completed in directory: $backup_dir"
echo "Contents of backup directory:"
ls -la "$backup_dir"
