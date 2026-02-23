# 🎤 Interview Q&A — Lab 25: Text Processing with grep, sed, and awk

> This section covers commonly asked Linux interview questions related to text processing, log analysis, and command-line data manipulation.

---

## 1️⃣ What is the difference between grep, sed, and awk?

- **grep** → Searches and filters lines matching patterns.
- **sed** → Edits and transforms text streams (replace, delete, insert).
- **awk** → Full text-processing language for extracting fields, performing calculations, and generating reports.

Think of it as:
- grep = filter  
- sed = modify  
- awk = analyze + compute  

---

## 2️⃣ How do you perform a case-insensitive search using grep?

```bash
grep -i "pattern" filename
````

The `-i` flag ignores case differences.

---

## 3️⃣ How do you count matching lines in a file?

```bash
grep -c "pattern" filename
```

This returns the number of matching lines.

---

## 4️⃣ How do you search for multiple patterns at once?

Using extended regex:

```bash
grep -E "(ERROR|WARNING)" file
```

The `-E` flag enables extended regular expressions.

---

## 5️⃣ How do you replace text in a file using sed?

Basic substitution:

```bash
sed 's/old/new/' file
```

Global replacement:

```bash
sed 's/old/new/g' file
```

In-place replacement (careful!):

```bash
sed -i 's/old/new/g' file
```

---

## 6️⃣ How do you delete lines containing a specific word using sed?

```bash
sed '/word/d' file
```

---

## 7️⃣ How do you print only the first column of a CSV file using awk?

```bash
awk -F',' '{print $1}' file
```

`-F','` sets comma as the field separator.

---

## 8️⃣ How do you calculate the average of a numeric column using awk?

```bash
awk -F',' '{total+=$4; count++} END {print total/count}' file
```

---

## 9️⃣ How can you count occurrences grouped by a field in awk?

```bash
awk -F',' '{dept[$3]++} END {for (d in dept) print d, dept[d]}' file
```

Uses associative arrays in awk.

---

## 🔟 What is NR in awk?

`NR` = Number of Records (line number).

Example:

```bash
awk '{print NR, $0}' file
```

---

## 1️⃣1️⃣ How do you combine grep, sed, and awk?

Example pipeline:

```bash
grep "IT" employees.txt | \
sed 's/IT/Information Technology/g' | \
awk -F',' '{print $1 " earns $" $4}'
```

This:

1. Filters lines
2. Modifies text
3. Extracts structured output

---

## 1️⃣2️⃣ How do you recursively search in directories?

```bash
grep -r "pattern" directory
```

---

## 1️⃣3️⃣ How do you anchor regex to start or end of a line?

* Start of line → `^`
* End of line → `$`

Example:

```bash
grep "^ERROR" file
grep "000$" file
```

---

## 1️⃣4️⃣ When would you choose awk over sed?

Use **awk** when:

* You need field-based processing
* You need calculations
* You need grouped summaries
* You need conditional logic

Use **sed** when:

* You only need text transformation

---

## 1️⃣5️⃣ Real-World Scenario: How would you find the top 5 highest salaries in a CSV file?

```bash
awk -F',' '{print $1, $4}' employees.txt | sort -k2 -nr | head -5
```

---

# 🎯 RHCSA & Real-World Relevance

These questions reflect real tasks such as:

* Parsing `/var/log/messages`
* Extracting fields from `/etc/passwd`
* Analyzing audit logs
* Generating quick operational reports
* Cleaning CSV data before importing to tools

Mastery of grep, sed, and awk is foundational for Linux administration and automation.
