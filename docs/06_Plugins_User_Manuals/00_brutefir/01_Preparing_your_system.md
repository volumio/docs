## Preparing Your system

Once the plugin is installed, enabled it wait about 20 sec.
Don't try to make any change in Volumio playback.

The plugin will test your hardware to propose supported output format. Most of the time, a __reboot__ is required to get good values.

__If no error__ :
Try to play a track, if the music is playing, go to the next step.

If an error occurs go in plugin settings


and try to change __output format__ . It is a DAC dependant parameter.


__Main Interface of the plugin__

<img src="./img/general_plugin_settings.png">
__plugin main interface__

When it's ok, try to play a track.

You can now test with a filter, just select __demo-left.pcm__ and __demo-right.pcm__ in plugin settings:
(few filters to test are installed by the plugin, they are placed in `/data/INTERNAL/brutefirfilter`)

<img src="./img/select_filter.png">


and press `Apply` (It can be done while playing)

You should hear the difference !

__VoBAF settings__

<img src="./img/VoBAF-settings.png">

I

__Filter Creation__

In this section, you can generate automatically filters using <a href="http://drc-fir.sourceforge.net/"> : DRC</a>

<img src="./img/filter-creation-menu.png">

__Tools__

This section allows to install tools to help to make measurement with Sweep files with time reference and pink noise file.

<img src="./img/install_tools.png">



### Now, let's see how to create your own filter, just designed for your hardware and room!
Go to next step!
