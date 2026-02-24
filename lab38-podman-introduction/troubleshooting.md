# 🛠 Troubleshooting Guide - Lab 38: Introduction to Containers with Podman

---

## 🔴 Issue 1: Permission Denied When Running Podman

### Problem
Podman commands return permission errors.

### Cause
User does not have sufficient privileges or rootless setup is misconfigured.

### Solution

Run with sudo:
```bash
sudo podman <command>
````

Or configure rootless containers properly:

```bash
podman info | grep rootless
```

Ensure user namespaces are enabled:

```bash
cat /proc/sys/user/max_user_namespaces
```

---

## 🔴 Issue 2: Port Already in Use

### Problem

Container fails to start with port binding error.

Example error:

```
Error: bind: address already in use
```

### Diagnosis

Check which service is using the port:

```bash
ss -tulpn | grep :8080
```

### Solution

Use a different port:

```bash
podman run -p 8084:80 httpd:latest
```

Or stop the conflicting service.

---

## 🔴 Issue 3: Container Fails to Start

### Diagnosis

Check container logs:

```bash
podman logs <container-name>
```

Inspect container configuration:

```bash
podman inspect <container-name>
```

Verify image exists:

```bash
podman images
```

---

## 🔴 Issue 4: Image Pull Fails

### Possible Causes

* No internet connection
* Registry unavailable
* DNS issues

### Solutions

Test connectivity:

```bash
ping docker.io
```

Pull from alternative registry:

```bash
podman pull quay.io/httpd:latest
```

Check configured registries:

```bash
cat /etc/containers/registries.conf
```

---

## 🔴 Issue 5: Container Service Not Accessible

### Problem

Service inside container works but not accessible externally.

### Checklist

Verify port mapping:

```bash
podman port <container-name>
```

Verify firewall:

```bash
sudo firewall-cmd --list-ports
```

Open port if needed:

```bash
sudo firewall-cmd --add-port=8080/tcp --permanent
sudo firewall-cmd --reload
```

Verify service inside container:

```bash
podman exec -it <container-name> netstat -tulpn
```

---

## 🔴 Issue 6: Volume Data Not Persisting

### Problem

Data disappears after container removal.

### Cause

Container was not started with volume mount.

### Solution

Use named volume:

```bash
podman volume create web-data
podman run -v web-data:/data ...
```

Inspect volume:

```bash
podman volume inspect web-data
```

---

## 🔴 Issue 7: Containers Cannot Communicate on Custom Network

### Diagnosis

Check network exists:

```bash
podman network ls
```

Inspect network:

```bash
podman network inspect lab-network
```

Verify both containers are attached:

```bash
podman inspect <container> | grep Network
```

Test connectivity:

```bash
podman exec <container> ping <other-container-name>
```

---

## 🔴 Issue 8: Container Consumes High CPU or Memory

### Diagnosis

Monitor stats:

```bash
podman stats
```

Limit resources:

```bash
podman run --memory 512m --cpus 1 ...
```

Stop unnecessary containers:

```bash
podman stop <container>
```

---

## 🔴 Issue 9: SELinux Blocking Container

### Symptoms

Permission denied errors on mounted volumes.

### Solution

Use correct SELinux label:

```bash
podman run -v web-data:/data:Z ...
```

Check SELinux status:

```bash
sestatus
```

---

## 🔴 Issue 10: Cleanup Not Removing Everything

### Solution

Remove all containers:

```bash
podman rm -a
```

Prune system:

```bash
podman system prune -a
```

Verify cleanup:

```bash
podman ps -a
podman images
podman volume ls
podman network ls
```

---

# 🧪 Verification Checklist

✔ Podman installed correctly
✔ Containers run successfully
✔ Custom image builds without errors
✔ Volumes persist data
✔ Containers communicate on custom network
✔ Ports accessible externally
✔ Cleanup completed successfully

---

# 🔐 Security Relevance

Podman provides:

* Rootless container execution
* SELinux enforcement
* Reduced attack surface (daemonless)
* Secure image management
* Namespace isolation

Container security is critical in:

* Cloud environments
* Kubernetes clusters
* DevOps pipelines
* Production servers

---

# ✅ Final Notes

This troubleshooting guide ensures:

* Reliable container deployments
* Secure configuration
* Persistent storage correctness
* Network communication validation
* Proper resource management
* Clean environment maintenance

Mastering Podman troubleshooting is essential for RHCSA, OpenShift, and modern Linux administration.
