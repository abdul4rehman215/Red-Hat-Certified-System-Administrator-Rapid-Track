# 🎤 Interview Q&A — Lab 26: Working with vim and nano

> This section covers commonly asked Linux interview questions related to text editors, configuration management, and practical RHCSA scenarios.

---

## 1️⃣ What is the main difference between vim and nano?

- **nano** is simple, non-modal, and beginner-friendly.
- **vim** is modal (Normal, Insert, Command modes) and very powerful for advanced editing.

Nano shows command shortcuts on screen. Vim requires memorizing commands but offers significantly more flexibility.

---

## 2️⃣ What are the main modes in vim?

- **Normal Mode** → Navigation and editing commands (default)
- **Insert Mode** → Typing text (`i`)
- **Command Mode** → Save, quit, search (`:`)

---

## 3️⃣ How do you save and exit in vim?

```bash
:wq
````

Other options:

* `:w` → Save only
* `:q` → Quit (if no changes)
* `:q!` → Quit without saving

---

## 4️⃣ How do you enter Insert Mode in vim?

Press:

```text
i
```

Return to Normal mode with:

```text
Esc
```

---

## 5️⃣ How do you copy and paste a line in vim?

* `yy` → Copy (yank) line
* `p` → Paste below
* `P` → Paste above

---

## 6️⃣ How do you search for text in vim?

In Normal mode:

```text
/ssh
```

Then:

* `n` → Next match
* `N` → Previous match

---

## 7️⃣ How do you perform global search and replace in vim?

```bash
:%s/old/new/g
```

Example:

```bash
:%s/server/node/g
```

---

## 8️⃣ How do you show line numbers in vim?

```bash
:set number
```

Disable:

```bash
:set nonumber
```

---

## 9️⃣ How do you undo changes in vim?

Press:

```text
u
```

Redo:

```text
Ctrl + r
```

---

## 🔟 What are important nano shortcuts?

| Shortcut | Action            |
| -------- | ----------------- |
| Ctrl + O | Save              |
| Ctrl + X | Exit              |
| Ctrl + K | Cut line          |
| Ctrl + U | Paste             |
| Ctrl + W | Search            |
| Ctrl + A | Beginning of line |
| Ctrl + E | End of line       |

---

## 1️⃣1️⃣ How do you exit nano without saving?

Press:

```text
Ctrl + X
```

Then select **No** when prompted to save.

---

## 1️⃣2️⃣ When should you use nano instead of vim?

Use nano when:

* Making quick configuration edits
* You need visible help
* Working on a simple system
* Training beginners

---

## 1️⃣3️⃣ When is vim preferred?

Use vim when:

* Editing large files
* Programming or scripting
* Performing complex replacements
* Navigating quickly through configs
* Working over SSH frequently

---

## 1️⃣4️⃣ How do you jump to a specific line in vim?

```bash
:5
```

Or:

```bash
5G
```

---

## 1️⃣5️⃣ Why are text editors critical for RHCSA?

Because RHCSA requires:

* Editing configuration files in `/etc/`
* Modifying service configs
* Writing scripts
* Updating network configurations
* Editing SELinux, firewall, and service files

Without editor mastery, you cannot complete many exam tasks efficiently.

---

# 🎯 Real-World Relevance

Editors are used daily for:

* `/etc/ssh/sshd_config`
* `/etc/httpd/conf/httpd.conf`
* `/etc/fstab`
* `/etc/sysctl.conf`
* Script editing
* Log review

Efficiency in vim especially saves significant time in production environments.

---
