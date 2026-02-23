# 🛠️ Troubleshooting Guide - Lab 31: Boot Process Control
(systemd + GRUB2 + Rescue/Emergency Modes)

---

# 🔎 Issue 1: GRUB Menu Does Not Appear

## ❌ Symptom
System boots directly without showing GRUB menu.

## 🔍 Cause
`GRUB_TIMEOUT=0` in `/etc/default/grub`.

## ✅ Fix

Edit:
```bash
sudo nano /etc/default/grub
````

Set:

```bash
GRUB_TIMEOUT=5
```

Regenerate config:

```bash
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

Reboot.

---

# 🔎 Issue 2: Changes in `/etc/default/grub` Not Applied

## ❌ Symptom

Kernel parameters unchanged after reboot.

## 🔍 Cause

Forgot to regenerate GRUB configuration.

## ✅ Fix

```bash
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

(UEFI systems use `/boot/efi/EFI/centos/grub.cfg`)

---

# 🔎 Issue 3: System Boots Into Emergency Mode

## ❌ Symptom

Boot stops with emergency shell prompt.

## 🔍 Common Causes

* Invalid `/etc/fstab`
* Incorrect UUID
* Missing disk
* Corrupted filesystem

## ✅ Diagnosis

Check logs:

```bash
journalctl -xb
```

Check fstab:

```bash
cat /etc/fstab
```

Verify disks:

```bash
lsblk
blkid
```

## ✅ Fix Procedure

1. Remount root:

```bash
mount -o remount,rw /
```

2. Edit fstab:

```bash
nano /etc/fstab
```

3. Remove or fix bad entry

4. Reboot:

```bash
reboot
```

---

# 🔎 Issue 4: systemctl set-default Not Working

## ❌ Symptom

Default target does not change.

## 🔍 Cause

Incorrect target name.

## ✅ Check Available Targets

```bash
systemctl list-unit-files --type=target
```

Set correctly:

```bash
sudo systemctl set-default multi-user.target
```

Verify:

```bash
systemctl get-default
```

---

# 🔎 Issue 5: Service Not Starting at Boot

## ❌ Symptom

Service runs manually but not after reboot.

## 🔍 Cause

Service not enabled.

## ✅ Fix

```bash
sudo systemctl enable service_name
```

Check:

```bash
systemctl is-enabled service_name
```

---

# 🔎 Issue 6: Unable to Boot Due to Wrong Kernel Parameter

## ❌ Symptom

Kernel panic or boot failure after parameter change.

## ✅ Recovery

1. Reboot
2. At GRUB menu press **e**
3. Remove incorrect parameter
4. Boot with Ctrl+X

Then permanently fix `/etc/default/grub`.

---

# 🔎 Issue 7: Root Password Forgotten

## ✅ Recovery Steps

1. Boot into rescue mode:

```
systemd.unit=rescue.target
```

2. Remount root:

```bash
mount -o remount,rw /
```

3. Reset password:

```bash
passwd root
```

4. Reboot.

---

# 🔎 Issue 8: Rescue Mode Cannot Mount Root

## 🔍 Cause

Filesystem corruption.

## ✅ Fix

Run filesystem check:

```bash
fsck -y /dev/sda1
```

Then reboot.

---

# 🔎 Issue 9: Incorrect fstab UUID

## ❌ Symptom

Mount fails during boot.

## ✅ Verify Correct UUID

```bash
blkid
```

Replace UUID in `/etc/fstab` with correct value.

---

# 🔎 Issue 10: Graphical Target Fails to Start

## 🔍 Possible Causes

* Missing display manager
* Misconfigured GUI packages

## ✅ Temporary Workaround

Boot into:

```
systemd.unit=multi-user.target
```

Fix graphical stack manually.

---

# 🧠 Boot Troubleshooting Checklist

✔ Check `journalctl -xb`
✔ Verify `/etc/fstab`
✔ Verify disk UUIDs
✔ Ensure correct GRUB regeneration
✔ Confirm default target
✔ Check enabled services
✔ Test boot parameters temporarily before permanent change

---

# 🚨 High-Risk Files During Boot Administration

| File                   | Risk Level                       |
| ---------------------- | -------------------------------- |
| /etc/fstab             | Very High                        |
| /etc/default/grub      | High                             |
| /boot/grub2/grub.cfg   | Very High (Do Not Edit Directly) |
| default.target symlink | Medium                           |

---

# 🏁 Final Administrator Rule

When troubleshooting boot issues:

👉 Always boot minimally first (rescue/emergency)
👉 Fix configuration
👉 Verify logs
👉 Then return to normal target

Never make permanent boot changes without testing temporarily in GRUB first.

---

# ✅ Lab 31 Completed

I now have production-level understanding of:

* systemd targets & services
* GRUB2 configuration (temporary + permanent)
* Rescue & emergency recovery
* fstab boot failure recovery
* Password reset in minimal mode

This skill set is critical for RHCSA certification and real-world Linux system recovery.
