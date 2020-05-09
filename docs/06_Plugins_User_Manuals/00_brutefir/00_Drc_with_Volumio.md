## Making DRC with Volumio and Brutefir

Thanks to the plugin, you'll be able to apply __Digital Room Correction__ to your system.

The plugin uses   <a href="https://torger.se/anders/brutefir.html">  brutefir</a> as convolution engine to apply FIR filters. 

The plugin is able to generate filters in few clicks, using <a href="http://drc-fir.sourceforge.net/"> : DRC</a>

## What is DRC?

The best thing is to read this <a href="https://en.wikipedia.org/wiki/Digital_room_correction"> : wikipedia DRC</a>

To do that, several requirements :

### For your device
- Having a working __Volumio__ system (obvious)
- Having the plugin installed

### Other softwares on your computer

- REW to makes measurements <a href="https://www.roomeqwizard.com/"> : REW</a>

If you want to make your filters "by hands" :
- Rephase to generate filters <a href="https://rephase.org/"> : Rephase</a>

### Other Hardware

 - A good Microphone. Idealy, you should use a calibrated measurements Mic. You can easily find such Microphone on internet. An usb model is about 100€
 This is a very important point. If you make your measure with a poor mic, you'll get poor results...

### What you can do with the plugin

The plugin uses brutefir to apply filter to the signal.

It can work with up to 2x4 channels.
- Filter type is auto selected and must be :

    - text- 32/64 bits floats line (.txt) in rephase
    - S16_LE- 16 bits LPCM mono (.wav) in rePhase
    - S24_LE- 24 bits LPCM mono (.wav) in rePhase
    - S24_LE- 32 bits LPCM mono (.wav) in rePhase
    - FLOAT_LE- 32 bits floating point (.pcm)
    - FLOAT64_LE- 64 bits mono (.wav) from Acourate
    - FLOAT64_LE- 64 bits IEEE-754 (.dbl) in rephase

        When a filter is selected, a test for clipping is provided.

With a specific namming of files, you can swap between two set of filters.
you have to create 2 set of left and right filter according to the following naming convention:

- for left XXXX_1.YYY and second filter XXXX_2.YYY

- for right ZZZZ_1.YYY and second filter ZZZZ_2.YYY

- filters must have the same attenuation, same type.

Then in the plugin,, select filter named with _1. Save, a new button appears to enable swapping!

- A exclusive feature called VoBAF (Volume Based adaptativ filtering) act as a Loudness adjusted with volume change. Up to 7 seven levels are used with configurable threshold.

- A section to generate filters directly in the plugin using [DRC-FIR](http://drc-fir.sourceforge.net/). You give an impulse from REW, and the plugin calculate the filter.

- The possibility of playing tools files (pink noise,, sweep) from the plugin.