
## Boot Parameters #
With the u-boot we use, there are several options to achieve booting with our requirements.  
We choose to combine a pre-compiled boot.scr with a volumio-env.txt file for overriding boot parameters like Loglevel (verbosity) or anything else predefined.   

__WIP, to be verified and adapted, we are not using symbolic links, so we can simplify and revert to vfat boot partition with the final version!!!!__


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

This is the corresponding volumio-env.txt file

    verbosity=1
    volumio=imgpart=/dev/mmcblk0p2 imgfile=/volumio_current.sqsh
    console=tty2,ttyS2,115200n8
