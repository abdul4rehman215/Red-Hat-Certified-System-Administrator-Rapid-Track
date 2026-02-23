# 🛠️ Troubleshooting Guide — Lab 26: Working with vim and nano

> This document outlines common problems encountered when using vim and nano, along with clear solutions and explanations.

---

# 1️⃣ Stuck in vim Insert Mode

## ❌ Problem
You cannot execute commands like `:wq` or `dd`. Text just keeps typing.

## 🔍 Cause
You are still in **Insert Mode**.

## ✅ Solution
Press:

```

Esc

```

This returns you to **Normal Mode**, where commands work.

---

# 2️⃣ Unable to Exit vim

## ❌ Problem
vim does not close when typing `q`.

## 🔍 Cause
You are not in Command Mode or file has unsaved changes.

## ✅ Solution

1. Press `Esc`
2. Then:

```

:q!

```

Force quit without saving

OR

```

:wq

```

Save and quit properly

---

# 3️⃣ Accidentally Modified a File in vim

## ❌ Problem
You changed something unintentionally.

## ✅ Solution

Undo changes:

```

u

```

Undo multiple times if needed.

Redo (if required):

```

Ctrl + r

```

---

# 4️⃣ vim Shows Strange Characters or Formatting

## ❌ Problem
File contains unexpected characters or spacing issues.

## 🔍 Possible Causes
- Opened a binary file
- File encoding mismatch
- Windows CRLF line endings

## ✅ Solutions

Check file type:

```

file filename

```

Convert line endings if needed:

```

dos2unix filename

```

---

# 5️⃣ Can't Find Text in vim

## ❌ Problem
Search doesn’t work as expected.

## ✅ Solution

Make sure you're in Normal Mode, then:

```

/search_term

```

Press:
- `n` → next match
- `N` → previous match

If search is case-sensitive unexpectedly:

```

:set ignorecase

```

---

# 6️⃣ nano Won’t Save File

## ❌ Problem
Pressing Ctrl+O gives permission error.

## 🔍 Cause
You don't have write permissions.

## ✅ Solution

Check permissions:

```

ls -l filename

```

Edit with sudo:

```

sudo nano filename

```

---

# 7️⃣ nano Exit Prompt Confusion

## ❌ Problem
nano asks "Save modified buffer?"

## ✅ Meaning

- `Y` → Save changes
- `N` → Exit without saving
- `Ctrl + C` → Cancel

---

# 8️⃣ vim File Permission Denied

## ❌ Problem
```

E212: Can't open file for writing

```

## 🔍 Cause
Insufficient permissions.

## ✅ Solution

Reopen with elevated privileges:

```

sudo vim filename

```

Or write with sudo inside vim:

```

:w !sudo tee %

```

---

# 9️⃣ Accidentally Replaced Too Much in vim

Example mistake:

```

:%s/server/node/g

```

It replaced unintended words.

## ✅ Solution

Immediately press:

```

u

```

Undo the global replacement.

---

# 🔟 Can't Navigate in Large File

## Problem
You are lost in a large config file.

## Solutions

In vim:

```

:set number

```

Jump to line:

```

:150

```

Go to start:

```

gg

```

Go to end:

```

G

```

In nano:

```

Ctrl + C

```

Shows current line number.

---

# 1️⃣1️⃣ File Saved But Content Missing

## Cause
You saved empty file accidentally.

## Prevention Tips

Before saving:
- Review file
- Scroll through entire content
- Use line numbers in vim

---

# 1️⃣2️⃣ Editing Critical System Files

## Best Practice

Before modifying production configs:

```

cp file file.backup

```

Example:

```

cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

```

This prevents configuration disasters.

---

# 🔐 Security Considerations

When editing configuration files:

- Avoid exposing plaintext passwords
- Restrict file permissions:

```

chmod 600 filename

```

- Verify ownership:

```

chown root:root filename

```

---

# 🎯 RHCSA Exam Tips

During the exam:

- Always press `Esc` before running vim commands.
- Use `:wq` confidently.
- Practice search and replace.
- Be comfortable editing `/etc/fstab`, `/etc/sysctl.conf`, network configs.

Time efficiency matters.

---

# 📌 Final Notes

Mastering vim and nano:

- Reduces configuration errors
- Speeds up troubleshooting
- Improves productivity
- Essential for Linux system administration

Both editors are tools — proficiency in at least one is mandatory for serious Linux professionals.

---
