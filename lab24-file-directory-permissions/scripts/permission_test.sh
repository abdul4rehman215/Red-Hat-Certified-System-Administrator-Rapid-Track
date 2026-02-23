#!/bin/bash

echo "=== Permission Testing Script ==="
echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"
echo ""

echo "=== File Permissions ==="
ls -l *.txt *.sh 2>/dev/null
echo ""

echo "=== Directory Permissions ==="
ls -ld testdir
echo ""

echo "=== ACL Information ==="
echo "Files with ACLs:"
ls -l | grep "+"
echo ""

echo "=== Detailed ACL for acltest.txt ==="
getfacl acltest.txt 2>/dev/null
echo ""

echo "=== Testing file access ==="

if [ -r textfile.txt ]; then
  echo "✓ Can read textfile.txt"
else
  echo "✗ Cannot read textfile.txt"
fi

if [ -x script.sh ]; then
  echo "✓ Can execute script.sh"
else
  echo "✗ Cannot execute script.sh"
fi
