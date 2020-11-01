### DRC with Volumio and Brutefir

___Doc by b@lbuze___

___Update November 1st 2020 by thegarbz___ thanks!


With this plugin you'll be able to apply __Digital Room Correction (DRC)__ to your system.

The plugin uses [: brutefir](https://torger.se/anders/brutefir.html) as convolution engine to apply FIR filters. 

The plugin is also able to generate FIR filters in few clicks, using the [ : DRC-FIR](http://drc-fir.sourceforge.net/) tool.

## What is Digital Room Correction?

DRC is the process of applying filters to correct for undesirable accoustic effects caused by interaction between the the room and speakers. A good source of information is the [ : wikipedia DRC page](https://en.wikipedia.org/wiki/Digital_room_correction)


## How do you apply DRC with this plugin?

There are several requirements to use this plugin :

### For your device
- Having a working __Volumio__ system (obvious)
- Having the plugin installed (Installation instructions on the [ : Brutefir3 git-hub](https://github.com/balbuze/volumio-plugins/tree/master/plugins/audio_interface/brutefir3))

### Software on a computer

- REW - Used to make measurements [ : REW](https://www.roomeqwizard.com/).
- (Optional) Rephase - to generate filters and tweak them "by hand" [ : Rephase](https://rephase.org/).

### Other Hardware

 - A good Microphone. Idealy, you should use a calibrated measurements Mic. You can easily find such Microphone on internet. An USB model is about 100€
 This is a very important point. If you make your measure with a poor mic, you'll get poor results...

## What you can do with the plugin

The plugin uses brutefir to apply FIR filters to the signal.

- It can work with up to 2x4 channels.
- Separate filters may be used for each channel
- Filter type is auto selected and must be :
    - text- 32/64 bits floats line (.txt) in rephase
    - S16_LE- 16 bits LPCM mono (.wav) in rePhase
    - S24_LE- 24 bits LPCM mono (.wav) in rePhase
    - S24_LE- 32 bits LPCM mono (.wav) in rePhase
    - FLOAT_LE- 32 bits floating point (.pcm)
    - FLOAT64_LE- 64 bits mono (.wav) from Acourate
    - FLOAT64_LE- 64 bits IEEE-754 (.dbl) in rephase
- Filter sampling rates can be up to 96kHz. Brutefir resamples and outputs at the chosen sampling rate. 
- When a filter is selected, a test for clipping is provided and attenuation is measured and applied.
- With a specific namming of files, you can swap in realtime between two set of filters.
    - You have to create 2 set of left and right filter according to the following naming convention:
    - For left XXXX_1.YYY and second filter XXXX_2.YYY
    - For right ZZZZ_1.YYY and second filter ZZZZ_2.YYY
    - Filters must have the same attenuation, and be same format.
    - Then in the plugin,, select filter named with _1. Save, a new button appears to enable swapping!

An exclusive feature called VoBAF (Volume Based Adaptative Filtering) can apply varying filters with volume change (e.g. to mimic a "Loudness" filter). Up to 7 seven levels can be used with configurable thresholds.

The plugin can work with supplied FIR filters or generate FIR filters directly using [DRC-FIR](http://drc-fir.sourceforge.net/). Simply proivde an impulse response from a REW measurement, a desired target curve, and the plugin will calculate an FIR filter.

Measurement "Tools" such as frequency sweeps and pink noise can be played from within the plugin. 