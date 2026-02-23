#!/bin/bash

# Generate sample system data
cat > system_status.log << 'SYSEOF'
2024-01-15 10:30:00 CPU: 45% Memory: 67% Disk: 23%
2024-01-15 10:31:00 CPU: 52% Memory: 71% Disk: 23%
2024-01-15 10:32:00 CPU: 89% Memory: 78% Disk: 24%
2024-01-15 10:33:00 CPU: 34% Memory: 65% Disk: 24%
2024-01-15 10:34:00 CPU: 91% Memory: 82% Disk: 25%
2024-01-15 10:35:00 CPU: 28% Memory: 59% Disk: 25%
SYSEOF

echo "=== SYSTEM PERFORMANCE ANALYSIS ==="

# Find high CPU usage
echo "High CPU Usage (>80%):"
grep -E "CPU: [8-9][0-9]%" system_status.log | \
awk '{print " " $1 " " $2 " - " $3}'

# Find high memory usage
echo -e "\nHigh Memory Usage (>75%):"
grep -E "Memory: [7-9][0-9]%" system_status.log | \
awk '{print " " $1 " " $2 " - " $4}'

# Calculate averages
echo -e "\nSystem Averages:"
awk '{
 gsub(/[CPU:Memory:Disk:%]/, "");
 cpu_total += $3;
 mem_total += $4;
 disk_total += $5;
 count++;
}
END {
 printf " Average CPU: %.1f%%\n", cpu_total/count;
 printf " Average Memory: %.1f%%\n", mem_total/count;
 printf " Average Disk: %.1f%%\n", disk_total/count;
}' system_status.log

rm system_status.log
