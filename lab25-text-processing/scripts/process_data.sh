#!/bin/bash
echo "=== COMPREHENSIVE DATA PROCESSING REPORT ==="
echo "Generated on: $(date)"
echo "=============================================="

echo -e "\n1. HIGH-VALUE EMPLOYEES (Salary > 70000):"
grep -E ",[7-9][0-9][0-9][0-9][0-9]$" employees.txt | \
sed 's/,/ | /g' | \
awk '{print " " $0}'

echo -e "\n2. IT DEPARTMENT ANALYSIS:"
grep "IT" employees.txt | \
awk -F',' '{
 total += $4;
 count++;
 if ($2 == "Manager") managers++;
 else if ($2 == "Developer") developers++;
 else analysts++;
}
END {
 print " Total IT employees: " count
 print " Managers: " managers
 print " Developers: " developers
 print " Analysts: " analysts
 print " Average IT salary: $" total/count
}'

echo -e "\n3. CRITICAL LOG ENTRIES:"
grep "ERROR" server_logs.txt | \
sed 's/ERROR:/[CRITICAL ERROR]/' | \
awk '{print " " $0}'

echo -e "\n4. ELECTRONICS INVENTORY:"
grep "Electronics" products.txt | \
awk -F',' '{
 value = $3 * $4;
 total_value += value;
 total_items += $4;
 printf " %-15s: $%7.2f x %3d = $%8.2f\n", $1, $3, $4, value
}
END {
 print " ----------------------------------------"
 printf " %-15s: %3d items = $%8.2f\n", "TOTAL", total_items, total_value
}'

echo -e "\n=============================================="
echo "Report completed successfully!"
