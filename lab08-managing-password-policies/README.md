# 🧪 Lab 08: Managing Password Policies

---

## 🎯 Objectives

By completing this lab, I was able to:

- 🔐 Enforce password complexity policies
- ⏳ Configure password aging and expiration rules
- 🧑‍💻 Apply password policies to users
- 🚫 Lock inactive accounts
- 🧪 Test password enforcement mechanisms

---

## 🖥️ Lab Environment

| Component | Value |
|------------|--------|
| OS | Red Hat Enterprise Linux 9.3 |
| User | student |
| Hostname | rhel9-sec-lab |
| Shell | Bash |

Prompt used:

```

-bash-4.2$

```id="h5znt3"

---

## 📂 Repository Structure

```

lab08-managing-password-policies/
│
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
└── troubleshooting.md

```id="m2av4l"

---

# 🧩 Task Overview

---

## 🔹 Task 1: Configure Password Complexity

- Installed `libpwquality`
- Modified `/etc/security/pwquality.conf`
- Enforced:
  - Minimum length (12 characters)
  - Uppercase requirement
  - Lowercase requirement
  - Digit requirement
  - Special character requirement
- Verified password strength using `pwscore`

---

## 🔹 Task 2: Configure Password Aging

- Modified `/etc/login.defs`
- Set:
  - Maximum password age (90 days)
  - Minimum password age (7 days)
  - Warning period (14 days)
- Applied aging policies using `chage`
- Verified configuration

---

## 🔹 Task 3: Enforce and Test Policies

- Rejected weak passwords
- Accepted strong passwords
- Forced password reset at next login
- Configured account inactivity lock
- Verified account expiration settings

---

# 🔐 Why This Lab Matters (Security Relevance)

Password policy enforcement protects against:

- Brute-force attacks
- Credential stuffing
- Weak password usage
- Dormant account abuse
- Insider threats

---

# 🏢 Enterprise Application

These configurations are critical for:

- RHEL production servers
- Identity governance
- Compliance frameworks (ISO, NIST, CIS benchmarks)
- Cloud infrastructure
- OpenShift cluster security
- Enterprise authentication controls

---

# 📈 Result

✔ Enforced strong password complexity  
✔ Implemented password expiration policy  
✔ Applied account inactivity controls  
✔ Verified password enforcement  
✔ Tested rejection of weak credentials  

---

# 🧠 What I Learned

- `libpwquality` controls complexity enforcement
- `/etc/security/pwquality.conf` defines password rules
- `/etc/login.defs` controls global aging defaults
- `chage` manages per-user password aging
- `passwd` enforces complexity through PAM
- Inactivity and expiration can be automated
- Password enforcement is tightly integrated with PAM

---

# 🏁 Conclusion

Password policy management is a fundamental Linux security control.

Strong password enforcement combined with expiration and inactivity locking:

- Reduces attack surface
- Improves compliance posture
- Enhances enterprise security
- Strengthens authentication hygiene

---

🔴 RHCSA Focus:
Password aging, complexity enforcement, chage usage, PAM integration.
