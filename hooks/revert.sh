#!/bin/bash
#Revert.sh for resuming Linux after your VM powers off when you are doing single-GPU AMD Passthrough
#JamesR - 12/11/22

#Helps with reading output while troubleshooting
set -x

#Loads config from KVM
source "/etc/libvirt/hooks/kvm.conf"

#Unbind the vfio driver
modprobe -r vfio_pci
modprobe -r vfio_iommu_type1
modprobe -r vfio

#Reattaches the GPU to Linux
virsh nodedev-reattach $VIRSH_GPU_VIDEO
virsh nodedev-reattach $VIRSH_GPU_AUDIO

#reattaches the vtconsoles and the EFI framebuffer
echo 1 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind
echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind

#Load the AMD driver
modprobe amdgpu

#Starts GNOME display manager
systemctl start gdm
