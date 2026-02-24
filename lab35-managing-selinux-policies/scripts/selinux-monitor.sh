#!/bin/bash

echo "=== SELinux Status ==="
sestatus

echo -e "\n=== Recent SELinux Denials ==="
ausearch -m avc -ts today 2>/dev/null | tail -10

echo -e "\n=== SELinux Boolean Status ==="
getsebool -a | grep "on$" | wc -l
echo "Total booleans enabled"

echo -e "\n=== Custom File Contexts ==="
semanage fcontext -l -C
