#!/bin/bash -x

if [ -z ${AWS_DEFAULT_REGION} ]; then
  AWS_DEFAULT_REGION=us-west-1
  echo "Forcing AWS_DEFAULT_REGION to ${AWS_DEFAULT_REGION}"
fi
echo "AWS_REGION is ${AWS_REGION}"

echo "Adding multiverse to sources.list.d as ${LIST}"
LIST=/etc/apt/sources.list.d/amazon.list
cat <<EOF > ${LIST}
deb http://${AWS_DEFAULT_REGION}.ec2.archive.ubuntu.com/ubuntu/ raring multiverse
deb-src http://${AWS_DEFAULT_REGION}.ec2.archive.ubuntu.com/ubuntu/ raring multiverse
deb http://${AWS_DEFAULT_REGION}.ec2.archive.ubuntu.com/ubuntu/ raring-updates multiverse
deb-src http://${AWS_DEFAULT_REGION}.ec2.archive.ubuntu.com/ubuntu/ raring-updates multiverse
deb http://security.ubuntu.com/ubuntu raring-security multiverse
deb-src http://security.ubuntu.com/ubuntu raring-security multiverse
EOF

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
