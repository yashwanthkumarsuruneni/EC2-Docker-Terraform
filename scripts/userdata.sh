#!/bin/sh

###################################
# Installing Docker Daemon
####################################

echo "===========[Initializing the Node]============="
yum update -y
echo "===========[Installing docker Daemon]============="
amazon-linux-extras install docker
service docker start
usermod -a -G docker ec2-user
chkconfig docker on


