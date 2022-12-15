# x13s_iso_make

Repo of Ubuntu installer modified to run on the Lenovo X13S

Sorry been sick and busy at work, so getting behind!

Premade ISOs and project files are being moved to google drive. Github is a little hard to deal with large files and such
anyone can edit and add coments and whatever need be to the drive folder. Make improvments, add other distros and such.
As of now i only have kernel 603 iso i believe. will be adding others. I will try and update this repo as i go but as of rn 
its only 6.0.7?

Google Drive: https://drive.google.com/drive/folders/1wp1-X318MCI48xCAffJtyhDRvANkAE4q?usp=sharing

Iso made with Jhohisels script, albiet ive modified it for my use case.
    https://github.com/jhohisel/custom-ubuntu-arm64-livecd

Flash iso, install, Run patch *CHECK HOW_TO.TXT*

# Current Kernel: 6.0.7
    https://github.com/steev/linux/tree/lenovo-x13s-6.0.7

# What works:
    battery
    wifi
    touchscreen - included service to fix binding on startup
    USB works great
    Multitouch
    EFI boot manager - you can now use efibootmgr

# Not working
    Sound - Kernel commits show its coming, needs someting with ALSA i think?
    WWAN - Problem with ubuntu i think, working on it.
    Bluetooth - None in sight
    GPU - software rendering for now, something going on where gpu just nopes out.
    Camera - im sorry but i dont really care about the camera, so probably not happening anytime soon
    Graphical boot - right now its very much verbose - low on the list


# UP NEXT:
    Improve after install patch
        Maybe use os-prober
        get .desktop shortcut to be trusted in installer
    Figure out WWAN issue
    Work on Sound
        Kernel work is being done, check steev's repos. this guy is the man for real.
    

good luck! =D
