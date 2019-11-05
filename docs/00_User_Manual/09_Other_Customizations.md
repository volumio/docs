## Other Customizations

### Keyboard layout

If you want to temporarlily change the keyboard layout, you can use the following command:
```
sudo loadkeys fr
```
```fr``` should be replaced by the layout you want.

If you want to definitively change the keyboard layout, you have to run:
```
sudo apt-get install keyboard-configuration
```
and
```
sudo dpkg-reconfigure keyboard-configuration
```
This may not work on your system: modifications of this documentation are welcome.

### System configuration for Raspberry Pi

On a Raspberry Pi system configuration parameters are set in a file called /boot/config.txt (https://www.raspberrypi.org/documentation/configuration/config-txt/).

This file gets overwritten on each Volumio update so user made changes in /boot/config.txt are not preserved. To make them permanent custom settings need to be added to /boot/userconfig.txt instead.
