# 🎤 Interview Q&A - Lab 38: Introduction to Containers with Podman

---

## 1️⃣ What is containerization?

Containerization is a lightweight virtualization method that packages an application and its dependencies into a container image.  
Containers share the host OS kernel but run in isolated environments.

This ensures:
- Portability
- Consistency across environments
- Fast deployment
- Efficient resource usage

---

## 2️⃣ What is Podman?

Podman (Pod Manager) is a daemonless container engine used to develop, manage, and run OCI containers on Linux systems.

Key characteristics:
- No central daemon (unlike Docker)
- Rootless container support
- Docker-compatible CLI
- Strong integration with SELinux
- Native systemd integration

---

## 3️⃣ What is the difference between Podman and Docker?

| Feature | Podman | Docker |
|----------|----------|----------|
| Daemon | No daemon | Requires daemon |
| Rootless | Native support | Limited |
| Security | Better SELinux integration | Requires extra config |
| CLI | Docker-compatible | Native |

Podman is often preferred in enterprise RHEL environments.

---

## 4️⃣ How do you pull and run a container?

Pull image:
```bash
podman pull httpd:latest
````

Run container:

```bash
podman run -d --name my-web-server -p 8080:80 httpd:latest
```

---

## 5️⃣ What does `-p 8080:80` mean?

It maps:

```
Host Port 8080 → Container Port 80
```

This allows external access to services running inside the container.

---

## 6️⃣ How do you list running containers?

```bash
podman ps
```

To list all containers (including stopped):

```bash
podman ps -a
```

---

## 7️⃣ How do you manage container lifecycle?

Stop:

```bash
podman stop <container>
```

Start:

```bash
podman start <container>
```

Restart:

```bash
podman restart <container>
```

Remove:

```bash
podman rm <container>
```

---

## 8️⃣ How do you view container logs?

```bash
podman logs <container>
```

Follow logs:

```bash
podman logs -f <container>
```

---

## 9️⃣ What is a Containerfile?

A Containerfile (similar to Dockerfile) defines how to build a custom container image.

Example:

```dockerfile
FROM httpd:latest
COPY index.html /usr/local/apache2/htdocs/
EXPOSE 80
```

It specifies:

* Base image
* Files to copy
* Ports to expose
* Commands to execute

---

## 🔟 What is a container volume?

A volume is persistent storage that exists outside the container lifecycle.

Why important:

* Data survives container deletion
* Separates application from data
* Used for databases, logs, uploads

Create volume:

```bash
podman volume create web-data
```

---

## 1️⃣1️⃣ What is container networking?

Containers can communicate:

* With host (port mapping)
* With other containers (custom networks)

Create network:

```bash
podman network create lab-network
```

Attach container:

```bash
podman run --network lab-network ...
```

---

## 1️⃣2️⃣ How do containers communicate with each other?

When on the same custom network:

* Containers resolve each other using container names
* They get private IP addresses

Example:

```bash
ping lab-database
```

---

## 1️⃣3️⃣ How do you copy files between host and container?

From host to container:

```bash
podman cp host-file.txt container:/path/
```

From container to host:

```bash
podman cp container:/path/file ./local-file
```

---

## 1️⃣4️⃣ How do you clean unused resources?

Remove stopped containers:

```bash
podman container prune
```

Remove unused images:

```bash
podman image prune
```

Remove volumes:

```bash
podman volume prune
```

Remove networks:

```bash
podman network prune
```

---

## 1️⃣5️⃣ Why is Podman important for RHCSA and enterprise Linux?

Because:

* RHEL uses Podman instead of Docker
* Strong security model (SELinux integrated)
* Used in OpenShift & Kubernetes environments
* Required skill for modern Linux admins
* Core DevOps and cloud deployment tool

---

# ✅ Summary

This lab demonstrates:

* Container creation
* Image management
* Custom image building
* Volume persistence
* Container networking
* Lifecycle management
* Cleanup best practices

Mastering Podman is essential for:

* DevOps engineers
* Linux system administrators
* Cloud engineers
* Red Hat certification candidates
