## Saving the files to the Platform Folder ##

We are now ready to save all he files to the platform-asus folder, where they can be picked up to be used from the volumio tinker board build script.

### Assumptions ###

DESTDIR=$HOME/asus-build/platform-asus/tinkerboard  
KERNELDIR=$HOME/linux-asus  
UBOOTDIR=$HOME/u-boot  

### u-boot ###
Assuming you compiled u-boot from the guideline above, you already saw how the u-boot image landet in the latform folder.
For the kernel we want to do a little more. It is always handy to the last few kernel configurations.
It is good practise, to copy the current kernel config to the boot folder. In the boot folder should only hold the current one.  
Chapter 2 also showed how to save the config to the kernel.
To help identify the con fig file, I like adding the kernel version to the filename, including a timestamp.

    kver=`make kernelrelease`-`date +%Y.%d.%m-%H.%M`
    rm $DESTDIR/boot/config*
    cp .config $DESTDIR/boot/config-${kver}
    cp .config $DESTDIR/config-${kver}

### Kernel ###
Next step is to save the kernel, in this case a zImage, and the dts

    cp arch/arm/boot/zImage $DESTDIR/boot
    cp arch/arm/boot/dts/*.dtb $DESTDIR/boot/dtb

### Modules and firmware ###
For building an image, the only thing missing are the modules and firmware.
Best is to delete the previous lib folder, avoiding the risk to save the ones from an older kernel version

    rm -r $DESTDIR/lib
    make modules_install ARCH=arm INSTALL_MOD_PATH=$DESTDIR
    make firmware_install ARCH=arm INSTALL_FW_PATH=$DESTDIR/lib/firmware

### Patches and other files ###
As we do not want to loose the patches, we save these as well (though we only need these once after cloning the repos.  

    git diff > $DESTDIR/tinkerboard/patches/Volumio-Kernel.patches
