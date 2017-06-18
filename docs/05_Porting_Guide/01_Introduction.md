## Introduction ##

### Note ###
This is work in progress and will be updated the coming couple of days
Last change: 18.06.2017/ gkkpch

### What does it cover ###
This is a __guideline__ for porting Volumio to new ARM platforms, not a step-by-step instruction or cookbook.
It covers most of the steps needed:
  * Creating/ compiling u-boot to make the new board image bootable
  * Compiling a suitable kernel, the device tree, modules and firmware
  * Creating a platform repo to support the build process
  * Creating the board-specific image.sh script
  * Creating the board-specific config.sh script

As arm devices can differ regarding kernel version, supported u-boot version, boot parameters, and partition layout, board-specific properties have to be taken into account.  
Example: some board images use uEnv.txt or boot.ini to describe the boot parameters, others use a compiled boot.scr.  
Or, as we will see in our build example, a combination of a compiled boot.scr and a text file to override certain defined parameters.  
As for u-boot, some can be compiled directly from __<http://git.denx.de>__ (mostly newer boards with a mainline kernel), some need additional blobs.  
For some boards, blobs, SPL and u-boot are written to a device in separate steps, for others an image from u-boot and spl binary must be prepared and written to the device.  
The purpose of this guide is to offer help in finding the information you need to cover all these different issues.
Again, the guide is not a cookbook, but it will use the Asus Tinkerboard as an example from chapter 4 onwards, describing in detail how it was done for that particular device.

### Advice ###
Try to find an example build procedure for another OS, a good source of information is usually the suppliers own BSP (Board Support Package) repo or forums and wiki's (e.g. the excellent Hardkernel wiki).  
Also our friends at __<http://armbian.com>__ are doing an awesome job supporting relevant devices, not only do the offer their own ARMBIAN distribution, they are excellent at supporting their kernels up-to-date by patching whenever relevant.  
In case the Armbian Team does not support your device, you are probably going to have a hard time finding a better source for info.  
Another good source of information (also with lots of contributions from the Armbian Team), but dedicated to Allwinner SoC based devices, is __<http://sunxi.org>__  

Look for things like “How to build an SD card for .....”, it makes the porting a lot easier.
