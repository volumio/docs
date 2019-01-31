## Volume Controls and Audio Quality

### Introduction
Volumio is designed to maximise audio quality - ideally, bit-perfect playback.
Some say that allowing the listener to control the playback volume gives up
that bit-perfect ideal, but that's not correct in all circumstances.

There are two ways to get volume control:
* Software mixer: the audio stream is manipulated to get the desired volume change.
  This makes the stream not bit-perfect and degrades sound quality.
* Hardware Mixer: some DACs (not all) have an array of internal resistors they can use to change the volume.
  In this mode, you can change the volume while keeping the audio stream bit-perfect and avoid any audio quality degradation.

### How to get the best sound _and_ Volume Control
Volumio can detect if your DAC has a Hardware Mixer, and enable it automatically. If your DAC does not support it, Volumio will 
allow you to enable the software mixer. To change this behaviour you can go to Playback Options -> Volume Settings:

Select the Mixer Type:

* None = No volume control
* Software = Volume control but loss of Audio Quality
* Hardware = Best of both worlds, provides ability to change volume without loss of quality
