# =========================================
# Task 1: Install Podman & Create Containers
# =========================================

sudo dnf update -y
sudo dnf install -y podman
podman --version
podman info

# Pull Apache image
podman pull docker.io/library/httpd:latest

# Run Apache container
podman run -d --name my-web-server -p 8080:80 httpd:latest
podman ps
curl http://localhost:8080

# Interactive container
podman run -it --name interactive-centos centos:latest /bin/bash
cat /etc/os-release
ps aux
ip addr show
echo "Hello from container" > /tmp/test.txt
cat /tmp/test.txt
exit

# =========================================
# Task 2: Manage Container Images
# =========================================

podman images
podman search nginx
podman pull docker.io/library/nginx:1.21-alpine
podman inspect httpd:latest

podman tag httpd:latest my-custom-web:v1.0
podman images | grep my-custom-web
podman rmi my-custom-web:v1.0
podman image prune

# Custom image creation
mkdir ~/custom-web-app
cd ~/custom-web-app
nano index.html
nano Containerfile
podman build -t my-web-app:latest .
podman run -d --name custom-web -p 8081:80 my-web-app:latest
curl http://localhost:8081

# =========================================
# Task 3: Container Lifecycle Management
# =========================================

podman ps -a
podman stop my-web-server
podman start my-web-server
podman restart my-web-server
podman logs my-web-server
podman logs -f my-web-server

podman exec -it my-web-server /bin/bash
ls -la conf/
cat htdocs/index.html
exit

echo "This file was copied from host" > host-file.txt
podman cp host-file.txt my-web-server:/usr/local/apache2/htdocs/
podman cp my-web-server:/usr/local/apache2/htdocs/index.html ./container-index.html
ls -l container-index.html

podman stats my-web-server

# =========================================
# Volumes
# =========================================

podman volume create web-data
podman volume ls
podman run -d --name web-with-volume -p 8082:80 -v web-data:/usr/local/apache2/htdocs httpd:latest
podman exec web-with-volume sh -c 'echo "<h1>Data from Volume</h1>" > /usr/local/apache2/htdocs/volume.html'
curl http://localhost:8082/volume.html
podman volume inspect web-data

# =========================================
# Networking
# =========================================

podman network create lab-network
podman network ls

podman run -d --name lab-database --network lab-network -e MYSQL_ROOT_PASSWORD=labpassword mysql:8.0
podman run -d --name lab-webapp --network lab-network -p 8083:80 httpd:latest

podman exec lab-webapp dnf install -y iputils
podman exec lab-webapp ping -c 3 lab-database

# =========================================
# Cleanup
# =========================================

podman stop $(podman ps -q)
podman rm my-web-server custom-web interactive-centos
podman rm -v web-with-volume
podman container prune
podman image prune
podman volume prune
podman network prune

podman ps -a
podman images
podman volume ls
podman network ls

# =========================================
# Troubleshooting Commands
# =========================================

ss -tulpn | grep :8080
podman run -p 8084:80 httpd:latest
podman logs <container-name>
podman pull quay.io/httpd:latest
podman port <container-name>
sudo firewall-cmd --list-ports
