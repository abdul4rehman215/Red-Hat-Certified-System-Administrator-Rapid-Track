# 🛠️ Troubleshooting Guide — Lab 25: Text Processing with grep, sed, and awk

> This guide covers common issues encountered while using grep, sed, awk, and pipelines in real Linux environments.

---

# 🔎 1️⃣ grep Not Finding Expected Matches

## ❌ Problem
```bash
grep "manager" employees.txt
````

No output returned.

## 🔍 Diagnosis

### 1. Case sensitivity issue

grep is case-sensitive by default.

### 2. Hidden characters or formatting

Check for trailing spaces or special characters:

```bash
cat -A employees.txt | head
```

---

## 🔧 Solutions

Case-insensitive search:

```bash
grep -i "manager" employees.txt
```

Use extended regex:

```bash
grep -E "(Manager|manager)" employees.txt
```

---

# 🔎 2️⃣ grep Regex Not Working

## ❌ Problem

Regex pattern not matching as expected.

## 🔍 Common Causes

* Forgot `-E` for extended regex
* Special characters not escaped
* Incorrect anchors (^, $)

---

## 🔧 Fix

Use:

```bash
grep -E "pattern" file
```

Escape special characters if needed:

```bash
grep "\$100" file
```

---

# 🔎 3️⃣ sed Not Modifying File

## ❌ Problem

You run sed but original file remains unchanged.

```bash
sed 's/IT/Information Technology/g' employees.txt
```

## 🔍 Explanation

sed prints to stdout by default — it does NOT modify the original file.

---

## 🔧 Fix

Redirect output:

```bash
sed 's/IT/Information Technology/g' employees.txt > updated.txt
```

Or edit in place:

```bash
sed -i 's/IT/Information Technology/g' employees.txt
```

Safer method (with backup):

```bash
sed -i.backup 's/IT/Information Technology/g' employees.txt
```

---

# 🔎 4️⃣ sed Regex Replacement Not Working

## ❌ Problem

Complex pattern not matching correctly.

## 🔍 Example Issue

Trying to match salary numbers but pattern is incorrect length.

Check:

```bash
grep -n "[0-9]" employees.txt
```

---

## 🔧 Fix

Use exact digit match:

```bash
sed 's/[0-9]\{5\}/SALARY_HIDDEN/g' employees.txt
```

or

```bash
sed -E 's/[0-9]{5}/SALARY_HIDDEN/g' employees.txt
```

---

# 🔎 5️⃣ awk Showing Wrong Fields

## ❌ Problem

awk printing incorrect column.

## 🔍 Cause

Wrong field separator.

Default separator = whitespace.

---

## 🔧 Fix

Set separator explicitly:

```bash
awk -F',' '{print $1}' employees.txt
```

For multiple separators:

```bash
awk -F'[ ,]' '{print $1}' file
```

---

# 🔎 6️⃣ awk Calculations Returning Zero or Wrong Values

## ❌ Problem

Math calculations incorrect.

## 🔍 Cause

Fields contain:

* Extra spaces
* Dollar signs
* Percent symbols

---

## 🔧 Fix

Clean characters before processing:

```bash
awk '{gsub(/[$%]/,""); total+=$2} END {print total}' file
```

---

# 🔎 7️⃣ Pipeline Not Producing Expected Output

## ❌ Problem

Complex pipeline fails or returns partial results.

Example:

```bash
grep "IT" file | sed ... | awk ...
```

## 🔍 Debug Strategy

Break pipeline into parts:

```bash
grep "IT" file
grep "IT" file | sed ...
grep "IT" file | sed ... | awk ...
```

Test each stage individually.

---

# 🔎 8️⃣ Special Characters in Regex Not Working

## ❌ Problem

Characters like `.`, `*`, `+`, `$` not behaving correctly.

## 🔍 Explanation

These are regex metacharacters.

---

## 🔧 Fix

Escape them:

```bash
grep "\." file
grep "\$100" file
```

Or use fixed string search:

```bash
grep -F "$100" file
```

---

# 🔎 9️⃣ Unexpected Decimal Formatting in awk

## ❌ Problem

awk drops decimal precision.

## 🔍 Cause

Default print formatting.

---

## 🔧 Fix

Use printf:

```bash
awk '{printf "%.2f\n", value}'
```

---

# 🔎 🔟 Large File Performance Issues

## ❌ Problem

Commands slow on large log files.

## 🔍 Recommendations

* Use `grep` instead of `cat file | grep`
* Use `LC_ALL=C` for faster grep:

```bash
LC_ALL=C grep "pattern" largefile.log
```

* Use `awk` instead of multiple pipes when possible.

---

# 🧠 Systematic Debug Workflow

When text processing fails:

```bash
head file
cat -A file
wc -l file
grep -n pattern file
awk -F',' '{print NF}' file
```

Always verify:

* Field separator
* Hidden whitespace
* Case sensitivity
* Regex anchors
* Special characters
* File encoding

---

# ⭐ Best Practices

## ✔ Use Explicit Field Separators

Always define `-F','` for CSV files.

## ✔ Backup Before In-Place Editing

```bash
sed -i.backup 's/old/new/g' file
```

## ✔ Build Pipelines Incrementally

Test each stage separately.

## ✔ Prefer awk for Calculations

Avoid mixing too many tools unnecessarily.

## ✔ Use man Pages

```bash
man grep
man sed
man awk
```

---

# 🎯 RHCSA Relevance

This troubleshooting knowledge is critical for:

* Parsing `/var/log/messages`
* Filtering audit logs
* Extracting user data from `/etc/passwd`
* Automating reports
* Diagnosing misformatted configuration files

---
