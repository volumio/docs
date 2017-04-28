## Compiling U-Boot ##

### Clone u-boot ###

    git clone git://git.denx.de/u-boot.git u-boot -b master --depth 1

There is a u-boot configuration for the Tinkerboard in the master branch, we will compile u-boot using it:

### Compile ###
    cd u-boot
    make clean 	(does not do anything here as we just cloned)
    make tinker-rk3288_defconfig
    touch .scmversion	(to get a clean u-boot version number)
    make -j8

### Create the u-boot.img ###
For a correct boot process, the u-boot spl and u-boot dtb are combined into a single u-boot.bin file, to be used for the Tinkerboard image build script.

    mkimage -n rk3288 -T rksd -d spl/u-boot-spl-dtb.bin ../platform-asus/tinkerboard/u-boot/u-boot.img
    cat u-boot-dtb.bin >> ../platform-asus/tinkerboard/u-boot/u-boot.img

The u-boot image must be copied to the beginning of the device, skip 64 blocks for the location of the loader.
This should be done in the tinkerimage.sh script, to be explained later.

    dd if=platform-asus/tinkerboard/u-boot/u-boot.img of=${LOOP_DEV} seek=64 conv=notrunc
