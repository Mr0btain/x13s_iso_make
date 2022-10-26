#! /bin/bash
set -x

# create efi system partition
(
    cd $PWD/image/isolinux && \
    dd if=/dev/zero of=efiboot.img bs=1M count=10 && \
    sudo mkfs.vfat efiboot.img && \
    LC_CTYPE=C mmd -i efiboot.img dtb efi efi/boot && \
    LC_CTYPE=C mcopy -i efiboot.img ./dtb/* ::dtb/ && \
    LC_CTYPE=C mcopy -i efiboot.img ./grubaa64.efi ::efi/boot/ && \
    LC_CTYPE=C mcopy -i efiboot.img ./bootaa64.efi ::efi/boot/
)

# create md5sum
(
    cd $PWD/image &&
    /bin/bash -c "(find . -type f -print0 | xargs -0 md5sum | grep -v -e 'md5sum.txt' -e 'efiboot.img' > md5sum.txt)"
)

# Make files owned by user, so xorriso can get access
chown -R $USER:$USER $PWD/image

# create iso image
(
    cd $PWD/image &&
    xorriso \
        -as mkisofs \
        -iso-level 3 \
        -full-iso9660-filenames \
        -volid "UBUNTU_X13S" \
        -output "../ubuntu-jammy-arm64-custom.iso" \
        -eltorito-alt-boot \
            -e EFI/efiboot.img \
            -no-emul-boot \
        -append_partition 2 0xef isolinux/efiboot.img \
        -m "isolinux/efiboot.img" \
        -graft-points \
            "/EFI/efiboot.img=isolinux/efiboot.img" \
            "."
)

printf "Done"

exit
