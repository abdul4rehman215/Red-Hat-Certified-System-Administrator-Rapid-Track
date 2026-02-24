# 🗄 Lab 39: Managing Storage with NFS and Ceph

---

## 🎯 Objective

This lab focuses on implementing enterprise storage solutions using:

- NFS (Network File System) for shared file storage
- Ceph for distributed block storage
- Kubernetes integration with Persistent Volumes
- Storage troubleshooting and validation

By completing this lab, I gained hands-on experience configuring traditional file storage and modern distributed storage systems within a clustered environment.

---

## 🖥 Lab Environment

| Node      | Role |
|-----------|-------|
| server1   | NFS Server + Ceph Bootstrap + Kubernetes Master |
| server2   | NFS Client + Ceph Node |
| server3   | Ceph Node |
| server4   | Kubernetes Worker |

### 🌐 Network Configuration

- server1 → 192.168.1.10  
- server2 → 192.168.1.11  
- server3 → 192.168.1.12  
- server4 → 192.168.1.13  

---

## 📂 Repository Structure

```

lab39-managing-storage-nfs-ceph/
│
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
├── troubleshooting.md
│
├── k8s-manifests/
│   ├── nfs-pv.yaml
│   ├── nfs-pvc.yaml
│   ├── nfs-deployment.yaml
│   ├── ceph-storageclass.yaml
│   ├── ceph-pvc.yaml
│   └── ceph-deployment.yaml
│
└── configs/
└── exports.conf

```

---

## 🚀 Task Overview

### 🔹 Task 1: Configure NFS Server and Client
- Installed and configured NFS server
- Created export directories
- Configured `/etc/exports`
- Mounted NFS shares on client
- Enabled persistent mounting via `/etc/fstab`
- Validated file sharing across nodes

---

### 🔹 Task 2: Deploy Ceph Distributed Storage
- Installed Ceph components on 3 nodes
- Bootstrapped Ceph cluster
- Added OSDs (Object Storage Daemons)
- Created RBD storage pool
- Created and mapped block device
- Formatted and mounted Ceph block storage
- Validated write operations

---

### 🔹 Task 3: Integrate Storage with Kubernetes
- Created NFS Persistent Volume and PVC
- Deployed application using shared NFS storage
- Installed Ceph CSI driver
- Created Ceph StorageClass
- Provisioned dynamic Ceph PVC
- Deployed application using Ceph RBD storage
- Verified data persistence

---

## 🔥 What I Learned

- Difference between file storage (NFS) and block storage (Ceph)
- How distributed storage achieves scalability and redundancy
- Ceph cluster bootstrapping and OSD management
- Kubernetes Persistent Volume architecture
- CSI driver integration for dynamic provisioning
- Enterprise storage troubleshooting techniques

---

## 🏢 Real-World Relevance

This lab simulates real enterprise environments where:

- Applications require persistent shared storage
- Kubernetes clusters need dynamic storage provisioning
- Storage must be scalable and highly available
- Hybrid cloud and on-prem infrastructures coexist

---

## 📊 Storage Comparison

| Feature        | NFS | Ceph |
|---------------|------|------|
| Storage Type  | File-based | Block-based |
| Access Mode   | RWX | RWO |
| Scalability   | Limited | Highly Scalable |
| Replication   | Manual | Built-in |
| Enterprise Use | Shared directories | Cloud-native infrastructure |

---

## 🧠 Why This Matters

Modern infrastructure depends heavily on reliable storage systems.  
Understanding both traditional NFS and distributed Ceph prepares me for:

- RHCSA / RHCE / OpenShift certifications
- Kubernetes administration roles
- DevOps & Cloud Engineering
- Enterprise Linux system administration

---

## ✅ Result

Successfully configured:

- Fully functional NFS shared storage
- 3-node Ceph distributed cluster
- Kubernetes integration with both storage backends
- Verified persistent data across workloads
