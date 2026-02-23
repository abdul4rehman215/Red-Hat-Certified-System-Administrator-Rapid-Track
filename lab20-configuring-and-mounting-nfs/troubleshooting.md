# 🛠 Troubleshooting — Lab 20: Configuring and Mounting NFS (RHEL 9)

---

## 1) Client cannot reach server (mount timeout)
✅ Check connectivity:
```bash
ping -c 3 192.168.56.10
````

✅ Confirm correct IPs and routing:

```bash
ip a
ip r
```

---

## 2) NFS service not running on server

✅ Check status:

```bash
systemctl status nfs-server
```

✅ Start + enable:

```bash
systemctl enable --now nfs-server
```

---

## 3) “access denied by server while mounting”

✅ Validate `/etc/exports` contains the correct client IP:

```text
/shared 192.168.56.20(rw,sync,no_root_squash)
```

✅ Re-apply exports:

```bash
exportfs -arv
exportfs -v
```

---

## 4) Firewall blocking NFS

✅ Allow NFS:

```bash
firewall-cmd --permanent --add-service=nfs
firewall-cmd --reload
```

✅ If still blocked, confirm firewall is running:

```bash
systemctl status firewalld
```

---

## 5) Mount works but files cannot be written

✅ Check permissions on server export path:

```bash
ls -ld /shared
```

✅ Test file creation from client:

```bash
touch /mnt/nfs/testfile
```

---

## 6) fstab entry causes boot delay / fail

✅ Use `_netdev` to ensure it waits for network:
Example:

```text
192.168.56.10:/shared  /mnt/nfs  nfs  defaults,_netdev  0  0
```

✅ Test safely before reboot:

```bash
mount -a
```

---

## 7) Export visible but not updating on client

✅ Remount:

```bash
umount /mnt/nfs
mount -t nfs 192.168.56.10:/shared /mnt/nfs
```

✅ Check current mounts:

```bash
mount | grep nfs
```

---

## 🔐 Security Notes (Enterprise)

* Avoid `no_root_squash` unless explicitly required.
* Avoid world-writable permissions (777).
* Restrict exports to least required hosts/subnets.
* Prefer stronger authentication (Kerberos) when needed.
