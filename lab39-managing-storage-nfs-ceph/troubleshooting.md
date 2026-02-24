# 🛠 Troubleshooting Guide - Lab 39: Managing Storage with NFS and Ceph

---

# 🔹 SECTION 1: NFS Troubleshooting

---

## ❌ Issue 1: NFS Mount Fails (Access Denied)

### Error Example
```

mount.nfs: access denied by server

````

### Possible Causes
- Incorrect `/etc/exports` configuration
- Firewall blocking NFS service
- NFS service not running

### Solutions

Verify exports:
```bash
sudo exportfs -v
````

Reload exports:

```bash
sudo exportfs -a
```

Check NFS service:

```bash
sudo systemctl status nfs-server
```

Open firewall for NFS:

```bash
sudo firewall-cmd --permanent --add-service=nfs
sudo firewall-cmd --reload
```

---

## ❌ Issue 2: NFS Share Not Persisting After Reboot

### Cause

Incorrect `/etc/fstab` entry.

### Fix

Validate syntax:

```bash
cat /etc/fstab
```

Test mount manually:

```bash
sudo mount -a
```

If no errors appear, configuration is correct.

---

## ❌ Issue 3: Permission Denied When Writing to NFS

### Cause

Incorrect ownership or permissions.

### Fix

Check directory ownership:

```bash
ls -ld /nfs/shared
```

Correct ownership:

```bash
sudo chown nobody:nobody /nfs/shared
sudo chmod 755 /nfs/shared
```

---

# 🔹 SECTION 2: Ceph Troubleshooting

---

## ❌ Issue 4: Ceph Cluster Not Healthy

### Check Status

```bash
sudo ceph status
sudo ceph health detail
```

Common States:

| Status      | Meaning         |
| ----------- | --------------- |
| HEALTH_OK   | Cluster healthy |
| HEALTH_WARN | Minor issues    |
| HEALTH_ERR  | Serious problem |

---

## ❌ Issue 5: OSD Not Up

### Check OSD Tree

```bash
sudo ceph osd tree
```

Restart OSD:

```bash
sudo systemctl restart ceph-osd@<id>
```

Re-check:

```bash
sudo ceph osd status
```

---

## ❌ Issue 6: RBD Mapping Fails

### Verify image exists

```bash
sudo rbd ls rbd
```

Map device manually:

```bash
sudo rbd map rbd/test-volume
```

Check mapped devices:

```bash
rbd showmapped
```

---

## ❌ Issue 7: Ceph Pool Not Created

### Verify Pools

```bash
sudo ceph osd pool ls
```

Create again:

```bash
sudo ceph osd pool create rbd 32 32
```

Enable application:

```bash
sudo ceph osd pool application enable rbd rbd
```

---

# 🔹 SECTION 3: Kubernetes Storage Troubleshooting

---

## ❌ Issue 8: PVC Stuck in Pending

### Diagnose

```bash
kubectl describe pvc <pvc-name>
```

Check StorageClass:

```bash
kubectl get storageclass
```

Check CSI pods:

```bash
kubectl get pods -n kube-system | grep rbd
```

---

## ❌ Issue 9: Pod Cannot Mount Volume

### Check Pod Events

```bash
kubectl describe pod <pod-name>
```

Verify Secret exists:

```bash
kubectl get secret csi-rbd-secret
```

Verify Ceph connectivity from node.

---

## ❌ Issue 10: Ceph CSI Pods Not Running

### Check Status

```bash
kubectl get pods -n kube-system
```

Restart deployment:

```bash
kubectl rollout restart deployment rbd-csi-provisioner -n kube-system
```

---

## ❌ Issue 11: NFS Deployment Pods Crash

### Check Logs

```bash
kubectl logs <pod-name>
```

Verify PV bound:

```bash
kubectl get pv
kubectl get pvc
```

---

# 🔹 SECTION 4: Performance & Resource Troubleshooting

---

## 🔎 Monitor Ceph Usage

```bash
sudo ceph df
sudo rbd du rbd/test-volume
```

---

## 🔎 Monitor Kubernetes Storage Usage

```bash
kubectl get pvc
kubectl describe pvc ceph-pvc
```

---

# 🔹 SECTION 5: Firewall & Network Issues

---

## Verify NFS Ports

```bash
ss -tulpn | grep 2049
```

## Verify Ceph Ports

```bash
ss -tulpn | grep 6789
```

---

# 🔹 SECTION 6: Security Best Practices

---

* Avoid using `no_root_squash` in production
* Restrict NFS access by IP
* Use Ceph authentication users instead of admin
* Rotate Ceph keys periodically
* Use RBAC in Kubernetes properly
* Enable SELinux enforcing mode

---

# ✅ Final Verification Checklist

✔ NFS shares mounted successfully
✔ Persistent mount working after reboot
✔ Ceph cluster HEALTH_OK
✔ OSDs up and in
✔ RBD image created and mapped
✔ Kubernetes PV & PVC bound
✔ Applications running with storage attached
✔ CSI pods healthy

---

# 🏁 Conclusion

This troubleshooting guide ensures stability across:

* Traditional NFS storage
* Distributed Ceph storage
* Kubernetes dynamic provisioning
* Enterprise storage integration

Mastering storage troubleshooting is critical for:

* RHCSA / RHCE
* Kubernetes Administrator roles
* DevOps Engineers
* Cloud Infrastructure Engineers
