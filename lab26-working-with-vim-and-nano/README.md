# 🧪 Lab 26: Working with vim and nano

Text editors are core tools for every Linux system administrator. In this lab, we worked hands-on with both **nano** (beginner-friendly) and **vim** (powerful modal editor) to create, edit, modify, and manage configuration files in a real RHEL/CentOS environment.

This lab strengthens practical RHCSA-level editing skills used daily in system administration.

---

## 🎯 Objectives

By the end of this lab, I was able to:

- Navigate and edit files using vim’s modes and commands
- Create and modify files using nano
- Understand differences between vim and nano
- Perform search, replace, copy, paste, and navigation in vim
- Save and exit properly in both editors
- Choose the appropriate editor based on the scenario

---

## 📋 Prerequisites

- Basic Linux CLI knowledge (`ls`, `cd`, `pwd`)
- Understanding of file creation and directories
- Basic file permission awareness
- Completion of previous Linux labs

---

## 🖥️ Lab Environment

- OS: CentOS / RHEL-based Linux
- Shell: `-bash-4.2$`
- Editors Installed:
  - `/usr/bin/vim`
  - `/usr/bin/nano`
- Full sudo access available

---

## 📁 Working Directory

```bash
~/text-editor-lab
````

Created using:

```bash
mkdir ~/text-editor-lab
cd ~/text-editor-lab
pwd
```

---

📂 Repository Structure

```
lab06-working-with-vim-and-nano/
│
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
├── troubleshooting.md
│
└── notes/
    ├── nano-cheatsheet.txt
    └── vim-cheatsheet.txt
```

---

## 📦 Files Created in This Lab

| File                       | Purpose                           |
| -------------------------- | --------------------------------- |
| `server-config.txt`        | nano-created server configuration |
| `network-settings.conf`    | vim-created network configuration |
| `comparison-nano.txt`      | nano editor comparison file       |
| `comparison-vim.txt`       | vim editor comparison file        |
| `/tmp/httpd.conf`          | simulated Apache configuration    |
| `/tmp/complex-config.conf` | advanced vim editing exercise     |
| `nano-cheatsheet.txt`      | nano quick reference              |
| `vim-cheatsheet.txt`       | vim quick reference               |

---

## 🧠 Skills Practiced

### 🔹 nano Skills

* Creating new files
* Navigation using arrow keys
* Cutting and pasting lines (Ctrl+K / Ctrl+U)
* Save (Ctrl+O)
* Exit (Ctrl+X)
* Editing configuration files safely

### 🔹 vim Skills

* Insert mode (`i`)
* Normal mode (Esc)
* Command mode (`:`)
* Navigation: `h j k l`, `w`, `b`, `0`, `$`, `gg`, `G`
* Copy (`yy`) and paste (`p`)
* Undo (`u`)
* Search (`/pattern`)
* Line numbers (`:set number`)
* Go to line (`:5`)
* Global replace (`:%s/old/new/g`)
* Save & Quit (`:wq`)
* Force quit (`:q!`)

---

## 🆚 vim vs nano (Comparison)

| Feature          | nano        | vim             |
| ---------------- | ----------- | --------------- |
| Learning Curve   | Easy        | Steep           |
| Modes            | No          | Yes             |
| Best For         | Quick edits | Complex editing |
| Commands Visible | Yes         | No              |
| Advanced Editing | Limited     | Very powerful   |

---

## 🧪 Lab Verification Commands

```bash
ls -la ~/text-editor-lab/
cat ~/text-editor-lab/server-config.txt
cat ~/text-editor-lab/network-settings.conf
cat /tmp/complex-config.conf
```

---

## 🎯 RHCSA Relevance

This lab directly supports RHCSA objectives:

* Editing configuration files
* Modifying service settings
* Working inside `/etc/`
* Troubleshooting configuration issues
* Performing safe edits in production systems

---

## ✅ Conclusion

I now understand:

* When to use nano for fast, safe configuration edits
* When to use vim for advanced manipulation
* How vim’s modal system works
* How to perform powerful search and replace
* How to safely save and exit without corrupting files

Mastering these editors significantly increases your efficiency as a Linux administrator.

---
