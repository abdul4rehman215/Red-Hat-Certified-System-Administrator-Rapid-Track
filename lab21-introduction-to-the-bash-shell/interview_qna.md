# 🎤 Interview Q&A – Lab 21: Introduction to the Bash Shell

---

## 1️⃣ What is Bash, and why is it important in RHEL systems?

**Answer:**  
Bash (Bourne Again Shell) is the default command-line interpreter in most Linux distributions, including RHEL. It allows users to execute commands, automate tasks via scripts, and manage system operations. In RHEL environments, Bash is critical for administration, troubleshooting, automation, and RHCSA exam tasks.

---

## 2️⃣ How do you check which shell you are currently using?

**Answer:**  
You can use:

```bash
echo $SHELL
````

This displays the default login shell for the current user.

---

## 3️⃣ What is the difference between `>` and `>>` in redirection?

**Answer:**

* `>` → Overwrites the target file
* `>>` → Appends to the target file without overwriting existing content

Example:

```bash
echo "Hello" > file.txt     # Overwrites
echo "World" >> file.txt    # Appends
```

---

## 4️⃣ What does `2>&1` mean in Linux?

**Answer:**
`2>&1` redirects standard error (file descriptor 2) to the same location as standard output (file descriptor 1).

Example:

```bash
ls /nonexistent > combined.txt 2>&1
```

Both errors and output are written into `combined.txt`.

---

## 5️⃣ Explain the difference between absolute and relative paths.

**Answer:**

* **Absolute path:** Starts from `/` (root directory)
  Example: `/home/centos/lab1-practice`

* **Relative path:** Based on current working directory
  Example: `documents/readme.txt`

---

## 6️⃣ What does the pipe (`|`) operator do?

**Answer:**
The pipe operator passes the output of one command as input to another.

Example:

```bash
ls | wc -l
```

This counts the number of files returned by `ls`.

---

## 7️⃣ How do you make a script executable?

**Answer:**

```bash
chmod +x scriptname.sh
```

Then execute using:

```bash
./scriptname.sh
```

---

## 8️⃣ What is the purpose of the shebang (`#!/bin/bash`)?

**Answer:**
The shebang tells the system which interpreter should execute the script.
For Bash scripts:

```bash
#!/bin/bash
```

It ensures the script runs using the Bash shell.

---

## 9️⃣ What is the difference between `cat`, `less`, and `more`?

**Answer:**

* `cat` → Displays entire file at once
* `less` → Scrollable viewer (recommended for large files)
* `more` → Basic paginated output (older utility)

---

## 🔟 How does the `read` command work in Bash?

**Answer:**
The `read` command captures user input from the terminal and stores it in a variable.

Example:

```bash
read -p "Enter your name: " username
```

---

## 1️⃣1️⃣ What is command substitution?

**Answer:**
Command substitution allows you to use the output of a command inside another command.

Example:

```bash
echo "Today is: $(date)"
```

`$(date)` executes the `date` command and inserts the result.

---

## 1️⃣2️⃣ How do you count the number of files in a directory?

**Answer:**

```bash
ls | wc -l
```

This counts the number of visible files in the current directory.

---

## 1️⃣3️⃣ What does `grep "^d"` do when used with `ls -la`?

**Answer:**
It filters lines starting with `d`, meaning it selects only directories.

Example:

```bash
ls -la | grep "^d"
```

---

## 1️⃣4️⃣ Why is Bash scripting important for system administrators?

**Answer:**
Bash scripting enables automation of repetitive tasks such as:

* Backups
* System monitoring
* User creation
* Log processing
* Configuration validation

It improves efficiency and reduces manual errors in production environments.

---

## 1️⃣5️⃣ How does Bash differ from GUI-based system management?

**Answer:**
Bash:

* Faster for bulk operations
* Suitable for remote administration (SSH)
* Scriptable and automatable
* Required for RHCSA exam

GUI:

* Easier for beginners
* Limited automation capabilities

Enterprise Linux administration primarily relies on CLI tools.

---

# ✅ Interview Preparation Summary

This lab reinforces:

* Core Linux command usage
* Redirection and piping
* Shell scripting fundamentals
* Execution permissions
* Command chaining
* Error handling

These are foundational competencies evaluated in RHCSA certification and real-world Linux administration roles.
