#!/bin/bash
#Bootstrapper for all the prerequisites for libvirt and the surrounding frameworks.
#JamesR - 12/10/22

clear #because pretty

echo "We are going to do a system upgrade. This will fetch the current list of updated packages, then apply them."
echo "It is your responsibility to make sure you are not installing malicious software or installing broken packages,"
echo "or even doing a kernel upgrade to a broken or not-supported kernel."
echo
read -p "If you are ready to proceed, please press enter. Please note you must have sudo access for this to work."

echo
echo
echo
echo
apt update -y && apt upgrade -y
apt install qemu-kvm libvirt-daemon-system ovmf virt-manager dnsmasq-base -y
systemctl enable libvirtd.service virtlogd.socket && systemctl start libvirtd.service virtlogd.socket
echo
echo
echo
echo
echo "We have installed all the required software. We are now attempting to auotstart the services"
echo "with each boot, and manually start them for this boot."
echo "This script will auto continue in just a moment..."
sleep 7
echo
echo
echo
echo
virsh net-autostart default
virsh net-start default
echo
echo
echo
echo
echo "Okay! Please triple-check all of the output from this script, so you can confirm everything executed!"
echo "If there are any issues, please read the detailed error output from each command and resolve all issues."
echo
echo
exit


