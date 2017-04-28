## What is needed to port successfully ##

### In terms of skills ###
Good linux knowhow, good shell scripting skills and the more you know or the more information you gathered about the board you are going to use the better. If it has a community forum, consider joining it.  
They are usually an excellent source of information, which is especially useful when you get stuck somewhere.  

### Build environment ###
It is highly recommended to set up your build environment on a Debian Jessie or Ubunutu 16.04 machine.  
A VMware or VirtualBox on Windows is also an option. Then install a virtual machine with one of these two OS.
#### Note ####
In case you use Ubuntu, you may need to remove $forceyes from line 989 of

    /usr/sbin/multistrap

### A corresponding kernel with overlayfs and squashfs filesystems ###
You need the sources of the kernel, preferably the one which is used with a popular image for that particular board.  
For Volumio 2 it has to be a kernel version 3.18 or higher because of the overlayfs filesystem.  
Earlier versions __can__ be used, provided overlayfs has been backported.  
This has been done by the volumio team for a number of board kernels like cubox, odroids and pine64.  

If your kernel does not support overlayfs, consider porting it.    
Refer to __<https://github.com/adilinden/overlayfs-patches/blob/master/README>__, which has patch sets for various older kernel versions.  
Pick the one closest to the target version, you might be lucky and get away without a scratch :)  
However, this is not always the case, so if the patch set does not work and throws errors, you may have to adapt the patch manually (or ask for help).  

### A config file (xxx_defconfig) ###
This you need for compiling the kernel, preferably one as used with one of the popular images.  
It is good practice to copy the defconfig to the boot directory, so you might find one there in one of the board images.  
The config file does not have to have all options enabled, the reason to take it from a popular image (of course with a very similar or the same kernel version) is the fact that it has a lot of normal options people need already enabled, it just saves a lot of time.  
The configuration is subject to optimization later, one could remove all options and drivers which nobody needs on a Volumio 2 image.  
But as long as the drivers are compiled as modules there is no hurry, they won't get loaded anyway when not used.  
When you are going to prepare the Volumio 2 image, we suggest you also copy the used defconfig to the boot folder, so people know which options you used.
If your popular image does not have the config in the boot directory, there is a slight chance you might get hold of it in  the running system, example for a pine64:

    modprobe configs
    cat /proc/config.gz | gunzip > pine64_defconfig

### A corresponding u-boot ###
Pre-compiled, including other related files like bootloader blobs, or the sources of the u-boot version to compile, including the config file to use.

### The partition layout for the boot image ###
Mainly to find out which sectors to put the u-boot and SPL files or other blobs.  

### A UART-Interface ###
It is not a must, but we __highly__ recommend to use a UART-interface with your device.  
It saves a lot of time and frustration being able to see the complete boot process, starting with u-boot displaying its messages.  
Some devices have a proprietary interface, like the uart interface Hardkernel uses for all their devices.  
A very popular device is the __adafruit USB to TTL Serial Cable - Debug / Console Cable for Raspberry Pi__, we also use it.  

![Alt](/docs/05_Porting_Guide/uart-intfc.jpg)

You only need three wires: TX(white), RX(green) and GND(black).
