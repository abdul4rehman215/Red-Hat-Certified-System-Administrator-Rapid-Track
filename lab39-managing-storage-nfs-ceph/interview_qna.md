# 🎯 Interview Q&A - Lab 39: Managing Storage with NFS and Ceph

---

### 1️⃣ What is NFS and how does it work?

**Answer:**  
NFS (Network File System) is a file-based distributed file system protocol that allows remote systems to access shared directories over a network as if they were local.  
It works using an NFS server exporting directories and NFS clients mounting those directories.

---

### 2️⃣ What is the difference between NFS and Ceph?

| Feature | NFS | Ceph |
|----------|------|------|
| Storage Type | File Storage | Block/Object Storage |
| Scalability | Limited | Highly Scalable |
| Replication | Manual | Built-in |
| Fault Tolerance | Basic | Advanced |
| Kubernetes Support | Static PV | Dynamic via CSI |

---

### 3️⃣ What is an OSD in Ceph?

**Answer:**  
OSD (Object Storage Daemon) is a Ceph service that stores data, handles replication, recovery, and rebalancing.  
Each OSD usually maps to a physical disk or partition.

---

### 4️⃣ What is an RBD in Ceph?

**Answer:**  
RBD (RADOS Block Device) is a block storage interface in Ceph that allows block devices to be created from Ceph storage pools.  
It is commonly used in Kubernetes environments for persistent volumes.

---

### 5️⃣ What is the purpose of `cephadm bootstrap`?

**Answer:**  
It initializes the Ceph cluster by:
- Creating monitor (MON)
- Creating manager (MGR)
- Generating configuration
- Enabling dashboard access
- Preparing orchestration services

---

### 6️⃣ What is a Persistent Volume (PV) in Kubernetes?

**Answer:**  
A PV is a cluster-wide storage resource provisioned by an administrator or dynamically provisioned using a StorageClass.  
It abstracts physical storage into Kubernetes.

---

### 7️⃣ What is a Persistent Volume Claim (PVC)?

**Answer:**  
A PVC is a request for storage by a Kubernetes user or pod.  
It binds to a suitable PV based on capacity and access modes.

---

### 8️⃣ What is a StorageClass?

**Answer:**  
A StorageClass enables dynamic provisioning of volumes.  
It defines:
- Provisioner
- Storage backend
- Parameters
- Reclaim policy
- Volume expansion behavior

---

### 9️⃣ What is the Ceph CSI Driver?

**Answer:**  
CSI (Container Storage Interface) driver allows Kubernetes to communicate with Ceph for dynamic volume provisioning.  
It enables automatic creation and management of Ceph RBD volumes for pods.

---

### 🔟 What does RWX and RWO mean?

- **ReadWriteMany (RWX):** Multiple nodes can mount volume simultaneously (e.g., NFS)
- **ReadWriteOnce (RWO):** Volume can be mounted by only one node at a time (e.g., Ceph RBD)

---

### 1️⃣1️⃣ How do you check Ceph cluster health?

```bash
sudo ceph status
sudo ceph health detail
````

Healthy cluster should show:

```
health: HEALTH_OK
```

---

### 1️⃣2️⃣ How do you troubleshoot a PVC stuck in Pending state?

Steps:

1. Check PVC details:

   ```bash
   kubectl describe pvc <name>
   ```
2. Verify StorageClass:

   ```bash
   kubectl get storageclass
   ```
3. Check CSI pods:

   ```bash
   kubectl get pods -n kube-system | grep csi
   ```

---

### 1️⃣3️⃣ Why is Ceph preferred in enterprise environments?

Because it provides:

* Horizontal scalability
* Built-in replication
* High availability
* Self-healing architecture
* Multi-node fault tolerance
* Integration with Kubernetes & OpenShift

---

### 1️⃣4️⃣ What happens if one OSD fails?

Ceph automatically:

* Detects failure
* Marks OSD down
* Re-replicates data to maintain redundancy
* Restores cluster health once balanced

---

### 1️⃣5️⃣ How does Kubernetes interact with Ceph dynamically?

1. PVC is created.
2. StorageClass triggers CSI provisioner.
3. Ceph creates RBD image.
4. Volume is attached to pod.
5. Pod mounts the block device.

This is called **dynamic provisioning**.

---

# 🧠 Summary

This lab demonstrates strong understanding of:

* Enterprise file storage (NFS)
* Distributed block storage (Ceph)
* Kubernetes storage architecture
* CSI-based dynamic provisioning
* Production-level troubleshooting

These topics are highly relevant for:

* RHCSA / RHCE
* Kubernetes Administrator (CKA)
* DevOps Engineer roles
* Cloud Infrastructure positions
