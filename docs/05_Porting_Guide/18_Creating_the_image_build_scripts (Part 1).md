## Creating the Image Build Script (Part 1)
### Before we start
I decided to use odroidc1image.sh as a template and copied it to __tinkerimage.sh__  
This chapter will describe which parts need to be adjusted and for what reason.  
For the complete template script see __<http://github.com/volumio/Build/scripts/odroidc1image.sh>__  
The resulting tinkerimage.sh can be found [__here__](http://github.com/volumio/Build/scripts/tinkerimage.sh)  
The parts of the C1 template which are not mentioned here are considered generic and unlikely candidates for changes.
### Creating the image file ###
This part is self-explanatory, the file needs the name of the new image.

    IMG_FILE="Volumio${VERSION}-${BUILDDATE}-odroidc1.img"
becomes

    IMG_FILE="Volumio${VERSION}-${BUILDDATE}-tinkerboard.img"

### Partitioning ###
The size of the file is the same for most devices (currently 2.8GB), it will get three partitions   
- a boot partition (fat32) of approx. 60-64MB
- an image partition (ext4) of approx. 2.3GB
- a data partition (ext4) with the rest (which will get resized on first boot to the complete size of the card the image was flashed to)

The boot partition's offset is the first one from the device-specific adaption and needs to be chosen carefully.
It depends on the size of the bootloader(s).  
For the C1 and Tinkerboard the bootloaders fit into the first block, so the partitioning details remain unchanged.

### Preparing for the tinkerboard rockchip kernel/ platform files ###
This part is also self-explanatory, we only need to change the names of the platform repo and tar file.  
We use the name __platform-asus__ and __tinkerboard.tar.xz__ from the kernel build process.

    if [ -d platform-asus ]
    then
    	echo "Platform folder already exists - keeping it"
        # if you really want to re-clone from the repo, then delete the platform-asus folder
        # that will refresh all the asus platforms, see below
    else
    	echo "Clone asus files from repo"
    	git clone https://github.com/volumio/platform-asus.git platform-asus
    	echo "Unpack the Tinkerboard platform files"
    	cd platform-asus
    	tar xfJ tinkerboard.tar.xz
    	cd ..
    fi

This won't work yet, as we have not pushed the platform files to the volumio repo.  
To be able to use the script anyway, go to the root folder from your build repo copy and type

    mkdir platform-asus
    cd platform-asus
    cp $DESTDIR/tinkerboard.tar.xz .    (where $DESTDIR is the one you used in Chapter "Saving Files to the Platform folder")
    tar xvfJ tinkerboard.tar.xz

### Copying the bootloaders ###
This is the second device-specific adaption of the script, together with the boot partition offset, this us usually the most critical part of customizing a template. This part, when not done properly, will render the image unbootable.
#### C1 version ####
    echo "Copying the bootloader"
    dd if=platform-odroid/odroidc1/uboot/bl1.bin.hardkernel of=${LOOP_DEV} bs=1 count=442
    dd if=platform-odroid/odroidc1/uboot/bl1.bin.hardkernel of=${LOOP_DEV} bs=512 skip=1 seek=1
    dd if=platform-odroid/odroidc1/uboot/u-boot.bin of=${LOOP_DEV} seek=64
    sync

#### Tinkerboard ####
From compiling u-boot, we already know, that there is an image (only one) we need to copy to a certain position at the beginning of the image, so the C1 part gets replaced by

    echo "Copying the bootloader"
    dd if=platform-asus/tinkerboard/u-boot/u-boot.img of=${LOOP_DEV} seek=64 conv=notrunc
    sync
As said, this is device-specific and not always that simple, the following is an example of the Odroid XU4

    echo "Copying the bootloader and trustzone software"
    dd iflag=dsync oflag=dsync if=platform-odroid/odroidxu4/uboot/bl1.bin.hardkernel of=${LOOP_DEV} seek=1
    dd iflag=dsync oflag=dsync if=platform-odroid/odroidxu4/uboot/bl2.bin.hardkernel of=${LOOP_DEV} seek=31
    dd iflag=dsync oflag=dsync if=platform-odroid/odroidxu4/uboot/u-boot.bin.hardkernel of=${LOOP_DEV} seek=63
    dd iflag=dsync oflag=dsync if=platform-odroid/odroidxu4/uboot/tzsw.bin.hardkernel of=${LOOP_DEV} seek=719
    echo "Erasing u-boot env"
    dd iflag=dsync oflag=dsync if=/dev/zero of=${LOOP_DEV} seek=1231 count=32 bs=512
    sync
### Copying system files, preparing for board configuration ###
This part is also self-explanatory, it deals with the rootfs, kernel image, dtb, boot configuration, modules and firmware.
Just ensure the files are copied to the right locations and it fits the boot configuration you created.
### Starting chroot ###
Again, the part is more or less generic and easy to adapt (2 x script name and 1 x boardname)

    chroot /mnt/volumio/rootfs /bin/bash -x <<'EOF'
    su -
    /tinkerconfig.sh
    EOF

    #cleanup
    rm /mnt/volumio/rootfs/root/init /mnt/volumio/rootfs/tinkerconfig.sh

    echo "Unmounting Temp devices"
    umount -l /mnt/volumio/rootfs/dev
    umount -l /mnt/volumio/rootfs/proc
    umount -l /mnt/volumio/rootfs/sys

    echo "==> Tinkerboard device installed"
