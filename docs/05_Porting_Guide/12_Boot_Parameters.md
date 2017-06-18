
## Boot Parameters #
Boot configuration depends on the u-boot version in use for the particular platform.  
Always look for prebuilt vendor images, they are a good source of the option(s) you have.  

With the u-boot version we use, there are several options to achieve boot configuration with our requirements.
Below is a script we would have used with an armbian based kernel/ u-boot, it is based on a compiled boot.scr (from boot.cmd) and an optional text file to override predefined variables. Very flexible and works with many platforms.  

### boot.scr ###
    setenv volumioenv "/dev/mmcblk0p1"
    setenv fdt_file "rk3288-miqi.dtb"
    setenv ramdisk_addr_r "0x21000000"
    setenv console "ttyS2,115200n8"
    setenv verbosity "1"

    itest.b ${devnum} == 0 && echo "U-boot loaded from SD"
    itest.b ${devnum} == 1 && echo "U-boot loaded from eMMC"

    if load ${devtype} ${devnum}:1 ${ramdisk_addr_r} /boot/volumio-env.txt || load ${devtype} ${devnum}:1 ${ramdisk_addr_r} volumio-env.txt; then
	    env import -t ${ramdisk_addr_r} ${filesize}
    fi

    setenv bootargs "consoleblank=0 scandelay ${volumioenv} rw console=${console} rootfstype=ext4 loglevel=${verbosity} rootwait ${extraargs} "
    ext4load ${devtype} ${devnum}:1 ${fdt_addr_r} /boot/dtb/${fdt_file} || fatload ${devtype} ${devnum}:1 ${fdt_addr_r} dtb/${fdt_file} || ext4load ${devtype} ${devnum}:1 ${fdt_addr_r} dtb/${fdt_file}
    ext4load ${devtype} ${devnum}:1 ${ramdisk_addr_r} /boot/uInitrd || fatload ${devtype} ${devnum}:1 ${ramdisk_addr_r} uInitrd || ext4load ${devtype} ${devnum}:1 ${ramdisk_addr_r} uInitrd
    ext4load ${devtype} ${devnum}:1 ${kernel_addr_r} /boot/zImage || fatload ${devtype} ${devnum}:1 ${kernel_addr_r} zImage || ext4load ${devtype} ${devnum}:1 ${kernel_addr_r} zImage
    bootz ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}

    # Recompile this script with
    # mkimage -C none -A arm -T script -d /boot/boot.cmd /boot/boot.scr
    # or
    # Edit volumio-env.txt to override defined setenv parameters

This would be the corresponding volumio-env.txt file

    verbosity=1
    volumio=imgpart=/dev/mmcblk0p2 imgfile=/volumio_current.sqsh
    console=tty2,ttyS2,115200n8

### extlinux/extlinux.conf ###

As there is no requirement for flexibility and hardly anything we need to configure for Volumio, the extlinux.conf option in the boot partition is all we need.
The file is located in boot/extlinux and has the following content, adapted from one of the Asus prebuilt images:

    label kernel-4.4
        kernel /zImage
        fdt /dtb/rk3288-miniarm.dtb
        initrd /uInitrd
        append  earlyprintk console=tty1 console=ttyS1,115200n8 imgpart=/dev/mmcblk0p2 imgfile=/volumio_current.sqsh
