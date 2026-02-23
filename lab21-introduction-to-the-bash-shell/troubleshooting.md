# 🛠️ Troubleshooting Guide – Lab 21: Introduction to the Bash Shell

---

## 📌 Overview

This document outlines common issues encountered during the Bash shell lab and the corresponding resolutions.  
The problems listed below reflect realistic beginner and intermediate mistakes in a RHEL/CentOS environment.

---

# 1️⃣ Permission Denied When Running a Script

### ❌ Error Example

```bash
-bash-4.2$ ./hello-world.sh
-bash: ./hello-world.sh: Permission denied
````

### 🔍 Cause

The script does not have execute permissions.

### ✅ Solution

```bash
chmod +x hello-world.sh
```

Then run:

```bash
./hello-world.sh
```

### 💡 Prevention Tip

Always verify permissions:

```bash
ls -l scriptname.sh
```

Look for `x` in the permission field (`-rwxr-xr-x`).

---

# 2️⃣ Command Not Found

### ❌ Error Example

```bash
-bash-4.2$ system-report.sh
-bash: system-report.sh: command not found
```

### 🔍 Cause

The script is in the current directory, but `.` is not in the system PATH.

### ✅ Solution

Run using:

```bash
./system-report.sh
```

### 💡 Explanation

Linux does not search the current directory for executables unless explicitly referenced.

---

# 3️⃣ File or Directory Not Found

### ❌ Error Example

```bash
ls: cannot access documents/readme.txt: No such file or directory
```

### 🔍 Cause

* Typographical error
* Wrong working directory
* File was moved or deleted

### ✅ Solution

Verify location:

```bash
pwd
ls
```

Search file:

```bash
find . -name "readme.txt"
```

---

# 4️⃣ Redirection Overwrites File Accidentally

### ❌ Problem

Using:

```bash
echo "New content" > file.txt
```

Overwrites previous content.

### 🔍 Cause

Using `>` instead of `>>`.

### ✅ Correct Usage

Append instead:

```bash
echo "New content" >> file.txt
```

### 💡 Recommendation

Be cautious when using `>` in production environments.

---

# 5️⃣ Sorting Numbers Incorrectly

### ❌ Unexpected Output

```bash
sort < numbers.txt
10
15
25
30
5
```

### 🔍 Cause

Default `sort` performs alphabetical (string-based) sorting.

### ✅ Correct Numeric Sort

```bash
sort -n numbers.txt
```

### 💡 Explanation

Use `-n` for numeric sorting.

---

# 6️⃣ Syntax Errors in Bash Scripts

### ❌ Example Error

```bash
syntax error near unexpected token `fi'
```

### 🔍 Cause

* Missing `then`
* Missing `fi`
* Incorrect spacing in conditionals

### ✅ Debugging Method

Run script in debug mode:

```bash
bash -x scriptname.sh
```

This shows step-by-step execution.

---

# 7️⃣ Variables Not Expanding in Script

### ❌ Issue

Variables appear literally instead of expanding.

### 🔍 Cause

Using single quotes `'` instead of double quotes `"`.

### ❌ Incorrect

```bash
echo 'User is $USER'
```

### ✅ Correct

```bash
echo "User is $USER"
```

---

# 8️⃣ Here-Document (EOF) Not Working

### ❌ Issue

Script hangs waiting for input.

### 🔍 Cause

Improper EOF placement or spacing.

### ✅ Correct Structure

```bash
cat << EOF
Text content
EOF
```

Ensure:

* `EOF` is not indented
* No trailing spaces

---

# 9️⃣ Backup Script Not Copying Files

### ❌ Issue

Script runs but does not copy files.

### 🔍 Cause

No `.txt` files exist in directory.

### ✅ Solution

Verify:

```bash
ls *.txt
```

If no files appear, create test files first.

---

# 🔟 Incorrect Path When Using cd

### ❌ Example

```bash
cd lab1-practice/scripts
-bash: cd: lab1-practice/scripts: No such file or directory
```

### 🔍 Cause

Not in correct parent directory.

### ✅ Fix

Use absolute path:

```bash
cd ~/lab1-practice/scripts
```

---

# 1️⃣1️⃣ Script Executes but Output Is Unexpected

### 🔍 Debug Steps

1. Check current directory:

   ```bash
   pwd
   ```
2. Print variable values inside script:

   ```bash
   echo "DEBUG: username=$username"
   ```
3. Use debug mode:

   ```bash
   bash -x scriptname.sh
   ```

---

# 1️⃣2️⃣ Accidentally Deleted Important File

### ⚠️ Important

Linux does not have a recycle bin in CLI.

### 🔍 Recovery Options

* Restore from backup (if available)
* Recreate file manually
* Use version control if implemented

### 💡 Recommendation

Avoid using:

```bash
rm -rf *
```

Without careful verification.

---

# 🧠 Best Practices Learned

* Always verify location using `pwd`
* Check file existence using `ls`
* Validate script permissions before execution
* Use `-n`, `-h`, and flags appropriately
* Test scripts in a controlled environment
* Use debugging (`bash -x`) for script troubleshooting
* Avoid running destructive commands without confirmation

---

# ✅ Final Validation Checklist

Before marking the lab complete:

* [ ] All directories created successfully
* [ ] Scripts executable
* [ ] Scripts tested and verified
* [ ] Redirection files created
* [ ] Backup folder generated
* [ ] No syntax errors in scripts
* [ ] Output verified

---

# 🎯 Summary

This troubleshooting guide reinforces:

* Proper command execution
* Script debugging
* Safe file handling
* Redirection awareness
* Error identification and resolution

Mastering these troubleshooting steps is critical for real-world Linux system administration and for successfully passing the RHCSA exam.

---

✅ Lab 21 Troubleshooting Completed
