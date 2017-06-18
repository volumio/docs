## Creating the Image
### Prerequisites ###
    git squashfs-tools kpartx multistrap qemu-user-static samba debootstrap parted dosfstools qemu binfmt-support qemu-utils

It is recommended, not a necessity, to use Debian Jessie 8 (as that's what we are building for).  
If you build on Ubuntu, you may need to remove __$forceyes__ from line 989 of /usr/sbin/multistrap.  

You need to fork the volumio build repo from github.
Work on that version until you are ready to integrate, then issue a PR.  
Volumio Build location: __<http://github.com/volumio/Build>__  

You will need build a rootfs for the build scripts, use Volumio's main script __build.sh__
Do not change the main Volumio build script yet, leave build.sh and your build scripts separate until you are satisfied with the new scripts and wish to integrate.
The script is self-explanatory, to integrate, add your start script just before line "x86) echo 'Writing x86 Image File'".

To build the rootfs: go to the root of your build folder and type:  

    sudo ./build.sh -b armv7

(We use armv7 here, as arm should only be used for PI and armv8 is not supported yet)

### Building the scripts ###
Image building is done in two steps, implemented in two separate scripts.  
These scripts form a set.  
One script deals with image creation and calls the second one, which runs under chroot and deals with device-specific configuration.  
For examples of these build script sets, see the scripts folder in the Volumio Build repo.  
There are two "types" of sets:  
- ones that add kernel and bootloader from pre-built packages during device-specific configuration. Good examples are raspberry and X86.
- others that add bootloader, kernel and other platform files during the image creation part. Good examples are Odroid C2 and Sparky.
You need to figure out, which type suits best, then take one of those sets as a template.  
Most times there is no need to build completely from scratch.

Main tasks of the first script (for details see chapter Image Build Part 1):  
- creates the image "bed"
- creates the different partitions
- downloads the platform files
- installs bootloader, adds kernel, boot config, dtb(s) etc., depending on build script type, see above
- copies the Volumio rootfs (created separately for arm, armv7 or x86)
- calls the configuration script
- creates the squashfs (compressed) filesystem from the rootfs

Main tasks of the configuration script (for details see chapter Image Bild Part 2):  
- creates fstab
- installs bootloader, adds kernel, boot config, dtb(s) etc., depending on build script type, see above
- adds device-specific packages
- adds device-specific kernel modules (eg. sound and wireless drivers)
- finishes with building the initramfs

### Naming convention ###
The scripts are usually named after the board name (or it's shortname), followed by "image.sh" for script one and ".config.sh" for the second script.  
In this example case: __tinkerimage.sh__ and __tinkerconfig.sh__ (with a shortname as we don't want the boardname too long)

### Warning ###
The Tinkerboard is a brand new board, it was used as __an example and still is WIP__.  
This means a number of changes may still be necessary, which most likely will affect the config script.
The image image script 

### Building the image ###
Once the scripts have been created, you can start testing them, go to the rootfolder of the build repo and type:  

    sudo ./scripts/tinkerimage.sh -v -2.200draft

For the version string you can actually use whatever suits you to identify your image.  
The version is only relevant for released and centrally built images.
