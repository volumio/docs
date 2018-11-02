## Create your own filters

There is 4 important steps to that :

* playing sweep file (with Volumio)
* Recording signal while playing (with REW)
* Modifing the result (with REPHASE) and generating filters.
* Using this filter in Volumio trough the Brutefir plugin.


### Sweep files

To make it easy, the plugin can provide these files.
These wav file contain a 20Hz to 20000kHz signal plus a time reference signal.
In the plugin settings, click on `Download sweep files`

<img src="./img/general_plugin_settings.png">

Wait, and now you have 3 new files on your system!
TO see them, go in the BROWSE tab of Volumio
Now go in `Music Library`,`INTERNAL`,`brutefirfilters`,`sweep`

<img src="./img/list_sweep_files.png">

### Measurment

Now, plug your Microphone on your computer, and place it where you should be to listen music. The placement is important, and you're advised to read some howto...

Launch REW (roomeqwizard)

Before measuring, some adjustement are needed :

<img src="./img/rew_preferences.jpg">

And before starting to play :

<img src="./img/make_a_measurment.jpg">

With these settings and sweep files provided, the time reference signal included in the file will trigger the recording.


### To be continued....
