## Creating a complete Script for compiling U-Boot and Kernel ##


    #!/bin/sh
    DESTDIR=$HOME/asus-build/platform-asus/tinkerboard  
    KERNELDIR=$HOME/linux-asus  
    UBOOTDIR=$HOME/u-boot  
    TARDIR=/media/nas/asus

    echo "Compiling u-boot..."
    cd $UBOOTDIR
    touch .scmversion
    make clean
    make tinker-rk3288_defconfig
    make -j8

    echo "Create u-boot image..."
    mkimage -n rk3288 -T rksd -d spl/u-boot-spl-dtb.bin $DESTDIR/u-boot/u-boot.img
    cat u-boot-dtb.bin >> $DESTDIR/u-boot/u-boot.img

    cd $KERNELDIR
    echo "Cleaning kernel folder..."
    touch .scmversion
    make clean

    echo "Configuring options..."
    make tinker-rockchip_defconfig
    make menuconfig
    cp .config.old arch/arm/configs/tinker-rockchip_defconfig.old
    cp .config arch/arm/configs/tinker-rockchip_defconfig

    echo "Compiling the kernel..."
    make -j12

    echo "Saving configuration..."
    kver=`make kernelrelease`-`date +%Y.%d.%m-%H.%M`
    rm $DESTDIR/boot/config*
    cp .config $DESTDIR/boot/config-${kver}
    cp .config $DESTDIR/config-${kver}

    echo "Saving kernel and dtb's..."
    cp arch/arm/boot/zImage $DESTDIR/boot
    cp arch/arm/boot/dts/*.dtb $DESTDIR/boot/dtb

    echo "Saving modules and firmware..."
    rm -r $DESTDIR/lib
    make modules_install ARCH=arm INSTALL_MOD_PATH=$DESTDIR
    make firmware_install ARCH=arm INSTALL_FW_PATH=$DESTDIR/lib/firmware

    echo "Saving Volumio kernel patches"
    git diff > $DESTDIR/tinkerboard/patches/Volumio-Kernel.patches

    echo "Backup platform files..."
    cd $TARDIR
    tar cfvJ tinkerboard.tar.xz ./tinkerboard
    echo "Creating platform files completed"
