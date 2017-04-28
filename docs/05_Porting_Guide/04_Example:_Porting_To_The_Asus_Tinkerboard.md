## Example: The Asus Tinkerboard ##

We'll use the Asus Tinkerboard, released in Feb 2017, as our example.
The information from Asus is still a bit scarse (as of the time of writing), but there are two communities offering information on creating an image from scratch, though one a little more than the other.  
From the two sources __<http://Armbian.com>__ and the community __<http://Tinkerboarding.co.uk>__, we learn that they use the kernel from different sources.  
While the Asus Tinkerboard beta images are using a kernel from Rockchip, Armbian took the miqi board kernel, based on kernel version 4.4.6 (Miqi and Tinkerboard seem to be pretty close).  
We take the Armbian example and use __<http://github.com/mqmaker/linux-rockchip>__, branch miqi/release4-4.  
This kernel is a little more advanced than the one used for the Tinkerboard beta images as the Armbian Team patched it up to 4.4.63 (as of the time of writing).  
This part of the building process must be done on a Ubuntu 16.x Desktop machine, as we need to use a part of the Team's build framework for it.  
The goal is to eventually replace it with the Asus supported Tinkerboard kernel when more info becomes available.  

We will use u-boot version v2017.03, downloadable from __<http://git.denx.de/u-boot.git>__.  
This will work OOTB as it holds the latest changes for a tinkerboard configuration (tinker-rk3288_defconfig).  
