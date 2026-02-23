# 🎤 Interview Q&A – Lab 22: File System Navigation

---

## 1️⃣ What command is used to display the current working directory?

**Answer:**

```bash
pwd
````

It prints the absolute path of the current directory.

---

## 2️⃣ What is the difference between `cd /`, `cd ~`, and `cd ..`?

**Answer:**

* `cd /` → Moves to root directory
* `cd ~` → Moves to current user’s home directory
* `cd ..` → Moves one level up (parent directory)

---

## 3️⃣ What does `cd -` do?

**Answer:**

```bash
cd -
```

It switches to the previous working directory.

Useful for toggling between two directories.

---

## 4️⃣ What is the difference between `ls` and `ls -l`?

**Answer:**

* `ls` → Lists file names only
* `ls -l` → Lists detailed information including:

  * Permissions
  * Owner
  * Group
  * Size
  * Modification date

---

## 5️⃣ Explain the permission string `-rwxr-x--`.

**Answer:**

Breakdown:

| Section | Meaning                        |
| ------- | ------------------------------ |
| `-`     | Regular file                   |
| `rwx`   | Owner has read, write, execute |
| `r-x`   | Group has read, execute        |
| `---`   | Others have no permission      |

Numeric equivalent:

```bash
750
```

---

## 6️⃣ What does numeric permission 755 mean?

**Answer:**

| User   | Permission | Value |
| ------ | ---------- | ----- |
| Owner  | rwx        | 7     |
| Group  | r-x        | 5     |
| Others | r-x        | 5     |

Total: `755`

---

## 7️⃣ Why is execute permission required for directories?

**Answer:**

Execute permission on a directory allows:

* Entering the directory (`cd`)
* Accessing its contents

Without execute permission, even if read exists, listing will fail.

Example error:

```bash
ls: cannot open directory: Permission denied
```

---

## 8️⃣ What is the purpose of `mkdir -p`?

**Answer:**

```bash
mkdir -p dir1/dir2/dir3
```

* Creates parent directories if they don’t exist
* Prevents errors if directories already exist

---

## 9️⃣ How do you find all `.conf` files in `/etc` while suppressing errors?

**Answer:**

```bash
find /etc -name "*.conf" -type f 2>/dev/null
```

* `-name "*.conf"` → Matches .conf files
* `-type f` → Files only
* `2>/dev/null` → Hides permission errors

---

## 🔟 What does `stat -c "%a %n"` display?

**Answer:**

```bash
stat -c "%a %n" filename
```

* `%a` → Numeric permissions
* `%n` → File name

Example output:

```
750 permissions_test.txt
```

---

## 1️⃣1️⃣ Difference Between Numeric and Symbolic chmod?

**Numeric:**

```bash
chmod 755 file
```

**Symbolic:**

```bash
chmod g+x file
chmod o-r file
```

Numeric = faster for exact values
Symbolic = flexible and incremental

---

## 1️⃣2️⃣ Why did `./myscript.sh` initially fail?

**Answer:**

Because execute permission was missing:

```
Permission denied
```

Fix:

```bash
chmod +x myscript.sh
```

---

## 1️⃣3️⃣ What does `find . -type f` do?

**Answer:**

Finds all regular files starting from the current directory recursively.

---

## 1️⃣4️⃣ What happens if you set directory permission to 644?

**Answer:**

644 removes execute permission.

Result:

* Cannot enter directory
* Cannot list contents

Restore with:

```bash
chmod 755 directory_name
```

---

## 1️⃣5️⃣ Why is file permission management critical in Linux?

**Answer:**

Because it controls:

* Security
* Access control
* Script execution
* Application behavior
* Multi-user environment isolation

Improper permissions can lead to:

* Data breaches
* Unauthorized access
* Service failures

---

# 🎯 Interview Readiness Summary

This lab prepares you for:

* RHCSA permission-based questions
* Linux directory traversal tasks
* Troubleshooting “Permission Denied” errors
* Secure file management practices
* Enterprise Linux administration fundamentals

---
