# Install Virtualbox Guest Additions
if test -f .vbox_version ; then

  # The netboot installs the VirtualBox support (old) so we have to remove it
  echo "Removing old guest additions"
  if test -f /etc/init.d/virtualbox-ose-guest-utils ; then
    /etc/init.d/virtualbox-ose-guest-utils stop
  fi

  rmmod vboxguest
  aptitude -y purge virtualbox-ose-guest-x11 virtualbox-ose-guest-dkms virtualbox-ose-guest-utils

  # Install dkms for dynamic compiles
  echo "Installing DKMS"
  apt-get install -y dkms

  # If libdbus is not installed, virtualbox will not autostart
  echo "Installing libdbus"
  apt-get -y install --no-install-recommends libdbus-1-3

  # Install the VirtualBox guest additions
  echo "Installing Virtualbox Guest Additions"
  VBOX_ISO=VBoxGuestAdditions.iso
  mount -o loop $VBOX_ISO /mnt
  yes|sh /mnt/VBoxLinuxAdditions.run
  umount /mnt
  rm -f $VBOX_ISO

  # Start the newly build driver
  echo "Starting driver"
  /etc/init.d/vboxadd setup
  /etc/init.d/vboxadd start
fi
