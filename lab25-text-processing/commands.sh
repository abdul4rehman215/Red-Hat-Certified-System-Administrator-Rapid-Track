#!/bin/bash
# Lab 25: Text Processing with grep, sed, and awk
# commands.sh — ONLY commands executed (in order)

# -----------------------------
# Task 1: Setup + sample files
# -----------------------------
mkdir ~/text_processing_lab
cd ~/text_processing_lab
pwd

cat > employees.txt << 'EOF'
John Smith,Manager,Sales,75000
Jane Doe,Developer,IT,65000
Mike Johnson,Analyst,Finance,55000
Sarah Wilson,Manager,IT,80000
Tom Brown,Developer,IT,60000
Lisa Davis,Analyst,Sales,50000
Robert Taylor,Manager,Finance,85000
Emily White,Developer,IT,62000
David Lee,Analyst,IT,58000
Maria Garcia,Manager,Sales,78000
EOF

cat > server_logs.txt << 'EOF'
2024-01-15 10:30:15 INFO: Server started successfully
2024-01-15 10:31:22 ERROR: Database connection failed
2024-01-15 10:32:10 WARNING: High memory usage detected
2024-01-15 10:33:45 INFO: User login: admin
2024-01-15 10:34:12 ERROR: File not found: /var/log/app.log
2024-01-15 10:35:30 INFO: Backup process completed
2024-01-15 10:36:18 WARNING: Disk space low
2024-01-15 10:37:25 ERROR: Network timeout occurred
2024-01-15 10:38:40 INFO: User logout: admin
2024-01-15 10:39:55 INFO: System maintenance scheduled
EOF

cat > products.txt << 'EOF'
Laptop,Electronics,999.99,50
Mouse,Electronics,29.99,200
Keyboard,Electronics,79.99,150
Chair,Furniture,299.99,25
Desk,Furniture,499.99,15
Monitor,Electronics,399.99,75
Headphones,Electronics,149.99,100
Lamp,Furniture,89.99,40
Notebook,Office,12.99,500
Pen,Office,2.99,1000
EOF

# -----------------------------
# Task 1: grep basics
# -----------------------------
grep "Manager" employees.txt
grep -i "manager" employees.txt
grep -c "IT" employees.txt
grep -n "Developer" employees.txt
grep -v "IT" employees.txt

# -----------------------------
# Task 1: grep advanced/regex
# -----------------------------
grep "^2024-01-15 10:3[0-5]" server_logs.txt
grep "000$" employees.txt
grep "[0-9]" products.txt
grep -E "(ERROR|WARNING)" server_logs.txt

mkdir logs
cp server_logs.txt logs/
grep -r "ERROR" .

# -----------------------------
# Task 1: practical grep
# -----------------------------
grep -E ",[7-9][0-9][0-9][0-9][0-9]$" employees.txt
grep "Electronics" products.txt
grep "10:3[0-5]" server_logs.txt
grep "IT" employees.txt | grep "Manager"

# -----------------------------
# Task 2: sed substitutions
# -----------------------------
sed 's/IT/Information Technology/' employees.txt
sed 's/IT/Information Technology/g' employees.txt
sed 's/IT/Information Technology/g' employees.txt > employees_updated.txt

cp employees.txt employees_backup.txt
sed -i 's/IT/Information Technology/g' employees_backup.txt
cat employees_backup.txt

# -----------------------------
# Task 2: sed advanced operations
# -----------------------------
sed '2d' employees.txt
sed '/Manager/d' employees.txt

sed '1i\Employee Database Report' employees.txt
sed '$a\End of Report' employees.txt

sed '3s/Analyst/Senior Analyst/' employees.txt
sed '/Finance/s/Analyst/Senior Analyst/' employees.txt

# -----------------------------
# Task 2: sed complex transformations
# -----------------------------
sed -e 's/IT/Information Technology/g' -e 's/Manager/Director/g' employees.txt
sed 's/[0-9][0-9][0-9][0-9][0-9]/SALARY_HIDDEN/g' employees.txt
sed 's/ERROR:/[ERROR]:/g; s/WARNING:/[WARNING]:/g; s/INFO:/[INFO]:/' server_logs.txt
sed 's/.*,\([^,]*\),\([^,]*\),.*/Department: \2, Role: \1/' employees.txt

# -----------------------------
# Task 2: formatted report examples (multi-line prompt)
# -----------------------------
sed -e '1i\=== EMPLOYEE REPORT ===' \
 -e 's/,/ | /g' \
 -e '$a\=== END OF REPORT ===' employees.txt

sed -e 's/2024-01-15 //' \
 -e 's/INFO:/[INFO]/' \
 -e 's/ERROR:/[ERROR]/' \
 -e 's/WARNING:/[WARN]/' server_logs.txt

sed 's/,/|/g' products.txt

# -----------------------------
# Task 3: awk basics
# -----------------------------
awk -F',' '{print $1}' employees.txt
awk -F',' '{print $1, $2}' employees.txt
awk -F',' '{print "Name: " $1 ", Position: " $2}' employees.txt
awk -F',' '{print NR ": " $1}' employees.txt
awk 'END {print "Total employees: " NR}' employees.txt

