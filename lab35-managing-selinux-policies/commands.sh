#!/bin/bash
# Lab 35: Managing SELinux Policies (RHEL 9 / CentOS Stream 9)
# Commands executed (outputs captured separately in output.txt)

# ---------------------------
# Task 1: Check SELinux status
# ---------------------------
sudo whoami
sestatus
getenforce
cat /etc/selinux/config

ls -Z ~/
ps -eZ | head -10
id -Z

# ---------------------------------------------
# Task 2: Install tools + manage SELinux policy
# ---------------------------------------------
sudo dnf install -y policycoreutils-python-utils setools-console

which semanage
semanage --help

# File contexts (fcontext + restorecon)
sudo mkdir -p /opt/testapp
sudo touch /opt/testapp/config.conf
ls -Z /opt/testapp/

sudo semanage fcontext -a -t httpd_config_t "/opt/testapp/config.conf"
sudo restorecon -v /opt/testapp/config.conf
ls -Z /opt/testapp/config.conf

# Port contexts
semanage port -l | grep http
sudo semanage port -a -t http_port_t -p tcp 8080
sudo semanage port -d -p tcp 8080
sudo semanage port -a -t http_port_t -p tcp 8080
semanage port -l | grep 8080

# Booleans
getsebool -a | head -10
getsebool httpd_can_network_connect
sudo setsebool httpd_can_network_connect on
sudo setsebool -P httpd_can_network_connect on
getsebool httpd_can_network_connect

# SELinux user mappings
semanage login -l
semanage user -l

# ---------------------------------------
# Task 3: Troubleshoot denials (audit logs)
# ---------------------------------------
sudo dnf install -y setroubleshoot-server
sudo systemctl status auditd
sudo ausearch -m avc -ts recent

# Create denial scenario (Apache + home-based docroot)
sudo mkdir -p /home/testuser/website
sudo echo "<html><body>Test Page</body></html>" > /home/testuser/website/index.html
echo "<html><body>Test Page</body></html>" | sudo tee /home/testuser/website/index.html >/dev/null
sudo chown -R apache:apache /home/testuser/website

sudo dnf install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd

# (Created via nano) /etc/httpd/conf.d/testsite.conf
sudo systemctl restart httpd

curl http://localhost/

# Analyze denials
sudo ausearch -m avc -ts recent
sudo sealert -a /var/log/audit/audit.log
sudo grep "denied" /var/log/audit/audit.log | tail -5

# Fix: correct content labeling for httpd
ls -Z /home/testuser/website/
sudo semanage fcontext -a -t httpd_sys_content_t "/home/testuser/website(/.*)?"
sudo restorecon -R -v /home/testuser/website/
sudo chcon --reference=/var/www/html /home/testuser/website/index.html
ls -Z /home/testuser/website/

curl http://localhost/

# Additional troubleshooting tools + policy module demo
sudo dnf install -y policycoreutils-gui
sudo grep httpd /var/log/audit/audit.log | audit2allow -M myhttpd
cat myhttpd.te
sudo semodule -i myhttpd.pp

# Policy modules inspection
semodule -l | head -10
semodule -l | grep httpd
sestatus | grep "policy version"

# Monitoring helper script
# (Created via nano) /usr/local/bin/selinux-monitor.sh
sudo chmod +x /usr/local/bin/selinux-monitor.sh
sudo /usr/local/bin/selinux-monitor.sh

# Cron monitoring entry (edited via nano)
sudo nano /etc/crontab
tail -n 5 /etc/crontab

# --------------
# Lab cleanup
# --------------
sudo rm -rf /opt/testapp
sudo rm -rf /home/testuser/website
sudo rm -f /etc/httpd/conf.d/testsite.conf

sudo semanage fcontext -d "/opt/testapp/config.conf"
sudo semanage fcontext -d "/home/testuser/website(/.*)?"
sudo semanage port -d -t http_port_t -p tcp 8080

sudo systemctl restart httpd
