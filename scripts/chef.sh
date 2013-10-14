#!/bin/bash -x

# Use the Omnibus Opscode Chef installer to install chef
# This should make it easier to have multiple ruby versions installed,
# for example because our software is using jruby.

CHECKSUM=fcbdd1568b303b3d6479105b99625d8f5da306b2f4b40d88646090ed24644598
URL=https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/13.04/x86_64/chef_11.6.0-1.ubuntu.13.04_amd64.deb

# write out a checksum file, download the installer, ensure the file
# validates, and finally install the package from the file.
echo "creating checksum file" && \
echo "$CHECKSUM /tmp/chef.deb" > /tmp/chef.checksum && \
echo "downloading package from opscode" && \
curl -L --silent --show-error ${URL} > /tmp/chef.deb && \
echo "checking checksums" && \
sha256sum --check /tmp/chef.checksum && \
echo "installing package" && \
dpkg -i /tmp/chef.deb && \
echo "installed omnibus chef"
