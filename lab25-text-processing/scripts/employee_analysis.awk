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
