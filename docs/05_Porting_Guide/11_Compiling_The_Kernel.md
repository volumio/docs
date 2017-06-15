## Compiling the Kernel ##

First we will rename the kernel config to something more logical.  
This is normally not necessary, but in this case we started when the original miniarm-rk3288 was not renamed to Tinker Board yet.

    cd linux-asus/arch/arm/configs
    cp miniarm-rk3288_defconfig tinker-rockchip_defconfig

We will use this renamed default kernel config

Let us build the kernel step by step.
Of course 'make clean' does nothing on first compile, as there is nothing to clean.
Otherwise it is a good idea to start with this when options are going to be changed.
After that we select the kernel config tu use and in this case we also start kernel configuration.

    cd $HOME/linux-asus
    make clean
    make tinker-rockchip_defconfig
    make menuconfig

At this stage ensure all minimum options from the previous chapter have been selected.
To get a bootable, first volumio image, we need at least overlayfs, squashfs and nls437 as a module.  
Then save and exit menuconfig.

When you want to keep the changes permanent:  

    cp .config arch/arm/configs/my_tinker-default_defconfig

Or easier if you keep the same name:  

    make savedefconfig

Continue compiling the kernel

    make -jx                    (For x take 1.5 times the number of cpus you have available)

This does all the work defined in the makefile, including dts compilation