# -----------------------------
# Task 3: awk conditions + reporting
# -----------------------------
awk -F',' '$2 == "Manager" {print $1, $4}' employees.txt
awk -F',' '$4 > 60000 {print $1, $4}' employees.txt
awk -F',' '$3 == "IT" {print $1, $2}' employees.txt
awk -F',' '{dept[$3]++} END {for (d in dept) print d, dept[d]}' employees.txt

# -----------------------------
# Task 3: awk script (employee_analysis.awk)
# -----------------------------
cat > employee_analysis.awk << 'EOF'
BEGIN {
 FS = ","
 print "=== EMPLOYEE ANALYSIS REPORT ==="
 print "================================="
 total_salary = 0
 employee_count = 0
}
{
 # Count employees by department
 dept[$3]++

 # Count employees by position
 position[$2]++

 # Calculate total salary
 total_salary += $4
 employee_count++

 # Track highest paid employee
 if ($4 > max_salary) {
 max_salary = $4
 highest_paid = $1
 }
}
END {
 print "\nDEPARTMENT BREAKDOWN:"
 for (d in dept) {
 printf "%-15s: %d employees\n", d, dept[d]
 }

 print "\nPOSITION BREAKDOWN:"
 for (p in position) {
 printf "%-15s: %d employees\n", p, position[p]
 }

 print "\nSALARY STATISTICS:"
 printf "Total Employees: %d\n", employee_count
 printf "Total Salary: $%.2f\n", total_salary
 printf "Average Salary: $%.2f\n", total_salary/employee_count
 printf "Highest Paid: %s ($%.2f)\n", highest_paid, max_salary

 print "\n=== END OF REPORT ==="
}
EOF

awk -f employee_analysis.awk employees.txt

# -----------------------------
# Task 3: awk log analysis (one-liner script)
# -----------------------------
awk '{
 # Count log levels
 if ($3 == "ERROR:") errors++
 else if ($3 == "WARNING:") warnings++
 else if ($3 == "INFO:") info++

 # Store all log entries
 logs[NR] = $0
}
END {
 print "=== LOG ANALYSIS ==="
 print "INFO entries:", info
 print "WARNING entries:", warnings
 print "ERROR entries:", errors
 print "Total entries:", NR

 if (errors > 0) {
 print "\nERROR DETAILS:"
 for (i=1; i<=NR; i++) {
 if (logs[i] ~ /ERROR:/) {
 print logs[i]
 }
 }
 }
}' server_logs.txt

# -----------------------------
# Task 3: awk inventory processing
# -----------------------------
awk -F',' '
BEGIN {
 print "=== INVENTORY REPORT ==="
 total_value = 0
}
{
 # Calculate total value for each product
 product_value = $3 * $4
 total_value += product_value

 printf "%-15s: $%8.2f x %3d = $%10.2f\n", $1, $3, $4, product_value

 # Track category totals
 category_value[$2] += product_value
 category_count[$2] += $4
}
END {
 print "\n=== CATEGORY SUMMARY ==="
 for (cat in category_value) {
 printf "%-15s: %3d items, Total Value: $%10.2f\n",
 cat, category_count[cat], category_value[cat]
 }
 printf "\nGRAND TOTAL INVENTORY VALUE: $%.2f\n", total_value
}' products.txt

# -----------------------------
# Task 4: pipelines (grep + sed + awk)
# -----------------------------
grep "IT" employees.txt | sed 's/IT/Information Technology/g' | awk -F',' '{print $1 " works in " $3 " earning $" $4}'

grep -E "(ERROR|WARNING)" server_logs.txt | sed 's/2024-01-15 //' | awk '{print "Alert at " $1 ": " substr($0, index($0,$2))}'

grep "Electronics" products.txt | awk -F',' '{total += $3 * $4; count++} END {print "Electronics inventory value: $" total " (" count " items)"}'

# -----------------------------
# Task 4: comprehensive script (process_data.sh)
# -----------------------------
nano process_data.sh
chmod +x process_data.sh
./process_data.sh

# -----------------------------
# Task 5: system monitoring script
# -----------------------------
nano system_monitor.sh
chmod +x system_monitor.sh
./system_monitor.sh

# -----------------------------
# Task 5: messy data cleaning
# -----------------------------
cat > messy_data.txt << 'EOF'
 John Smith , Manager , Sales , 75000
Jane Doe,Developer,IT,65000
 Mike Johnson,Analyst,Finance,55000
Sarah Wilson ,Manager,IT,80000
 Tom Brown,Developer ,IT,60000
EOF

echo "=== DATA CLEANING EXAMPLE ==="
echo "Original messy data:"
cat messy_data.txt
echo -e "\nCleaned data:"

sed 's/^[ \t]*//; s/[ \t]*$//; s/[ \t]*,[ \t]*/,/g' messy_data.txt | \
awk -F',' '{printf "%-15s | %-10s | %-8s | $%s\n", $1, $2, $3, $4}'

# -----------------------------
# Verification commands
# -----------------------------
echo "IT employees count:"
grep -c "IT" employees.txt

echo "After replacing IT with Information Technology:"
sed 's/IT/Information Technology/g' employees.txt | grep -c "Information Technology"

echo "Average salary:"
awk -F',' '{total += $4; count++} END {print total/count}' employees.txt

echo "Highest paid employee:"
awk -F',' '{if ($4 > max) {max = $4; name = $1}} END {print name, max}' employees.txt
