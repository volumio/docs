## The Platform Folder ##

Create the platform folder. This will be used to store all device-specific files, like kernel, boot configuration, u-boot and SPL files and anything we find during the build which is board specific goes here.  
This folder gets tarred in the end and moved into a separate volumio repo, described in __Saving Files to the Platform Folder__.    

We presumed the board is called tinkerboard and we have the location of the kernel and u-boot, including the config files  which we will use.
Assuming, Asus will released further sbc's in the future, we will name the platform folder "platform_asus" and create a subfolder "tinkerboard" which will hold the platform files for that board.   

Then start preparing:

    mkdir platform-asus
    mkdir platform-asus/tinkerboard/boot
    mkdir platform-asus/tinkerboard/etc
    mkdir platform-asus/tinkerboard/u-boot
    mkdir platform-asus/tinkerboard/usr
