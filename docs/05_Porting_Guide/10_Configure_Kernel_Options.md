## Changing Kernel Options, Volumio requirements ##
### Basics ###
support for initramfs  
overlayfs  
squashfs  
nls437
nfs server  

### Volumio 2 reqs ###
usb audio
board's soc sound options and codes
iptables  
all built-in wireless options (wifi/bluetooth) and possible wifi dongles  

Wherever possible, configure the options as a module (no need to blow up the kernel for things we not always use)
