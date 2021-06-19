## Linux Device Tree Overlay: Rotary Encoder
Even with a perfect signal from RC-filter and  Schmitt-trigger, there were still missed ticks sometimes. I could solve that by moving to the DT overlay driver for rotary encoders.     

Raspbian (and Volumio) support it out of the box. If you load the device-tree overlay for a rotary, you no longer need to take care of the Gray-Code and just hook up to a device that will nicely send you information about turns of the rotary encoder (relative or absolute, the plugin only supports relative so far).

The advantages of the dtoverlay solution:
- Very fast response, due to Kernel level implementation
- Versatile driver for use with all kinds of encoder types
- The dtoverlays can dynamically be loaded and unloaded, so integration was quite straightforward.

The plugin basically executes calls to dtoverlay for adding and removing overlays:   
To add a rotary:
```
sudo dtoverlay rotary-encoder pin_a=17 pin_b=27 relative_axis=1 steps-per-period=2 
```
To remove a rotary:
```
sudo dtoverlay -r 
```

The plugin is doing this when you change and save settings. You do not need to go to the command line.  