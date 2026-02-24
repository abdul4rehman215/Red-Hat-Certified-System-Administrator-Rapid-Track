# ============================================================
# Task 1: NFS Server Configuration (server1)
# ============================================================

sudo dnf update -y
sudo dnf install -y nfs-utils

sudo mkdir -p /nfs/shared
sudo mkdir -p /nfs/data

sudo chmod 755 /nfs/shared
sudo chmod 755 /nfs/data

sudo chown nobody:nobody /nfs/shared
sudo chown nobody:nobody /nfs/data

sudo nano /etc/exports

sudo systemctl enable nfs-server
sudo systemctl start nfs-server

sudo systemctl enable rpcbind
sudo systemctl start rpcbind

sudo exportfs -a
sudo exportfs -v

cat /nfs/shared/test.txt


# ============================================================
# Task 1: NFS Client Configuration (server2)
# ============================================================

sudo dnf install -y nfs-utils

sudo mkdir -p /mnt/nfs-shared
sudo mkdir -p /mnt/nfs-data

SERVER_IP="192.168.1.10"
sudo mount -t nfs ${SERVER_IP}:/nfs/shared /mnt/nfs-shared
sudo mount -t nfs ${SERVER_IP}:/nfs/data /mnt/nfs-data

df -h | grep nfs

echo "Hello from NFS client" | sudo tee /mnt/nfs-shared/test.txt

echo "192.168.1.10:/nfs/shared /mnt/nfs-shared nfs defaults 0 0" | sudo tee -a /etc/fstab
echo "192.168.1.10:/nfs/data /mnt/nfs-data nfs defaults 0 0" | sudo tee -a /etc/fstab

sudo umount /mnt/nfs-shared /mnt/nfs-data
sudo mount -a


# ============================================================
# Task 2: Ceph Installation (server1, server2, server3)
# ============================================================

sudo dnf install -y centos-release-ceph-pacific
sudo dnf install -y ceph ceph-radosgw
sudo dnf install -y cephadm


# ============================================================
# Ceph Bootstrap (server1)
# ============================================================

sudo cephadm bootstrap --mon-ip 192.168.1.10

sudo ceph orch host add server2 192.168.1.11
sudo ceph orch host add server3 192.168.1.12

sudo ceph status


# ============================================================
# Configure OSDs (server1)
# ============================================================

sudo ceph orch device ls

sudo ceph orch daemon add osd server1:/dev/sdb
sudo ceph orch daemon add osd server2:/dev/sdb
sudo ceph orch daemon add osd server3:/dev/sdb

sudo ceph osd status


# ============================================================
# Create RBD Pool (server1)
# ============================================================

sudo ceph osd pool create rbd 32 32
sudo ceph osd pool application enable rbd rbd
sudo rbd pool init rbd

sudo rbd create --size 10G rbd/test-volume
sudo rbd ls rbd
sudo rbd info rbd/test-volume


# ============================================================
# Map and Test RBD (server1)
# ============================================================

sudo rbd map rbd/test-volume
rbd showmapped

sudo mkfs.ext4 /dev/rbd0

sudo mkdir -p /mnt/ceph-block
sudo mount /dev/rbd0 /mnt/ceph-block

df -h | grep ceph-block

echo "Hello from Ceph block storage" | sudo tee /mnt/ceph-block/test.txt
cat /mnt/ceph-block/test.txt


# ============================================================
# Kubernetes - NFS Integration (server1)
# ============================================================

nano nfs-pv.yaml
kubectl apply -f nfs-pv.yaml

nano nfs-pvc.yaml
kubectl apply -f nfs-pvc.yaml
kubectl get pvc

nano nfs-deployment.yaml
kubectl apply -f nfs-deployment.yaml
kubectl get deployments
kubectl get pods


# ============================================================
# Kubernetes - Ceph CSI Installation (server1)
# ============================================================

git clone https://github.com/ceph/ceph-csi.git
cd ceph-csi/deploy/rbd/kubernetes

kubectl apply -f csi-provisioner-rbac.yaml
kubectl apply -f csi-nodeplugin-rbac.yaml
kubectl apply -f csi-rbdplugin-provisioner.yaml
kubectl apply -f csi-rbdplugin.yaml

kubectl get pods -n kube-system | grep rbd


# ============================================================
# Create Ceph StorageClass (server1)
# ============================================================

CLUSTER_ID=$(sudo ceph fsid)
echo $CLUSTER_ID

nano ceph-storageclass.yaml
kubectl apply -f ceph-storageclass.yaml


# ============================================================
# Create Ceph Secret (server1)
# ============================================================

CEPH_ADMIN_KEY=$(sudo ceph auth get-key client.admin)

kubectl create secret generic csi-rbd-secret \
--from-literal=userID=admin \
--from-literal=userKey=${CEPH_ADMIN_KEY}


# ============================================================
# Ceph PVC + Deployment (server1)
# ============================================================

nano ceph-pvc.yaml
kubectl apply -f ceph-pvc.yaml
kubectl get pvc ceph-pvc

nano ceph-deployment.yaml
kubectl apply -f ceph-deployment.yaml
kubectl get pods -l app=ceph-app


# ============================================================
# Verification
# ============================================================

kubectl exec -it nfs-app-6f4c8d9d7f-abc12 -- touch /usr/share/nginx/html/nfs-test.txt
ls -la /nfs/shared/

kubectl exec -it ceph-app-7d9f8c6b9d-xyz12 -- touch /data/ceph-test.txt
sudo rbd du rbd/test-volume


# ============================================================
# Troubleshooting Commands
# ============================================================

sudo exportfs -v
sudo firewall-cmd --permanent --add-service=nfs
sudo firewall-cmd --reload

sudo ceph status
sudo ceph health detail
sudo ceph osd tree

kubectl describe pvc ceph-pvc
kubectl get storageclass
kubectl get pods -n kube-system | grep csi
