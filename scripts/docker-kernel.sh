#!/bin/bash -x

# install the kernel-extra with AUFS support
apt-get update
apt-get install -y linux-image-extra-`uname -r`
apt-get upgrade -y

# reboot
# skip due to https://github.com/mitchellh/packer/issues/520
#echo "Rebooting the machine..."
#reboot
#sleep 60
