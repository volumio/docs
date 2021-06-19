## Potential future extensions
- add the other parameters offered by the dtoverlay (e.g. absolute positioning, binary instead of Gray-code etc.)
- Add support for more than 3 encoders
- Add support for dtoverlays loaded at boot (similar to overlays for I2S DACs)

## Known issues and limitations
### Kernel warning when last overlay is removed
When the plugin is disabled, a kernel warning message about a potential memory leak is displayed when the last overlay is removed. I tried several things to prevent it and posted to several forums looking for help, but could not get rid of it. 
I consider it as not nice, but I could also not observe any issue after multiple disable/enable loops - so I decided to keep it as is for the time being.
During normal use, the plugin will be configured once only and then loaded at boot and unloaded at shutdown - so you should never experience an issue. I use it for several months already without issues.    
  

## References
### Device Tree Documentation
- [Kernel Documentation: rotary-encoder](https://www.kernel.org/doc/Documentation/input/rotary-encoder.txt)   
Explains more about how a rotary works and how the DTOverlay is implemented
- [Documentation of the `dtoverlay` command](https://github.com/raspberrypi/firmware/blob/master/boot/overlays/README)   
Search for 'rotary-encoder'. Alternatively, you can call 
  ```
  dtoverlay -h rotary-encoder
  ```
  from the command line.
- [Documentation of the Raspberry Device Tree](https://www.raspberrypi.org/documentation/configuration/device-tree.md)   
If you would like to learn more about the details of the dtoverlay function.

### NPM modules used
- [onoff](https://www.npmjs.com/search?q=onoff)   
Since it was easier to implement and does not have any issues, I still use _onoff_ for the push button. This could also be done with _dtoverlay_, but seems too much effort since it does not provide additional performance.

### Hardware Resources
- [RPi GPIOs](https://www.raspberrypi.org/documentation/hardware/raspberrypi/gpio/README.md)


