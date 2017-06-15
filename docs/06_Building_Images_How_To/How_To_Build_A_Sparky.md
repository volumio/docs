### sparky-build
Scripts to help build  Sparky image

#### Prerequisites

```
git squashfs-tools kpartx multistrap qemu-user-static samba debootstrap parted dosfstools qemu binfmt-support qemu-utils
```

It is recommended, not a necessity, to use Debian Jessie 8 (as that's what we are building for).  
If on Ubuntu, you may need to remove `$forceyes` from line 989 of /usr/sbin/multistrap  

### How to
#### Prepare
- clone the help scripts repo to $HOME  :  
git clone http://github.com/gkkpch/sparky-build  $HOME/sparky-build
- go to $HOME/sparky-build, type
```
./infrainit.sh  
```
This will  
- clone the sparky kernel repo to $HOME/sparky-linux  
- clone the official Volumio 2 build repo to $HOME/volumio-build  
- place the default platform-sparky files into the volumio-build folder

#### Build the platform files
- go to $HOME/sparky-build to start the kernel build, type:    

```
./build-kernel.sh  
```
In case you don't need kernel config changes, just exit menuconfig.
Otherwise do not forget to save the config (via menu or when prompted).  

#### Build Sparky Image
- goto $HOME/volumio-build and type:   

```
sudo ./build.sh -b arm -d sparky -v -<anything to identify>
```

You can do it separate, rootfs first and then the image:    

```
sudo ./build.sh -b arm  
sudo ./build.sh -d sparky -v -<anything to identify>   
```

Once you built the arm rootfs, there is no need to repeat this (unless volumio has changed).  
For subsequent image builds, just do:  

```
sudo ./build.sh -d sparky -v -<anything to identify>
