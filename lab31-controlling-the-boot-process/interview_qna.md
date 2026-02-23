# 🎯 Interview Q&A - Lab 31: Boot Process Control 

---

## 🔹 Basic Level

### 1️⃣ What is systemd?
**Answer:**  
systemd is the init system and service manager used in modern Linux distributions.  
It is responsible for:
- Boot process initialization
- Managing services (start/stop/restart)
- Handling targets (replacement for runlevels)
- Managing logs via journald

---

### 2️⃣ What replaced traditional runlevels in systemd?
**Answer:**  
Systemd uses **targets** instead of runlevels.

| Old Runlevel | systemd Target |
|--------------|----------------|
| 0 | poweroff.target |
| 1 | rescue.target |
| 3 | multi-user.target |
| 5 | graphical.target |
| 6 | reboot.target |

---

### 3️⃣ How do you check the current default target?

```bash
systemctl get-default
````

---

### 4️⃣ How do you change the default boot target permanently?

```bash
sudo systemctl set-default multi-user.target
```

---

### 5️⃣ How do you list active services?

```bash
systemctl list-units --type=service --state=active
```

---

## 🔹 Intermediate Level

### 6️⃣ What is GRUB2?

**Answer:**
GRUB2 (Grand Unified Bootloader v2) is the bootloader responsible for loading the Linux kernel during system startup.

It allows:

* Kernel selection
* Boot parameter modification
* Recovery boot modes
* Multi-OS booting

---

### 7️⃣ Where is the main GRUB configuration file located?

Editable configuration:

```
/etc/default/grub
```

Generated configuration (do not edit directly):

```
/boot/grub2/grub.cfg
```

---

### 8️⃣ After editing `/etc/default/grub`, what must you do?

**Answer:**
Regenerate GRUB configuration:

For BIOS:

```bash
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

For UEFI:

```bash
sudo grub2-mkconfig -o /boot/efi/EFI/centos/grub.cfg
```

---

### 9️⃣ How do you temporarily change boot parameters?

**Answer:**

1. Reboot
2. At GRUB menu press **e**
3. Edit the `linux` line
4. Add parameter (e.g., `systemd.unit=rescue.target`)
5. Press **Ctrl+X** to boot

---

### 🔟 What is rescue mode?

**Answer:**
Rescue mode is a minimal system environment that:

* Starts essential services only
* Mounts root filesystem
* Provides root shell access
* Used for troubleshooting system issues

Activated via:

```
systemd.unit=rescue.target
```

---

## 🔹 Advanced Level

### 1️⃣1️⃣ What is emergency mode?

**Answer:**
Emergency mode is more minimal than rescue mode.

* Does NOT mount filesystems automatically
* Provides minimal root shell
* Used for severe boot failures

Activated via:

```
systemd.unit=emergency.target
```

---

### 1️⃣2️⃣ What happens if `/etc/fstab` has an invalid entry?

**Answer:**
The system may:

* Fail to mount filesystems
* Drop into emergency mode
* Prevent normal boot

Fix:

* Boot into rescue mode
* Mount root as read-write
* Edit `/etc/fstab`
* Remove invalid entry

---

### 1️⃣3️⃣ How do you view boot logs?

```bash
journalctl -b
```

To see last boot:

```bash
journalctl -b -1
```

---

### 1️⃣4️⃣ How do you reset the root password from rescue mode?

1. Boot into rescue mode
2. Remount root:

```bash
mount -o remount,rw /
```

3. Change password:

```bash
passwd root
```

---

### 1️⃣5️⃣ Why is changing default target important in servers?

**Answer:**

* Servers typically use `multi-user.target` (no GUI)
* Reduces resource usage
* Improves security (less attack surface)
* Improves boot speed

---

## 🔹 Scenario-Based Questions

### 🧠 Scenario 1:

Server boots into emergency mode. What do you check first?

**Answer:**

* `/etc/fstab`
* Disk mount failures
* `journalctl -b`
* Incorrect UUIDs

---

### 🧠 Scenario 2:

GRUB changes are not applied after editing `/etc/default/grub`. Why?

**Answer:**
Because `grub2-mkconfig` was not executed after modification.

---

### 🧠 Scenario 3:

You want to boot temporarily into non-graphical mode without changing permanent configuration. What do you do?

**Answer:**
Edit GRUB entry and add:

```
systemd.unit=multi-user.target
```

---

## 🔹 RHCSA Exam Tips

✔ Understand difference between rescue & emergency
✔ Practice fstab recovery
✔ Know how to regenerate GRUB config
✔ Remember: edit → regenerate → reboot
✔ Always backup critical boot files

---

# ✅ Final Takeaway

Mastering boot process control ensures:

* Faster troubleshooting
* Reduced downtime
* Safe recovery from misconfiguration
* Confidence in production-level Linux administration
