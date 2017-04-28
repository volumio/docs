## Preparing the Build Process ##

### Necessary packages ###
The following packages need to be installed on your build machine, you will need them sooner or later in the build process.

    git squashfs-tools kpartx multistrap qemu-user-static samba debootstrap parted dosfstools qemu binfmt-support lzop chrpath gawk texinfo libsdl1.2-dev whiptail diffstat cpio libssl-dev

### Optional ###

    qemu-utils (only needed if x86 will be built with the machine too )

### Special Requirement for Rockchip on Debian jessie ###

Jessie's u-boot tool 'mkimage' is too old to support a "rksd"-type image, needed for u-boot creation with Rockchip SoC's (see "Compiling U-Boot").  
In case you build for Rockchip, you need to download a newer version, at least __2016.11+dfsg1-4__, and install it over jessie's 2014.10+dfsg1-5:

    wget http://ftp.debian.org/debian/pool/main/u/u-boot/u-boot-tools_2016.11+dfsg1-4_amd64.deb
    dpkg -i u-boot-tools_2016.11+dfsg1-4_amd64.deb
    rm u-boot-tools_2016.11+dfsg1-4_amd64.deb

### Toolchain ###
You need to crosscompile for arm, this means you need the proper toolchain and also take care to use the correct version.  
For older kernels and u-boot we used GCC-4.9.3 (Odroids, arm and aarch64), some require GCC-5, newer ones (like our build example with the Asus Tinkerboard) now require gcc-6.1   
You can download the toolchain from the Linaro organisation: __<http://releases.linaro.org/components/toolchain/gcc-linaro/>__

Create a folder /opt/toolchains and extract the tarball in it (example with gcc-4.9.3)

    sudo mkdir -p /opt/toolchains
    sudo tar xvf gcc-linaro-arm-linux-gnueabihf-4.9-2014.11_linux.tar.xz -C /opt/toolchains/

Add the path to PATH and set environment variables, best to add  them to $HOME/.bashrc, just add the following lines:

    export ARCH=arm
    export CROSS_COMPILE=arm-linux-gnueabihf-
    export PATH=/opt/toolchains/gcc-linaro-4.9-2014.11-x86_64_arm-linux-gnueabihf/bin/:$PATH

You can apply the change by logging out and in again or evaluate $HOME/.bashrc with source command.

    source ~/.bashrc

Check if the toolchain works properly by checking its version, if you can find gcc version string at the end of the output, you’re OK.

    arm-linux-gnueabihf-gcc -v
    Using built-in specs
    …
    …
    …
    …
    gcc version 4.9.3 20141031 (prerelease) (Linaro GCC 2014.11)


 
