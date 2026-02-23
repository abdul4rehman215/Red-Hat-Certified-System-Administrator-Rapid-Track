# 🧪 Lab 31: Controlling the Boot Process (systemd + GRUB2)
 
> **Focus:** Boot process control, systemd targets/services, GRUB2 kernel parameters, rescue & emergency recovery

## 🎯 Objectives

By the end of this lab, I was able to:

* Understand the **systemd boot process** and how services/targets shape system startup
* View and analyze **systemd services** and **targets**
* Modify boot behavior using **GRUB2 kernel parameters** (temporary + permanent)
* Use **rescue mode** and **emergency mode** to troubleshoot boot failures
* Perform basic **boot troubleshooting** (logs, targets, fstab recovery)
* Configure system startup behavior by changing the **default systemd target**

---

## ✅ Prerequisites

* Comfortable with Linux CLI navigation and basic admin commands
* Familiar with text editing (nano/vim)
* sudo/root access in a CentOS/RHEL system
* Prior labs completed (basic system operations)

---

## 🖥️ Lab Environment

* **OS:** CentOS/RHEL (systemd-based)
* **Init system:** systemd
* **Bootloader:** GRUB2
* **Access:** Root / sudo
* **Note:** Some steps involve **rebooting** and temporarily editing GRUB entries.

---

## 📂 Repository Structure

```bash
lab31-controlling-the-boot-process/
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
└── troubleshooting.md
````

---

## 🧩 Tasks Overview

### ✅ Task 1: View systemd Services and Targets

* Checked systemd version and overall system health (`systemctl status`)
* Listed active and inactive services
* Inspected detailed service properties (`systemctl show`)
* Explored systemd targets and dependencies
* Practiced service management (start/stop/enable/disable)

### ✅ Task 2: Modify Boot Parameters with GRUB2

* Reviewed GRUB2 defaults (`/etc/default/grub`) and generated config (`/boot/grub2/grub.cfg`)
* Tested **temporary boot parameter changes** via GRUB edit at boot
* Performed **permanent bootloader configuration changes**
* Regenerated GRUB config using `grub2-mkconfig`
* Updated system boot behavior by setting default target (`systemctl set-default`)

### ✅ Task 3: Rescue Mode & Emergency Mode Troubleshooting

* Booted into **rescue.target** and verified minimal services
* Booted into **emergency.target** and observed minimal mounts/services
* Simulated a boot failure (bad `/etc/fstab` entry) and fixed it in rescue mode
* Practiced password reset / recovery style steps in minimal boot mode

---

## 🧪 Results

At the end of this lab, the system administrator workflow was validated:

* Boot mode can be changed **temporarily** (GRUB edit) and **permanently** (GRUB config + systemd default target)
* Rescue and emergency environments can be used to **recover misconfigurations**
* Boot issues can be diagnosed using:

  * `systemctl` targets/services
  * `journalctl -b` boot logs
  * configuration file validation (`/etc/fstab`, `/etc/default/grub`, grub.cfg)

---

## 📌 What I Learned

* How **systemd targets** replace classic runlevels and control boot behavior
* How to safely modify GRUB2 parameters for one-time boot troubleshooting
* How to apply persistent boot configuration changes properly (edit + regenerate config)
* How rescue/emergency targets help recover from **boot failures** like a broken `fstab`
* Why validating boot configs and keeping backups prevents downtime

---

## 🌍 Why This Matters (Real-World Relevance)

Boot problems are among the most high-impact production incidents. These skills help with:

* Recovering a server that drops to emergency shell due to bad mounts
* Switching boot targets for maintenance or troubleshooting
* Reducing attack surface by booting into non-graphical modes on servers
* Diagnosing slow/failing boots by inspecting services and dependencies
* RHCSA-level administration tasks that are frequently tested

---

## 🧾 Notes on Safety (Boot-Level Changes)

This lab includes steps that can cause boot disruption if done incorrectly:

* Editing **`/etc/fstab`** incorrectly can force emergency mode
* Changing GRUB config without regenerating it can lead to unexpected boot behavior

✅ Best practice followed in this lab:

* Backup before changes (example: `/etc/default/grub.backup`, `/etc/fstab.backup`)
* Validate changes using logs and target checks after reboot
