#! bin/bash
set -x

# create iso image
(
    cd $PWD/image &&
    xorriso \
        -as mkisofs \
        -iso-level 3 \
        -full-iso9660-filenames \
        -volid "UBUNTU_CUSTOM" \
        -output "../ubuntu-jammy-x13s.iso" \
        -eltorito-alt-boot \
            -e EFI/efiboot.img \
            -no-emul-boot \
        -append_partition 2 0xef isolinux/efiboot.img \
        -m "isolinux/efiboot.img" \
        -graft-points \
            "/EFI/efiboot.img=isolinux/efiboot.img" \
            "."
)

