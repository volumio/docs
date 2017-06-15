## Compiling U-Boot ##

### Clone u-boot ###

    git clone git://git.denx.de/u-boot.git u-boot -b master --depth 1

### Patches ###
At the time of writing, there is a correction/ change for u-boot, which has not been committed to the official U-Boot repository yet.
It deals with fixing an eth mac address.
When volumio is configured to use dhcp for eth (which is default), the device should not get a new IP address every time the device is booted.
With this patch, a fixed eth mac address is generated, using device-specific info from an EEPROM.
The patch file is in folder "platform-files", under "patches".
Copy the patch to the root of the u-boot folder and apply it like this:  

        patch -p1 < tinker_set_ethaddr_in_late_init.patch

### Compile ###
There is a u-boot configuration for the Tinkerboard in the master branch, we will compile u-boot using it:

    cd u-boot
    make clean 	(does not do anything here as we just cloned)
    make tinker-rk3288_defconfig
    touch .scmversion	(to get a clean u-boot version number)
    make -j8

#### assumption ####
    DEST=$HOME/platform-asus/tinkerboard

### Create the u-boot.img ###
For a correct boot process, the u-boot spl and u-boot dtb are combined into a single u-boot.bin file, to be used for the Tinkerboard image build script.

    mkimage -n rk3288 -T rksd -d spl/u-boot-spl-dtb.bin ../platform-asus/tinkerboard/u-boot/u-boot.img
    mkdir $DEST/u-boot (in case not yet existing)  
    cat u-boot-dtb.bin >> $DEST/u-boot/u-boot.img

The u-boot image must be copied to the beginning of the device, skip 64 blocks for the location of the loader.
This should be done in the tinkerimage.sh script, to be explained later.

    dd if=platform-asus/tinkerboard/u-boot/u-boot.img of=${LOOP_DEV} seek=64 conv=notrunc
