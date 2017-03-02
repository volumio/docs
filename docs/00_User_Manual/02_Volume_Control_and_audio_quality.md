## Volume Controls and Audio Quality

### Introduction
It's not true that enabling volume control ALWAYS tampers with bit perfect. 
There are 2 ways to get Volume control:
* Software mixer: the audio streaming is manipulated to get the desired volume change. This makes the stream not bitperfect, 
and degrades sound quality
* Hardware Mixer: its not supported by every DAC, but if the DAC supports this, it will trigger its array of internal resistors to change
the volume. In this mode, you can change the volume while keeping bit perfect and without any audio quality degradation.

### How to get the best sound and Volume Control
Volumio can detect if your DAC supports Hardware mixer, and enable it automatically. If your DAC does not support it, Volumio will 
allow you to enable software mixer. To change this behaviour you can go to Playback Options -> Volume Settings:

Select the Mixer Type: 

* None = No volume control
* Software = Volume control but loss of Audio Quality
* Hardware = Best of both worlds, provides ability to change volume without loss of quality
