#!/bin/bash
#Identifies the current IOMMU groupings your Linux system is able to enumerate.
#The output WILL change if you alter hardware or load a patched iommu kernel!
#JamesR - 12/10/22

#Original copy of the below was copied into this script unmodified from the Arch Wiki on 12/10/22. I did not write this.
#https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF

shopt -s nullglob
for g in $(find /sys/kernel/iommu_groups/* -maxdepth 0 -type d | sort -V); do
    echo "IOMMU Group ${g##*/}:"
    for d in $g/devices/*; do
        echo -e "\t$(lspci -nns ${d##*/})"
    done;
done;
