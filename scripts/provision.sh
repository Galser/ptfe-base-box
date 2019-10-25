apt-get clean
apt-get update

apt-get upgrade -y

# Update to the latest kernel
# commented out
apt-get install -y linux-generic linux-image-generic linux-server

# Hide Ubuntu splash screen during OS Boot, so you can see if the boot hangs
apt-get remove -y plymouth-theme-ubuntu-text
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT=""/' /etc/default/grub
update-grub

# Add no-password sudo config for vagrant user
echo "%vagrant ALL=NOPASSWD:ALL" > /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant

# Add vagrant to sudo group
usermod -a -G sudo vagrant

# Install vagrant key
mkdir /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub' -O /home/vagrant/.ssh/authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh

# Install NFS for Vagrant
apt-get install -y nfs-common
# Without libdbus virtualbox would not start automatically after compile
apt-get -y install --no-install-recommends libdbus-1-3

# Install Linux headers and compiler toolchain
apt-get -y install build-essential linux-headers-$(uname -r)

# The netboot installs the VirtualBox support (old) so we have to remove it
service virtualbox-ose-guest-utils stop
rmmod vboxguest
apt-get purge -y virtualbox-ose-guest-x11 virtualbox-ose-guest-dkms virtualbox-ose-guest-utils
apt-get install -y dkms

# Install the VirtualBox guest additions
VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
VBOX_ISO=/home/vagrant/VBoxGuestAdditions_$VBOX_VERSION.iso
mount -o loop $VBOX_ISO /mnt
yes|sh /mnt/VBoxLinuxAdditions.run
umount /mnt

#Cleanup VirtualBox
rm $VBOX_ISO

apt-get autoremove -y
apt-get clean

#Add some tools
apt install -y curl wget
# We nede Docker of specific version for air-gapped installs 
#Add docker
#apt-get install -y docker.io==
DOCKER_CE_VER="5:18.09.2~3-0~ubuntu-bionic"
# remove default (if any leftovers)
apt-get remove -y docker docker-engine docker.io containerd runc
# allow to use/add repos over https
apt-get install  -y apt-transport-https  ca-certificates   gnupg-agent  software-properties-common
# add key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# add repo
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
# install the REQUIRED version
apt-get install -y docker-ce=$DOCKER_CE_VER docker-ce-cli=$DOCKER_CE_VER containerd.io


# Enable it and ensure start on boot
systemctl start docker
systemctl enable docker


# Removing leftover leases and persistent rules
echo "cleaning up dhcp leases"
rm /var/lib/dhcp/*

# Zero out the free space to save space in the final image:
echo "Zeroing device to make space..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
