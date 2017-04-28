## Creating a complete Script for compiling U-Boot and Kernel ##

    #!/bin/sh
    KERNELDIR=$HOME/sources/linux-rockchip/miqi/release-4.4
    UBOOTDIR=$HOME/u-boot
    DEST=/media/nas/asus/tinkerboard
    TARDIR=/media/nas/asus

    echo "Compiling u-boot..."
    cd $UBOOTDIR
    touch .scmversion
    make clean
    make tinker-rk3288_defconfig
    make -j8

    echo "Create u-boot image..."
    mkimage -n rk3288 -T rksd -d spl/u-boot-spl-dtb.bin $DEST/u-boot/u-boot.img
    cat u-boot-dtb.bin >> $DEST/u-boot/u-boot.img

    cd $KERNELDIR
    echo "Cleaning kernel folder..."
    touch .scmversion
    make clean

    echo "Configuring options..."
    make linux-rockchip-tinker_defconfig
    make menuconfig
    cp .config.old arch/arm/configs/linux-rockchip-tinker_defconfig.old
    cp .config arch/arm/configs/linux-rockchip-tinker_defconfig

    echo "Compiling the kernel..."
    make -j12

    echo "Saving configuration..."
    kver=`make kernelrelease`-`date +%Y.%d.%m-%H.%M`
    rm $DEST/boot/config*
    cp .config $DEST/boot/config-${kver}
    cp .config $DEST/config-${kver}

    echo "Saving kernel and dtb's..."
    cp arch/arm/boot/zImage $DEST/boot
    cp arch/arm/boot/dts/\*.dtb $DEST/boot/dtb

    echo "Saving modules and firmware..."
    rm -r $DEST/lib
    make modules_install ARCH=arm INSTALL_MOD_PATH=$DEST
    make firmware_install ARCH=arm INSTALL_FW_PATH=$DEST/lib/firmware

    echo "Backup platform files..."
    cd $TARDIR
    tar cfvJ tinkerboard.tar.xz ./tinkerboard
    echo "Creating platform files completed"
