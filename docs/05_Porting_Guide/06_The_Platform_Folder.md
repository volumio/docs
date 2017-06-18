## The Platform Folder ##

Create the platform folder. This will be used to store all device-specific files, like kernel, boot configuration, u-boot and SPL files and anything we find during the build which is board specific goes here.  
This folder gets tarred in the end and moved into a separate volumio repo, described in __Saving Files to the Platform Folder__.    

We presumed the board is called tinkerboard and we have the location of the kernel and u-boot, including the config files  which we will use.
Assuming, Asus will released further sbc's in the future, we will name the platform folder "platform_asus" and create a subfolder "tinkerboard" which will hold the platform files for that board.   

Then start preparing, assuming the root of the platform files is in $HOME/asus-build

    mkdir $HOME/asus-build/platform-asus
    mkdir $HOME/asus-build/platform-asus/tinkerboard/boot
    mkdir $HOME/asus-build/platform-asus/tinkerboard/etc
    mkdir $HOME/asus-build/platform-asus/tinkerboard/u-boot
    mkdir $HOME/asus-build/platform-asus/tinkerboard/usr

Note: eventually you need to add the platform folder to the Volumio repo.
This does not need to be done immediately.  
Chapter "Creating the image" shows a way to build an image before integrating the new scripts and platform files into the repo.  
The same method can be used to test new platform files before they are pushed.
When integration is due, get in touch with @volumio (Micelangelo) to have him create the platform-file repo, in our case "platform-asus".
Fork this one and clone it to your host PC, add (or edit) the README.md file.
This file should at least contain a reference the used kernel source location, u-boot and other relevant device-specific info.  
Best practise also means you keep a changelog in README.md.
Examples of README.md in are in the Volumio Platform repos.
