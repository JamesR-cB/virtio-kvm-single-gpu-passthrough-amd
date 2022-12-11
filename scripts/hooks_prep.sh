#!/bin/bash
#Helper script that will create all the directories and deploy the hook scripts for you.
#JamesR - 12/11/22

if [ -z "$1" ]
then
    echo "You need to provide the name of your VM for this script to work."
    exit
fi

name_of_your_vm=$1

cd ..
sudo mkdir /etc/libvirt/hooks
sudo mkdir /etc/libvirt/hooks/qemu.d
sudo mkdir /etc/libvirt/hooks/qemu.d/${name_of_your_vm}/
sudo mkdir /etc/libvirt/hooks/qemu.d/${name_of_your_vm}/prepare
sudo mkdir /etc/libvirt/hooks/qemu.d/${name_of_your_vm}/prepare/begin
sudo mkdir /etc/libvirt/hooks/qemu.d/${name_of_your_vm}/release
sudo mkdir /etc/libvirt/hooks/qemu.d/${name_of_your_vm}/release/end

cp hooks/start.sh /etc/libvirt/hooks/qemu.d/${name_of_your_vm}/prepare/begin/start.sh
cp hooks/revert.sh /etc/libvirt/hooks/qemu.d/${name_of_your_vm}/release/end/revert.sh

chmod +x /etc/libvirt/hooks/qemu.d/${name_of_your_vm}/prepare/begin/start.sh
chmod +x /etc/libvirt/hooks/qemu.d/${name_of_your_vm}/release/end/revert.sh

echo "Please double check my output, but the directories should have been corrected and the scripts are in place and marked as executable."
