#!/bin/bash
# Lab 27: Configuring and Securing SSH (OpenSSH)
# Notes:
# - Commands include both Server (VM1) and Client (VM2) sections.
# - Run manually step-by-step where required (SSH prompts, password prompts, editors).

set -e

echo "==================================================="
echo "Lab 27: Configuring and Securing SSH (OpenSSH)"
echo "==================================================="

# ----------------------------
# VM1 (SERVER) - Verify SSH installed + running
# ----------------------------
echo "[VM1] Verify OpenSSH server package"
rpm -qa | grep openssh-server || true

echo "[VM1] Check sshd service status"
sudo systemctl status sshd --no-pager || true

echo "[VM1] Ensure OpenSSH server package is installed"
sudo yum install -y openssh-server

echo "[VM1] Start + enable sshd"
sudo systemctl start sshd
sudo systemctl enable sshd

echo "[VM1] Backup sshd_config"
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup

# Edit file interactively (nano/vim)
echo "[VM1] Edit SSH config (interactive)"
echo "Run manually: sudo nano /etc/ssh/sshd_config"

# Verify key lines after editing
echo "[VM1] Verify key settings in sshd_config"
sudo egrep -n '^(Port|PermitRootLogin|PubkeyAuthentication|PasswordAuthentication|PermitEmptyPasswords|MaxAuthTries|ClientAliveInterval|ClientAliveCountMax)\b' /etc/ssh/sshd_config || true

echo "[VM1] Test sshd config syntax"
sudo sshd -t

echo "[VM1] Restart sshd"
sudo systemctl restart sshd

# ----------------------------
# VM1 (SERVER) - Firewall rules
# ----------------------------
echo "[VM1] Check firewalld state"
sudo firewall-cmd --state

echo "[VM1] Allow SSH service"
sudo firewall-cmd --permanent --add-service=ssh

echo "[VM1] Allow port 22/tcp (demo even if service is already allowed)"
sudo firewall-cmd --permanent --add-port=22/tcp

echo "[VM1] Reload firewall"
sudo firewall-cmd --reload

echo "[VM1] List allowed services"
sudo firewall-cmd --list-services

# ----------------------------
# VM1 (SERVER) - Create test user
# ----------------------------
echo "[VM1] Create SSH test user"
sudo useradd testuser || true
sudo passwd testuser

# ----------------------------
# VM1 (SERVER) - Local SSH test (may require password)
# ----------------------------
echo "[VM1] Local SSH test to localhost (manual - interactive)"
echo "Run manually: ssh testuser@localhost"
echo "Then inside session: whoami; hostname; exit"

# ----------------------------
# VM1 (SERVER) - Get server IP
# ----------------------------
echo "[VM1] Show IP address info"
ip addr show

echo "---------------------------------------------------"
echo "IMPORTANT: Note the server IP from eth0 (example: 172.31.18.204)"
echo "---------------------------------------------------"

# ----------------------------
# VM2 (CLIENT) - Remote SSH test (manual)
# ----------------------------
echo "[VM2] Remote SSH test to server (manual - interactive)"
echo "Run manually on VM2: ssh testuser@<SERVER_IP>"
echo "Verbose check: ssh -v testuser@<SERVER_IP>"

# ----------------------------
# VM1 (SERVER) - Monitor SSH connections/logs
# ----------------------------
echo "[VM1] Check sshd listening on port 22"
sudo ss -tuln | grep :22 || true

echo "[VM1] Follow sshd logs (manual - stop with Ctrl+C)"
echo "Run manually: sudo journalctl -u sshd -f"

echo "[VM1] Follow auth log (manual - stop with Ctrl+C)"
echo "Run manually: sudo tail -f /var/log/secure"

# ----------------------------
# VM2 (CLIENT) - Generate SSH key pair
# ----------------------------
echo "[VM2] Generate SSH key pair (manual - interactive prompts)"
echo "Run manually on VM2: ssh-keygen -t rsa -b 4096 -C \"your_email@example.com\""
echo "Then: ls -la ~/.ssh/ && cat ~/.ssh/id_rsa.pub"

# ----------------------------
# VM2 (CLIENT) - Copy key to server
# ----------------------------
echo "[VM2] Copy public key to server using ssh-copy-id (manual - interactive)"
echo "Run manually on VM2: ssh-copy-id testuser@<SERVER_IP>"

echo "[VM2] Fix permissions on server authorized_keys (run from VM2)"
echo "Run manually on VM2:"
echo "ssh testuser@<SERVER_IP> \"chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys\""

# ----------------------------
# VM2 (CLIENT) - Test key-based auth
# ----------------------------
echo "[VM2] Test SSH key-based login (manual)"
echo "Run manually on VM2: ssh testuser@<SERVER_IP>"

# ----------------------------
# VM1 (SERVER) - Verify Accepted publickey in logs
# ----------------------------
echo "[VM1] Verify key-based logins in sshd journal"
sudo journalctl -u sshd | grep "Accepted publickey" | tail -3 || true

# ----------------------------
# VM1 (SERVER) - Disable password auth (after confirming key auth works)
# ----------------------------
echo "[VM1] Disable password authentication (interactive edit required)"
echo "Run manually: sudo nano /etc/ssh/sshd_config"
echo "Set: PasswordAuthentication no"

echo "[VM1] Validate + restart sshd after disabling passwords"
echo "Run manually:"
echo "sudo sshd -t && sudo systemctl restart sshd"

# Confirm password auth is blocked (from VM2)
echo "[VM2] Confirm password auth fails (manual)"
echo "Run manually on VM2:"
echo "ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no testuser@<SERVER_IP>"

# ----------------------------
# VM1 (SERVER) - Advanced hardening (interactive edit)
# ----------------------------
echo "[VM1] Apply additional hardening (interactive edit required)"
echo "Run manually: sudo nano /etc/ssh/sshd_config"
echo "Add/ensure:"
echo "Protocol 2"
echo "AllowUsers testuser"
echo "X11Forwarding no"
echo "AllowAgentForwarding no"
echo "AllowTcpForwarding no"
echo "Ciphers aes256-ctr,aes192-ctr,aes128-ctr"
echo "MACs hmac-sha2-256,hmac-sha2-512"
echo "LoginGraceTime 30"

echo "[VM1] Verify hardening lines"
sudo egrep -n '^(Protocol|AllowUsers|X11Forwarding|AllowAgentForwarding|AllowTcpForwarding|Ciphers|MACs|LoginGraceTime)\b' /etc/ssh/sshd_config || true

echo "[VM1] Restart sshd after hardening"
sudo systemctl restart sshd

# Confirm SSH still works (from VM2)
echo "[VM2] Confirm SSH works for allowed user (manual)"
echo "Run manually on VM2:"
echo "ssh testuser@<SERVER_IP> \"whoami && hostname\""

# ----------------------------
# Optional SELinux restorecon (only if needed)
# ----------------------------
echo "[VM1] Optional: restore SELinux contexts (only if SELinux enabled + needed)"
echo "Run manually: sudo restorecon -R /home/testuser/.ssh/"
