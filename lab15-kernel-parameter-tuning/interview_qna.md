# 🎓 Interview Q&A – Lab 15: Kernel Parameter Tuning

---

## 1️⃣ What is sysctl in Linux?

`sysctl` is a utility used to view and modify **Linux kernel parameters at runtime**.

It allows administrators to tune:
- Memory management
- Networking behavior
- File descriptor limits
- Kernel security parameters

---

## 2️⃣ What is the difference between temporary and permanent sysctl changes?

| Type | Method | Persistence |
|------|--------|------------|
| Temporary | `sysctl -w parameter=value` | Lost after reboot |
| Permanent | Edit `/etc/sysctl.conf` or `/etc/sysctl.d/*.conf` | Survives reboot |

---

## 3️⃣ What does vm.swappiness control?

`vm.swappiness` controls how aggressively the kernel swaps memory pages to disk.

- Range: 0–100
- Default: 60 (Ubuntu)
- Lower value → Less swapping
- Higher value → More aggressive swapping

Production systems often use values between 1–20.

---

## 4️⃣ What is vm.overcommit_memory?

This parameter controls memory allocation behavior:

| Value | Meaning |
|-------|--------|
| 0 | Heuristic overcommit (default) |
| 1 | Always overcommit |
| 2 | Strict overcommit (never exceed swap + RAM limit) |

Used heavily in database and high-performance systems.

---

## 5️⃣ What does fs.file-max control?

`fs.file-max` defines the maximum number of file descriptors available system-wide.

High-traffic servers (web servers, proxies, databases) often increase this limit.

---

## 6️⃣ What is TCP Fast Open?

`net.ipv4.tcp_fastopen` enables data exchange during the TCP handshake.

Value meanings:
- 0 → Disabled
- 1 → Client enabled
- 2 → Server enabled
- 3 → Both enabled

Improves latency in repeated connections.

---

## 7️⃣ How do you apply sysctl changes without rebooting?

```bash
sudo sysctl -p
````

This reloads configuration from `/etc/sysctl.conf`.

---

## 8️⃣ Where should production kernel parameters be stored?

Best practice:

```
/etc/sysctl.d/99-custom.conf
```

This avoids modifying the main `sysctl.conf` file directly.

---

## 9️⃣ How do you check current kernel parameters?

```bash
sysctl -a
```

Or for specific values:

```bash
sysctl vm.swappiness
```

---

## 🔟 What risks exist when tuning kernel parameters incorrectly?

* System instability
* Memory allocation failures
* Network connectivity issues
* Kernel panics
* Application crashes

Kernel tuning must be tested in staging before production.

---

## 1️⃣1️⃣ How do you check file descriptor usage?

```bash
cat /proc/sys/fs/file-nr
```

Or:

```bash
ulimit -n
```

---

## 1️⃣2️⃣ What tool can be used to test system stress?

* `stress-ng`
* `stress`
* `sysbench`

These simulate CPU, memory, and I/O pressure.

---

## 1️⃣3️⃣ How does low swappiness improve performance?

Lower swappiness:

* Keeps active memory in RAM
* Reduces disk I/O
* Improves database and application performance

But too low may cause OOM if memory is exhausted.

---

## 1️⃣4️⃣ What is Transparent HugePages (THP)?

Transparent HugePages optimize memory usage by using larger page sizes.

However, some databases recommend disabling THP for performance predictability.

---

## 1️⃣5️⃣ Why is kernel tuning important in enterprise environments?

Kernel tuning helps:

* Improve performance
* Prevent resource exhaustion
* Optimize networking
* Stabilize memory usage
* Improve container orchestration performance

---

# 🏁 Interview Summary

Key topics covered:

✔ sysctl fundamentals
✔ Runtime vs persistent tuning
✔ Memory tuning (swappiness, overcommit)
✔ Network tuning (tcp_fastopen)
✔ File descriptor scaling
✔ Risk awareness in production systems

Kernel parameter tuning is a critical skill for enterprise Linux administrators.
