#!/bin/bash -x

echo "AWS_REGION is ${AWS_REGION}"
echo "Adding multiverse to sources.list.d"

LIST=/etc/apt/sources.list.d/amazon.list

echo deb http://${AWS_REGION}.ec2.archive.ubuntu.com/ubuntu/ raring multiverse > ${LIST}
echo deb-src http://${AWS_REGION}.ec2.archive.ubuntu.com/ubuntu/ raring multiverse >> ${LIST}
echo deb http://${AWS_REGION}.ec2.archive.ubuntu.com/ubuntu/ raring-updates multiverse >> ${LIST}
echo deb-src http://${AWS_REGION}.ec2.archive.ubuntu.com/ubuntu/ raring-updates multiverse >> ${LIST}
echo deb http://security.ubuntu.com/ubuntu raring-security multiverse >> ${LIST}
echo deb-src http://security.ubuntu.com/ubuntu raring-security multiverse >> ${LIST}


# Update your sources
echo "Updating sources"
apt-get update
apt-get upgrade -y

# Install amazon tools
echo "Installing amazon old tools"
apt-get install -y ec2-api-tools ec2-ami-tools

echo "Installing new amazon tools"
apt-get install -y python-pip
pip install awscli
