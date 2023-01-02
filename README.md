# x13s_iso_make

Repo of Ubuntu installer modified to run on the Lenovo X13S

Premade ISOs and project files are being moved to google drive. Github is a little hard to deal with large files and such
anyone can edit and add coments and whatever need be to the drive folder. Uploading 6.2.0-rc1 iso's right now, with Lunar Kenetic and Jammy.
not sure which runs it better. but 6.2 def has better wifi

ive been working mostly on fixing grub and making it automagic. i am not an expert so it takes time and a whole lot of google lol
link to the grub-x13s project
https://github.com/Mr0btain/grub-x13s.git

Google Drive: https://drive.google.com/drive/folders/1wp1-X318MCI48xCAffJtyhDRvANkAE4q?usp=sharing

Iso made with Jhohisels script, albiet ive modified it for my use case.
    https://github.com/jhohisel/custom-ubuntu-arm64-livecd

Flash iso, install, Run patch *CHECK HOW_TO.TXT*

# Current Kernel: 6.2.0-rc1
    https://github.com/jhovold/linux/tree/wip/sc8280xp-v6.2-rc1

# What works:
    battery
    wifi
    touchscreen - included service to fix binding on startup
    USB works great
    Multitouch
    EFI boot manager - you can now use efibootmgr

# Not working
    Sound - No new updates yet, havent had time to poke with it?
    WWAN - Problem with ubuntu i think, working on it. (It now shows up at least, so some progress)
    Bluetooth - None in sight
    GPU - software rendering for now, something going on where gpu just nopes out.
    Camera - im sorry but i dont really care about the camera, nbody does lol so probably not happening anytime soon
    Graphical boot - right now its very much verbose - low on the list but id like to get splash screens working


# UP NEXT:
    Improve grub
        DONE Maybe use os-prober DONE
        get grub-x13s to run auto on installer
    Figure out WWAN issue
    Work on Sound
        little low on the list people are wrking on it. seems like only time will tell
    

good luck! =D
