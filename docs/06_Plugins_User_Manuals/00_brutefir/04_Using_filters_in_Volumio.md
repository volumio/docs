## Using filters in Volumio

Now it's time to test your filters. To do that :

If you made your filters with RePhase place them in the shared folder of Volumio:
1. From Windows explorer, access your volumio network share by typing `\\volumio.local\` 
    - This may be substituted with your volumio IP address.
    - The default login and password is `volumio:volumio`
2. Then, copy your generated rePhase impulse file to `Dsp/filters`.

If you use DRC-FIR, the output filter should already be available in the filter selector.

1. In the pluign settings, select a left and right filter. 
2. Under Advanced ensure the sample rate matches the sample rate of the filter file or the result will sound strange. 
3. (Optional) If the attenuation figures are known you can set them now. 
4. Click `Apply`. The filter should be applied after a brief pause.
5. The plugin will prompt you to test for filter attenuation and clipping. __Important: Clicking `Test` will result in full volume Pink Noise being played.__ It is recommended to turn down the volume before proceeding.  

With any luck you now have a good sounding Digital Room Correction applied. However, DRC is complicated with many options and many "tastes". Getting a DRC corrected system to sound the way you like it is a long and complicated process involving lots of trial and error. For serious audio problems check the troubleshooting steps below.

<img src="./img/select_filter.png">

## Troubleshooting:

__Problem: Plugin was working but stopped, settings do not appear to work, or other issues with operation (especially after changing Volumio output settings).__  
Try: Reset the plugin. In the plugin settings at the bottom of the screen click the `Reset Plugin` button. Go back to the Volumio Installed Plugins page and disable the plugin. Then reboot. Don't forget after re-enabling the plugin it will request another reboot to re-perform hardware detection. 

__Problem: No audio output. No Signal Lock on DAC.__  
Try: Ensure that a valid and compatible Output Format and Sample Rate is set in the BruteFIR Advanced Settings in the plugin.  

__Problem: Audio output is heavily distorted.__  
Try: It is possible the filter is causing clipping. Increase the attenuation in the BruteFIR Advanced Settings in the plugin. 

__Problem: Audio output sounds indescribably strange, not at all as expected.__  
Try: Ensure the Sample Rate for the filter matches the Sample Rate for the BruteFIR Advanced Settings. 

__Problem: Using DRC-FIR the audio output sounds like it is filtered correctly but there are strange artifacts.__  
Try: DRC is not an exact science. Different levels of filtering can cause ringing and other strange distortions, especially with "stronger" configs. Try to re-make the filter in DRC-FIR with the `minimal` config. 

### For other issues and bugs visit the [ : Brutefir Git-Hub](https://github.com/balbuze/volumio-plugins/tree/master/plugins/audio_interface/brutefir3)