#! /bin/bash

# Get system-UUID.
sysuuid=$(dmidecode -s system-uuid)
nvmeuuid=yourNVME_UUIDhere

printf "Copying dtb to DtbLoaders dtb folder with UUID=${sysuuid}"
cp /usr/lib/linux-image-*/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb $PWD/dtb/${sysuuid}.dtb

# Copy the DtbLoader.efi file over, just in case its been replaced again
# NOTE: This is the NON debug verison, it will not display anything like the installer does.
printf "Copy DtbLoader.efi to fallback bootaa64.efi"
cp $PWD/x13s_post_patch/DtbLoader.efi EFI/Boot/bootaa64.efi

# Copy shell.efi over, because its nice to have.
cp $PWD/x13s_post_patch/Shell.efi $PWD/EFI/Boot/Shell.efi

# Remove grub.cfg in the even it has been replaced, replace with new.
printf "Making new grub.cfg with your nvme uuid=${nvmeuuid}"
rm $PWD/x13s_post_patch/grub.cfg
cat <<EOF > $PWD/x13s_post_patch/grub.cfg

insmod all_video
	load_video
	insmod gzio
	insmod part_gpt
	insmod ext2
	
	search --no-floppy --fs-uuid --set=root ${nvmeuuid}

menuentry "Ubuntu" {
    linux /boot/vmlinuz root=UUID=${nvmeuuid} pd_ignore_unused clk_ignore_unused modprobe.blacklist=msm quite ---
    initrd /boot/initrd.img
}

menuentry "Ubuntu Fallback Kernel" {
    linux linux /boot/vmlinuz.old root=UUID=${nvmeuuid} pd_ignore_unused clk_ignore_unused modprobe.blacklist=msm loglevel=9 ---
    initrd /boot/initrd.img.old
}

menuentry "UEFI Shell" {
    chainloader /tools/Shell.efi
}
EOF

# Fixup the Grub bootloader
printf "Fixing the grubaa64.efi"
(
    grub-mkstandalone \
    --format=arm64-efi \
    --output=EFI/Boot/grubaa64.efi \
    --directory=$PWD/x13s_post_patch/grub-arm64-efi \
    --locales="" \
    --fonts="" \
    "boot/grub/grub.cfg=$PWD/x13s_post_patch/grub.cfg"
)

printf "Copying DTB from kernel"
cp /usr/lib/linux-image-*/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb /dtb/${sysuuid}
