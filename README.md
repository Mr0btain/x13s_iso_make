# x13s_iso_make

Repo of Ubuntu installer modified to run on the Lenovo X13S

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
    Sound - Kernel commits show its coming
    WWAN - Problem with ubuntu i think, working on it
    Bluetooth
    GPU - software rendering for now
    Camera - im sorry but i dont really care about the camera haha
    Graphical boot - right now its very much verbose - low on the list


# UP NEXT:
    Improve after install patch
        Maybe use os-prober
        get .desktop shortcut to be trusted in installer
    Figure out WWAN issue
    Work on Sound
        Kernel work is being done, check steev's sc8280xp-next repo
    

good luck! =D
