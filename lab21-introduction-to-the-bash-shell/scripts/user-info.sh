#!/bin/bash
# Interactive User Information Script

echo "Welcome to the User Information Collector!"
echo

# Get user input
read -p "Enter your name: " username
read -p "Enter your favorite color: " color
read -p "Enter your age: " age

echo
echo "=================================="
echo "User Information Summary"
echo "=================================="
echo "Name: $username"
echo "Favorite Color: $color"
echo "Age: $age"
echo "Script run on: $(date)"
echo "=================================="

# Create a personalized file
echo "Creating a personalized file for $username..."

cat > "${username}-info.txt" << EOF
Personal Information File
Name: $username
Favorite Color: $color
Age: $age
File created: $(date)
EOF

echo "File ${username}-info.txt has been created!"
