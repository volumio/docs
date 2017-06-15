## Getting the kernel Source ##
### Use the Asus Tinkerboard Repo to get the kernel source (4.4.xx) ###

Luckily, Asus now supplyies their own kernel repo
Start with downoading onto your Home folder

    git clone http://github.com/tinkerboard/debian_kernel linux-asus

### Patches ###

Sometimes, especially with brand new boards, changes are made by others, which would suit Volumio but haven't found their way into the (vendor's) kernel repo.
A way to get these into our kernel is applying these changes aspatches.
At the time of writing, 3 patches are know, which I will apply from one single patch file.
It deals with:

- Change in the kernel compile 'makefile' in order to eliminate two very strict syntax checks, which causes the compile to fail with gcc version 6. The best way would have been to fix the sources, but I consider that a task for the maintainers.
- Change to the behavior of two board leds, allowing one blinking as a heartbeat and the other one blinking for disk activity
- an entry in the usb quirks table, to show the internal usb audio device to show a friendly name (Tinkerboard)  

The patch is in the plaform-asus folder, under "patches": Volumio-Kernel.patches.  
Copy it to the kernel root folder and apply as follows:  

    patch -p1 < Volumio-Kernel.patches
