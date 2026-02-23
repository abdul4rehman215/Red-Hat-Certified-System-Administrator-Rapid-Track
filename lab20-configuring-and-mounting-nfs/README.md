# 🧪 Lab 20: Configuring and Mounting NFS (RHEL 9)

## 🎯 Objectives
- Configure an **NFS server**
- Export shared directories via **/etc/exports**
- Mount NFS share on a **client**
- Configure **persistent mounting** using **/etc/fstab**

---

## 🖥️ Lab Environment

### Systems
- 🖥 **NFS Server:** `rhel9-nfs-server` → `192.168.56.10`
- 🖥 **NFS Client:** `rhel9-nfs-client` → `192.168.56.20`

### Requirements
- Root/sudo privileges
- Network connectivity between server and client
- Package: `nfs-utils`

---

## 📁 Repository Structure (Lab 20)

```text
lab20-configuring-and-mounting-nfs/
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
└── troubleshooting.md
````

---

## 🧩 Tasks Overview

### ✅ Task 0: Environment Verification (Client → Server)

* Validate network connectivity via `ping`

### ✅ Task 1: Configure NFS Server (192.168.56.10)

* Install `nfs-utils`
* Enable and start `nfs-server`
* Create shared directory `/shared`
* Configure export rule in `/etc/exports`
* Apply exports with `exportfs`
* (Optional) Open firewall for NFS service

### ✅ Task 2: Configure NFS Client (192.168.56.20)

* Install `nfs-utils`
* Create mount point `/mnt/nfs`
* Mount share from server
* Verify mount and test write access

### ✅ Task 3: Persistent Mount (Client)

* Configure `/etc/fstab`
* Validate with `mount -a`
* Reboot verification

---

## ✅ Result

* NFS share exported from server and mounted on client
* Read/write verified across both systems
* Persistent mount confirmed after reboot

---

## 🔐 Security Relevance (Strong Linux Security Topic)

NFS is a common enterprise service and a frequent source of misconfiguration risk:

* Over-permissive exports (`no_root_squash`, `777`) can enable privilege abuse.
* Poor scoping (exporting to wide networks) increases attack surface.
* Best practice is to restrict exports, apply firewall rules, and use stronger auth when required.

---

## 🧾 Conclusion

In this lab, I successfully:

* Installed and enabled NFS services
* Exported `/shared` from the server to a specific client
* Mounted the remote export on the client
* Configured persistent mounting using `/etc/fstab`

This workflow is directly relevant to enterprise Linux administration, shared storage, and infrastructure operations.
