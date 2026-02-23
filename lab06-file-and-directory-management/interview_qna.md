# 🎤 Interview Q&A – Lab 06: File and Directory Management

> This section covers commonly asked interview questions related to file manipulation, directory management, and path handling in Linux.

---

## 1️⃣ What is the difference between `rm` and `rmdir`?

**Answer:**

- `rm` removes files and can remove directories using `-r` (recursive).
- `rmdir` removes **only empty directories**.

Example:

```bash
rm -r directory_name
rmdir empty_directory
````

---

## 2️⃣ What does the `-r` option in `rm -r` do?

**Answer:**

`-r` (recursive) allows deletion of directories and their contents.

Without `-r`, `rm` cannot delete directories.

---

## 3️⃣ What is the difference between `mv` and `cp`?

**Answer:**

* `mv` moves or renames files.
* `cp` copies files, creating duplicates.

Example:

```bash
mv file.txt /destination/
cp file.txt backup.txt
```

---

## 4️⃣ What is an absolute path?

**Answer:**

An absolute path starts from the root directory (`/`).

Example:

```bash
/home/toor/file.txt
```

It always points to the same location regardless of current directory.

---

## 5️⃣ What is a relative path?

**Answer:**

A relative path depends on the current working directory.

Example:

```bash
../documents/file.txt
```

It changes meaning based on where you are in the filesystem.

---

## 6️⃣ How do you create multiple directories at once?

**Answer:**

Using `mkdir -p` and brace expansion:

```bash
mkdir -p projects/{src,doc,bin}
```

This creates nested directories efficiently.

---

## 7️⃣ How can you move multiple files at once?

**Answer:**

Using wildcards:

```bash
mv *.txt destination_directory/
```

`*.txt` matches all files ending in `.txt`.

---

## 8️⃣ What does `pwd` do?

**Answer:**

`pwd` prints the current working directory.

It helps confirm your location in the filesystem.

---

## 9️⃣ How can you verify directory structure visually?

**Answer:**

Using:

```bash
tree
```

If not installed:

```bash
sudo apt install tree
```

---

## 🔟 How do you search for directories only?

**Answer:**

Using:

```bash
find . -type d
```

`-type d` filters directories only.

---

## 1️⃣1️⃣ What is the risk of using `rm -rf`?

**Answer:**

`rm -rf` deletes recursively and forcefully without confirmation.

If executed in the wrong directory, it can cause severe data loss.

Example dangerous command:

```bash
rm -rf /
```

Always verify location with `pwd` before using it.

---

## 1️⃣2️⃣ How do you copy directories?

**Answer:**

Use recursive copy:

```bash
cp -r directory_name backup_directory
```

Without `-r`, copy fails for directories.

---

## 1️⃣3️⃣ What happens if you move a file within the same filesystem?

**Answer:**

The inode remains the same.

The operation is fast because only directory references change.

---

## 1️⃣4️⃣ What happens if you move a file across filesystems?

**Answer:**

It behaves like a copy + delete operation.

The inode number changes.

---

## 1️⃣5️⃣ Why is file management important in enterprise environments?

**Answer:**

Because it is essential for:

* Deployment automation
* Backup management
* Log handling
* Application structure organization
* Container builds
* CI/CD pipelines

File mismanagement can lead to:

* Downtime
* Data loss
* Security vulnerabilities

---

# 🧠 Final Interview Insight

Strong Linux administrators:

* Use absolute paths in scripts
* Avoid dangerous recursive deletions
* Verify operations with `ls -l`
* Understand file movement behavior
* Use wildcards carefully

File and directory management is a foundational RHCSA skill.
