#!/bin/bash
# Lab 24: File and Directory Permissions
# Environment: CentOS/RHEL Cloud VM
# User: centos (sudo-enabled)
# Shell: Bash 4.2

############################################################
# TASK 1: Create Working Directory and Test Files
############################################################

mkdir ~/permissions_lab
cd ~/permissions_lab
pwd

echo "This is a regular text file" > textfile.txt
echo "#!/bin/bash" > script.sh
echo "echo 'Hello World'" >> script.sh
mkdir testdir

ls -l

############################################################
# TASK 1.2: Numeric (Octal) Permissions
############################################################

chmod 755 script.sh
ls -l script.sh

chmod 600 textfile.txt
ls -l textfile.txt

./script.sh

############################################################
# TASK 1.3: Symbolic Permissions
############################################################

chmod g+x,o+x script.sh
ls -l script.sh

chmod g-w textfile.txt
ls -l textfile.txt

chmod u+rw,g+r,o-rwx textfile.txt
ls -l textfile.txt

############################################################
# TASK 1.4: Directory Permissions
############################################################

echo "Directory content" > testdir/file1.txt
echo "More content" > testdir/file2.txt

chmod -x testdir
ls -l

ls testdir
cd testdir

chmod +x testdir
ls testdir

############################################################
# TASK 2: Ownership Management
############################################################

sudo su -

useradd testuser
passwd testuser

groupadd testgroup
usermod -a -G testgroup testuser

exit

ls -l ~/permissions_lab/

sudo chown testuser ~/permissions_lab/textfile.txt
ls -l ~/permissions_lab/textfile.txt

sudo chown testuser:testgroup ~/permissions_lab/script.sh
ls -l ~/permissions_lab/script.sh

sudo chown -R testuser:testgroup ~/permissions_lab/testdir
ls -l ~/permissions_lab/
ls -l ~/permissions_lab/testdir/

sudo chgrp centos ~/permissions_lab/textfile.txt
ls -l ~/permissions_lab/textfile.txt

############################################################
# TASK 3: ACL Management
############################################################

which setfacl getfacl
sudo yum install acl -y

mount | grep acl

cd ~/permissions_lab
echo "ACL test content" > acltest.txt
ls -l acltest.txt

getfacl acltest.txt

setfacl -m u:testuser:rw acltest.txt
getfacl acltest.txt

ls -l acltest.txt

setfacl -m g:testgroup:r acltest.txt
getfacl acltest.txt

setfacl -m d:u:testuser:rwx testdir
setfacl -m d:g:testgroup:rx testdir
getfacl testdir

echo "Testing default ACL" > testdir/newfile.txt
getfacl testdir/newfile.txt

setfacl -x u:testuser acltest.txt
getfacl acltest.txt

setfacl -b acltest.txt
getfacl acltest.txt
ls -l acltest.txt

setfacl -m u:testuser:rw,g:testgroup:r,o::--- acltest.txt
getfacl acltest.txt

############################################################
# PERMISSION TEST SCRIPT
############################################################

nano permission_test.sh

chmod +x permission_test.sh
./permission_test.sh

############################################################
# END OF LAB 24
############################################################
