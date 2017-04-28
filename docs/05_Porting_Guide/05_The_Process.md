## The Process ##

When Volumio was ported to odroid c1, c2, xu4, cubox-i and pine64, we did things more or less in the same order, let's do this for the Tinkerboard too:
  * Make a platform home folder
  * Get u-boot and related info (defconfig, offsets for placing the u-boot on disk)
  * Get the kernel sources and corresponding config file
  * Compile u-boot and assemble u-boot.bin
  * Compile the kernel, this should give you the kernel (zImage or uImage), the binary device tree (dtb), modules and firmware.

You do not need to set all the kernel options right yet.  
At this stage in the process it is more important that the first resulting image will boot.  
All other options can be added after the basics have been done.  
Make sure that you have at least __overlayfs__ (File Systems) and __squashfs__ (Miscellaneous Filesystems ) enabled as modules and also the kernel has __support for initramfs__.

There is more information on how u-boot must be built in __<https://github.com/rockchip-linux/build/blob/debian/mk-uboot.sh>__
