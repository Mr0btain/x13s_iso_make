# x13s_iso_make

This uses github LFS for the squashfs file. so you have to clone it with git lfs example:

For Ubuntu:
Make sure you have git-lfs installed. 

sudo apt install git-lfs

then clone said repo:

git lfs clone https://github.com/Mr0btain/x13s_iso_make.git

Quickly add uuid to dtb and pack iso for Lenovo x13s

Made usuing jhohisel's repo: https://github.com/jhohisel/custom-ubuntu-arm64-livecd

start laptop, hit enter to interrupt boot, then press F1 to go to bios menu

note the UUID on the main menu, change the name of the file in /image/isolinux/dtb/ to your
UUID.dtb

EX: f249803d-0d95-54f3-a28f-f26c14a03f3b.dtb

while youre in the bios, disable secure boot and os optimized defaults.
set USB as first boot device, followed by NVME. 

before building iso make sure you have mtools, xorriso, and mkisofs

$ sudo apt install -y mtools xorriso mkisofs

run the bash script make_iso.sh, you do not have to run as root. it will need sudo
for formating the efiboot.img youll be promented to ented pin/pass for sudo. then it will
chown files. if you run entire script as sudo, it will set root as owner.

$ ./make_iso.sh

flash iso to usb flash drive
ubuntu gnomes default app will be fine for flashing

then, laptop time. fire up the laptop with the usb stick in it obviously.

dtbloader should show the dtb being selected, then into grub. then a span of a bunch
of things youll never bother to read but look pretty cool, like pro hacker status

once in the live env, install ubuntu as normal. **note** if youre completely wiping your drive for whatever reason the EFI partition wont format. this is fine, it wont affect anything.
but, after install its probably good to clean up the boot/efi/ of any garbage winblows stuff. it wont affect anything if you dont, but you dont need that kind of negativity taking up
precious bytes.

after install, DONT restart. it wont be bootable yet. copy the files in post_install/ 
to boot/efi/ on your taget drive. your boot/efi should look like this 

EX: "EFI x13s_post_patch fix_grub.sh"  

you can find the efi partition by opening the disks utility clicking on the disk. NOTE: the
UUID of your target drive, where ubuntu is installed. we will need this later. might have to mount efi partition, then click the link where it says its mounted at. in this case if you
open the partition directly, youd place the patch in the root directory of said drive. once
copied, open the grub_fix.sh with a text editor. in the top where it says

nvmeuuid="yourNVME_UUIDhere" 

change it to, you guessed it, your nvme uuid. heres what it should look like:

EX: nvmeuuid=f249803d-0d95-54f3-a28f-f26c14a03f3b

now just open a terminal in the boot/efi directory and type: ./grub_fix.sh if your on jammy, or: sh ./grub_fix.sh if in kinetic. stupid, i know. but it doesnt always work in kinetic without the sh. if NOTE: DOUBLE CHECK the UUID of your dtb file in boot/efi/dtb/3764827347823.dtb. make sure it matches and that it actually copied, the live env for me did mess it up once. and funny enough, its the one i used in the first dtb example. if you need 
to do this again, say grub updates and changes things just boot the live disk up again, and

run ./grub_fix.sh again. 

now you should be good to reboot, and after reboot youll be in grub. you shouldnt see 
dtbloader anymore, ive added the non debug version in the patch. the kernel, i have set to 
quite. but on my laptop, it doesnt seem to matter. yours may be different. when you
build kernel, you can change print log level defaults for quite to say 1. then you
would get like, no output from kernel on boot with quite set. i havent had much luck
building mainline kernels for this, piggybacking off jhohisel's slimmed config and adding
the options for aditional drivers has been my go to. but none working reliably yet.

if you require any more specific boot config stuff, just append it to the grub_fix.sh where
the config gets produced. and anytime you need to recover, youll always have it in efi
partition. or, be ballsy and delete, like a real man.

sometimes, on boot youll be tossed into initramfs cmd line, just reboot and it will boot
normal. not 100% sure why this happens but i suspect adding rootwait to boot config may fix it.

if the battery doesnt show, then you need to:

sudo apt install pd-mapper qmic qrtr rmtfs -y

then

sudo systemctl enable pd-mapper.service

good luck! =D
