#!/bin/bash
#start.sh for Single-GPU Passthrough for AMD GPU's
#JamesR - 12/11/22

#Helps when reading output while troubleshooting
set -x

#Loads config from KVM
source "/etc/libvirt/hooks/kvm.conf"

#Stops GNOME display manager
systemctl stop gdm

#Unbinds all the VTconsoles and the EFI framebuffer.
echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

#There is sometimes a race condition, this helps a little bit
sleep 8

#Kills and unloads the AMD drivers
modprobe -r amdgpu

#Unbind the GPU
virsh nodedev-detach $VIRSH_GPU_VIDEO
virsh nodedev-detach $VIRSH_GPU_AUDIO

#Loads the vfio drivers
modprobe vfio
modprobe vfio_pci
modprobe vfio_iommu_type1
