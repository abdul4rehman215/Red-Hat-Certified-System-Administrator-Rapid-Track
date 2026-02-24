# 📦 Lab 38: Introduction to Containers with Podman

---

## 🎯 Objectives

By completing this lab, I was able to:

- Understand containerization fundamentals and Podman architecture
- Install and configure Podman on RHEL/CentOS
- Pull, run, and manage container images
- Manage container lifecycle (start, stop, restart, remove)
- Build custom container images using a Containerfile
- Implement container networking and port mapping
- Create and manage persistent volumes
- Perform full container cleanup operations

---

## 📌 Prerequisites

- Basic Linux command-line knowledge
- File system navigation skills
- Familiarity with package management (dnf)
- Basic networking concepts (ports, IP, TCP)
- Text editor knowledge (nano)

---

## 🖥 Lab Environment

- CentOS/RHEL 8 system
- Root or sudo access
- Internet connectivity
- Pre-installed development tools
- Default container storage: `/var/lib/containers`

---

## 🧠 Overview of Tasks Performed

This lab includes the following major activities:

### 🔹 Task 1: Install Podman & Run Containers
- Installed Podman using `dnf`
- Pulled official container images
- Ran Apache web server container
- Created interactive container session
- Verified container networking and port mapping

### 🔹 Task 2: Image Management
- Listed and searched images
- Pulled specific image versions
- Inspected images
- Tagged and removed images
- Built custom image using Containerfile
- Ran custom-built container

### 🔹 Task 3: Container Operations & Networking
- Managed container lifecycle
- Viewed container logs
- Executed commands inside containers
- Copied files between host and container
- Monitored container resource usage
- Created and used named volumes
- Implemented custom container networks
- Verified inter-container communication
- Performed full cleanup of containers, images, volumes, and networks

---

## 📁 Repository Structure

```

lab38-podman-introduction/
│
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
├── troubleshooting.md
│
├── containerfiles/
│   └── Containerfile
│
├── web-content/
│   └── index.html
│
└── scripts/
└── (if any additional helper scripts are added)

```

---

## 🔐 Why This Matters

Containerization is foundational for:

- DevOps automation
- Cloud-native deployments
- Microservices architecture
- CI/CD pipelines
- Kubernetes orchestration
- RHCSA & Red Hat ecosystem certifications

Podman provides:

- Daemonless architecture
- Rootless container support
- Docker-compatible CLI
- Enhanced security integration with SELinux
- Enterprise-ready container management

---

## 🌍 Real-World Relevance

These skills are essential for:

- Linux System Administrators
- DevOps Engineers
- Cloud Engineers
- Platform Engineers
- Red Hat certification candidates

Containers are now the standard deployment model for modern applications.

---

## ✅ Result

After completing this lab, I can:

- Deploy applications in containers
- Build custom container images
- Configure persistent storage
- Implement secure networking between containers
- Troubleshoot and manage container environments
- Perform safe and complete cleanup operations

I now understand the fundamentals of container-based application deployment using Podman.
