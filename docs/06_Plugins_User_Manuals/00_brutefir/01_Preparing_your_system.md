## Preparing Your system

Once the plugin is installed, enabled it wait about 20 sec.
Don't try to make any change in Volumio playback.

__If no error__ :
Try to play a track, if the music is playing, go to the next step.

If an error occurs go in plugin settings

<img src="./img/general_plugin_settings.png">
_plugin main interface_

and try to change __output format__ . It is a DAC dependant parameter.

When it's ok, try to play a track.

You can now test with a filter, just select __Left Filter__ and __Right filter__ in plugin settings with one of the provided filter:
(few filters to test are installed by the plugin, they are placed in `/data/INTERNAL/brutefirfilter`)
* `test4fa`

<img src="./img/select_filter.png">

and press `Apply` (It can be done while playing)

You should hear the difference !

__Room settings__

If your speakers are not at equal distance from the listening point (where you use to be to listen music), the stereo image is altered.
Now you can set left and right distance and the plugin calculates the required delay to get a correct stereo image.

__Note__ If you enter the same value for left and right, no delay is applied.
You can give the distance for left and right, or just the difference.

Value are in cm.

<img src="./img/room-settings.png">

<img src="./img/room_settings_values.png">


### Now, let's see how to create your own filter, just designed for your hardware and room!
Go to next step!
