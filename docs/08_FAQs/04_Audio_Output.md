## Audio Output

#### How do I set the audio output from Volumio?

Select 'Settings', 'Playback Options', and choose your 'Output Device' from the drop down menu. If you are are NOT using an i2s device (for example a USB DAC), then ensure that the 'i2s' switch is in the 'Off' position. Choose the correct DAC model (note that some DAC models use a common driver), and save your settings.  Reboot & check that the settings are retained.

#### Why can't I control the volume from the Volumio UI?

Not all DACs include a hardware volume control (check with your device manufacturer) which allows the changing of volume from the UI.  This behaviour can be achieved in such devices by selecting the Mixer Type as 'Software', rather than 'Hardware', BUT please note that this results in a degradation of the sound quality.  If this is a problem then select Mixer Type as 'None', and adjust the volume on your amplifier.

#### Does Volumio support multiroom play?

Volumio does allow the control of devices in different rooms from a single Volumio UI (if you have more than one device, then they will be visible in the UI).

Multiroom synchronised play is also possible through the use of a 'Snapcast' plugin.
