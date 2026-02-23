# 🧪 Lab 25: Text Processing with grep, sed, and awk

This lab builds strong **text-processing fundamentals** for Linux administration by practicing the three most important CLI tools for working with text streams and files:

- **grep** → search & filter text using patterns/regex  
- **sed** → transform text streams (replace, delete, insert, format)  
- **awk** → extract fields, compute metrics, build reports (mini programming language)

These skills are heavily used in real system administration for **log review, parsing config files, reporting, automation**, and RHCSA-style tasks.

---

## 🎯 Objectives

By the end of this lab, I was able to:

- Search for patterns in files and directories using **grep**
- Use **sed** for substitution, deletion, insertion, and formatting text streams
- Write and run **awk** one-liners and awk scripts for reporting and calculations
- Combine grep + sed + awk in pipelines to solve real-world tasks
- Understand core regex concepts used across Linux tools
- Efficiently process logs and structured data (CSV-like files)

---

## 📋 Prerequisites

- Comfortable with: `cd`, `ls`, `cat`, `pwd`
- Basic understanding of files/directories and permissions
- Any text editor knowledge (`nano`/`vim`)
- Regex basics helpful (but not required)

---

## 🖥️ Lab Environment

- CentOS/RHEL-based Linux (Bash 4.2+)
- Tools pre-installed:
  - `grep`
  - `sed`
  - `awk`
- Full terminal access (web/cloud lab)
- Root access available when needed

---

## 🗂️ Lab Working Directory

All work is done inside:

```bash
~/text_processing_lab
````

Created with:

```bash
mkdir ~/text_processing_lab
cd ~/text_processing_lab
pwd
```

---

## 📦 Files Created in This Lab

| File                    | Purpose                                                  |
| ----------------------- | -------------------------------------------------------- |
| `employees.txt`         | CSV-style employee dataset (name, role, dept, salary)    |
| `server_logs.txt`       | Example server log file with INFO/WARNING/ERROR          |
| `products.txt`          | Product inventory dataset (name, category, price, stock) |
| `employees_updated.txt` | Output of sed replacements                               |
| `employee_analysis.awk` | awk script for employee report                           |
| `process_data.sh`       | full pipeline report script                              |
| `system_monitor.sh`     | system-style log analyzer script                         |
| `messy_data.txt`        | unclean data used for formatting exercise                |

---

## ✅ What I Practiced

### 🔎 grep (search & filter)

* Case-sensitive and case-insensitive search (`grep`, `grep -i`)
* Counting matches (`grep -c`)
* Showing line numbers (`grep -n`)
* Inverting matches (`grep -v`)
* Extended regex (`grep -E`)
* Recursive search (`grep -r`)
* Pattern examples like:

  * lines starting with timestamps (`^2024...`)
  * salary patterns (`,[7-9][0-9]{4}$` style logic)
  * multi-pattern search (`ERROR|WARNING`)

### ✍️ sed (transform text)

* Substitution (single and global): `s/old/new/` and `s/old/new/g`
* Safe editing:

  * redirect to new file (`> file`)
  * backup before in-place edits (`cp file backup`)
* Delete lines:

  * by line number (`2d`)
  * by match (`/Manager/d`)
* Insert header/footer (`1i\...`, `$a\...`)
* Multi-step formatting with `-e`
* Regex replacements (masking salaries, formatting logs, extracting fields)

### 🧠 awk (extract, compute, report)

* Field extraction with separators (`-F','`)
* Formatting output (custom print strings)
* Using `NR` for line number tracking
* Conditional filtering (`$4 > 60000`, `$2 == "Manager"`)
* Arrays for counting categories
* Full awk script:

  * department counts
  * role counts
  * total/average salaries
  * highest paid employee

### 🔗 Pipelines (real-world style)

* grep → sed → awk to create clean reports
* log alert formatting
* category inventory totals
* end-to-end automation using scripts

---

## 🧪 Quick Verification Commands

```bash
# Count IT employees
grep -c "IT" employees.txt

# Replace IT and confirm count
sed 's/IT/Information Technology/g' employees.txt | grep -c "Information Technology"

# Average salary
awk -F',' '{total+=$4; count++} END {print total/count}' employees.txt

# Highest paid employee
awk -F',' '{if ($4>max){max=$4; name=$1}} END {print name, max}' employees.txt
```

---

## 📂 Structure for Repo

lab25-text-processing/
│
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
├── troubleshooting.md
│
└── scripts/
    ├── employee_analysis.awk
    ├── process_data.sh
    └── system_monitor.sh

---

## 📌 RHCSA / Real-World Relevance

This lab directly supports:

* Log filtering & quick incident review
* Data extraction and reporting (CSV/config parsing)
* Automation via pipelines and scripts
* Efficient troubleshooting using text-based patterns
