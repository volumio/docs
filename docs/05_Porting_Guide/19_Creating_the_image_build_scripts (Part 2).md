## Creating the Image Build Script (Part 2)
For the config script we use the corresponding __odroidc1config.sh__ as a template.
This chapter will describe which parts need to be adjusted and for what reason.  
For the complete template script see __<http://github.com/volumio/Build/scripts/odroidc1config.sh>__  
The resulting tinkerimage.sh can be found [__here__](http://github.com/volumio/Build/scripts/tinkerconfig.sh)  
The parts of the C1 template which are not mentioned here are considered generic and unlikely candidates for changes.
### Creating fstab
Just change the description in line 1.
This part is standard in most implementations we encountered as most devices boot from mmcblk0, independent of SD or eMMC.
That said, this may call for a future change.  
Newer devices using mainline u-boot and offering boot from emmc and sd are now using different devices.  
This may require the UUID for locating the correct boot device as we do not want to produce separate images for booting from SD or eMMC.  
An example implementation "by_UUID" you will find in the x86 build scripts.
### Adding default sound modules ###
Tinkerboard does not (yet) support i2s devices, so no need to load sound modules.
This may chnage in future releases.
### init script ###
Tinkerboard is still headless, C1 uses a script to initialise the framebuffer at an early stage (C1-init.sh).
In case Tinkerboard needs this, add it to the tinker init script, which was implemented like this:

    echo "#!/bin/sh
    echo 2 > /proc/irq/45/smp_affinity
    " > /usr/local/bin/tinker-init.sh
    chmod +x /usr/local/bin/tinker-init.sh

    echo "#!/bin/sh -e
    /usr/local/bin/tinker-init.sh
    exit 0" > /etc/rc.local
Currently, the init script changes the usb interrupt CPU affinity (from CPU0 to CPU1).  
This was done to avoid possible crackling and dropouts on usb audio.
The script runs when rc.local is called at boot time.  
### Additional packages ###
lirc is installed, but no specific configuration for a remote is present yet.
It defaults to a small remote Hardkernel offers for the C1/C2.
As no framebuffer initialisation is done, package "fbset" is not needed and removed.
