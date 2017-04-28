## Getting the kernel Source ##
### Use the Armbian Tool to get a patched kernel 4.4.xx ###

We will use the armbian toolset to download and compile the kernel only.  
Go to __<https://docs.armbian.com/Developer-Guide_Build-Preparation/>__  
Make sure you meet the requiremens in “What do I need”

Follow the guide to run the script

    ./compile.sh KERNEL_ONLY=yes KERNEL_KEEP_CONFIG=yes

From the menu, select “Kernel and u-boot packages”.  
Then select “Tinkerboard” from the supported boards menu.  
You will then have to select the kernel version & branch.  
Pick the default “Vendor Provided / legacy (3.4.x – 4.4.x)” from the presented list.  
This is not really “Vendor provided” in the true sense, as Armbian then clones from the mqmaker repo as explained above.  
You can forget about u-boot and sunxi-tools, we do not need them for our purpose.  

When you're building on a Ubuntu machine, you can continue with kernel compilation in

    $HOME/sources/linux-rockchip/miqi/release-4.4

Otherwise  

    cd $HOME/sources/linux-rockchip/miqi/release-4.4
    sudo make clean
    cd ..
    sudo tar cvfJ release-4.4.tar.xz ./release-4.4  

...then transfer the tarball, create $HOME/sources/linux-rockchip/miqi on your target system and unpack it in the miqi folder
