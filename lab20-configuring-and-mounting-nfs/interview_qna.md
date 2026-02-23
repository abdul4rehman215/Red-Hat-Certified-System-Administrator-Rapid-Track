# 🎤 Interview Q&A — Lab 20: Configuring and Mounting NFS

---

## 1) What is NFS?
NFS (Network File System) allows a Linux system to share directories over the network so remote machines can mount them as if they were local filesystems.

---

## 2) Which file controls NFS exports on the server?
`/etc/exports`

---

## 3) What command applies export rules without rebooting?
```bash
exportfs -arv
````

---

## 4) How do you verify what is exported from an NFS server?

```bash
exportfs -v
```

---

## 5) What package provides NFS server/client utilities on RHEL?

`nfs-utils`

---

## 6) How do you mount an NFS share temporarily?

```bash
mount -t nfs 192.168.56.10:/shared /mnt/nfs
```

---

## 7) How do you make an NFS mount persistent across reboots?

Add an entry to `/etc/fstab`, then test with:

```bash
mount -a
```

---

## 8) What does `sync` mean in `/etc/exports`?

It forces the server to write changes to disk before replying, improving reliability (at the cost of performance).

---

## 9) What is `no_root_squash` and why is it risky?

It allows root on the client to act as root on the server share. Risky because it can enable privilege abuse if a client is compromised.

---

## 10) What is the safer alternative to `no_root_squash`?

Use `root_squash` (default behavior), which maps remote root to an unprivileged user.

---

## 11) How do you confirm a mount is active on the client?

```bash
df -hT | grep nfs
```

---

## 12) Common reason for “access denied by server” error?

* Incorrect client IP/network in `/etc/exports`
* Export not applied (`exportfs -arv` not run)
* File permissions on exported directory

---

## 13) What firewall change is commonly needed for NFS?

Allow NFS service:

```bash
firewall-cmd --permanent --add-service=nfs
firewall-cmd --reload
```

---

## 14) Why avoid `chmod 777` on production NFS shares?

It allows read/write/execute to everyone, which is rarely acceptable in enterprise environments.

---

## 15) What are production-grade improvements for NFS security?

* Restrict exports to a subnet / specific hosts
* Use `root_squash`
* Harden permissions (least privilege)
* Consider Kerberos-authenticated NFS
* Apply firewall rules strictly
