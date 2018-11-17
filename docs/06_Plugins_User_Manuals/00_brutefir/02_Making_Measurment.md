## Create your own filters

There is 4 important steps to that :

* playing sweep file or pink noise using Tools in the plugin.
* Recording signal while playing (with REW)
* Modifing the result (with REPHASE) and generating filters.
* Using this filter in Volumio trough the Brutefir plugin.


### Tools in Volumio

To help to generate your filter, the plugin can provide some tools.

__Sweep files__

These wav file contain a 20Hz to 20000kHz signal plus a time reference signal.

__Pink noise files__

Provide pink noise files.

Tools are not installed by default. If you need to install, press install tools in the plugin and wait the windows to be refreshed.


<img src="./img/install_tools.png">

After the page is refreshed, you'll new entries in the page of the plugin.

### Measurment

We will describe a method called MMM - Moving Mic Measurment.

The idea is to make a multi point measurement and use the average of these measures.

Read more about moving microphone method (implemented via RTA in REW) here:
<a href="http://www.ohl.to/audio/downloads/MMM-moving-mic-measurement.pdf"> : MMM</a>

Measurment points are defined like in above pictures

<img src="./img/sofa_top.png" width = 500 >

<img src="./img/sofa_front.png" width = 500 >

<img src="./img/sofa_iso.png" width = 500 >

It avoids to have a single optimized listening point

### Let's go ! (to rewrite)

Now, plug your Microphone on your computer, and place it where you should be to listen music. The placement is important, and you're advised to read some howto...

Launch REW (roomeqwizard)

Before measuring, some adjustement are needed :

* Configure mic calibration as below :

<img src="./img/preferences_micmeter.jpg">

* Then, ajust parameters for input and output :

<img src="./img/rew_preferences.jpg">

* Configure Make a measurement parameters :

<img src="./img/make_a_measurment.jpg">

* When ready, hit Start measuring a wait for in the message `Waiting for time reference`

Now, play the first sweep file for the channel you are measuring (Left or Right)

* Once it is done, in REW, in EQ windows under settings (icon in upper right corner) choose 1/48 smoothing

<img src="./img/rew_EQ_window.jpg">


-        choose File/Export/Export measurement as text (this file will be imported in rePhase)

* Repeat the same for the other channel



### Now you are ready for the next step : Create your filters !
