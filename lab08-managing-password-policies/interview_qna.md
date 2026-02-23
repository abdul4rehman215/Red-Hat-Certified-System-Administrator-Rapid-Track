# 🎤 Interview Q&A – Lab 08: Managing Password Policies

> This section covers commonly asked interview questions related to password policies, PAM configuration, and account security (RHCSA-focused).

---

## 1️⃣ What file controls password complexity in RHEL 8/9?

**Answer:**

Password complexity is controlled by:

```

/etc/security/pwquality.conf

````

It works through the `pam_pwquality` module in PAM.

---

## 2️⃣ What is `libpwquality`?

**Answer:**

`libpwquality` is a library that enforces password strength policies.

It checks:

- Minimum length
- Character classes
- Dictionary usage
- Repeated characters
- Sequence patterns

---

## 3️⃣ What does `minlen = 12` mean?

**Answer:**

It enforces a minimum password length of 12 characters.

Shorter passwords will be rejected.

---

## 4️⃣ What does `minclass = 4` enforce?

**Answer:**

It requires passwords to include at least 4 character classes:

- Lowercase letters
- Uppercase letters
- Digits
- Special characters

---

## 5️⃣ What command shows password aging information?

**Answer:**

```bash
sudo chage -l username
````

This displays:

* Last password change
* Expiration date
* Warning period
* Inactivity period

---

## 6️⃣ How do you force a user to change password at next login?

**Answer:**

```bash
sudo chage -d 0 username
```

This sets the last password change date to 0.

---

## 7️⃣ What file controls global password aging defaults?

**Answer:**

```
/etc/login.defs
```

Important parameters:

* PASS_MAX_DAYS
* PASS_MIN_DAYS
* PASS_WARN_AGE

---

## 8️⃣ What does `PASS_MAX_DAYS 90` do?

**Answer:**

It forces password expiration after 90 days.

Users must change their password once expired.

---

## 9️⃣ What is password inactivity lock?

**Answer:**

After password expiration, the account becomes inactive after a defined number of days.

Set using:

```bash
sudo chage -I days username
```

---

## 🔟 What does this command do?

```bash
sudo useradd -D -f 30
```

**Answer:**

Sets default inactivity period for new users to 30 days after password expiration.

---

## 1️⃣1️⃣ What role does PAM play in password enforcement?

**Answer:**

PAM (Pluggable Authentication Modules) enforces authentication rules.

`pam_pwquality.so` ensures password complexity rules are applied during password change.

Configuration file:

```
/etc/pam.d/system-auth
```

---

## 1️⃣2️⃣ How can you test password strength without changing password?

**Answer:**

Using:

```bash
echo "PasswordHere" | sudo pwscore
```

Higher score indicates stronger password.

---

## 1️⃣3️⃣ Why are password policies important in enterprise systems?

**Answer:**

They protect against:

* Brute-force attacks
* Weak credentials
* Credential stuffing
* Insider misuse
* Compliance violations

---

## 1️⃣4️⃣ What happens if PAM is misconfigured?

**Answer:**

Users may:

* Be unable to log in
* Bypass password complexity
* Experience authentication failures

Improper PAM changes can lock administrators out.

---

## 1️⃣5️⃣ How do password policies improve security posture?

**Answer:**

They:

* Enforce strong credentials
* Reduce compromise risk
* Improve compliance
* Enforce regular password rotation
* Disable dormant accounts

---

# 🧠 Final Interview Insight

A strong Linux security administrator:

* Understands PAM architecture
* Knows how to configure `pwquality`
* Uses `chage` effectively
* Enforces expiration policies
* Audits password compliance regularly

Password management is a core security competency in RHCSA and enterprise Linux administration.
