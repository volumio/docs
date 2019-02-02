## Stream audio to Volumio

Volumio usually uses music it finds locally (internal memory, USB disk, ...) or on the network (Spotify, web radio, DLNA server, ...). But it is also able to receive an audio stream directly from devices connected on the local network, such as a smartphone or a computer: in this case, Volumio acts as a _renderer_, and converts the stream to sound, played through the attached audio device.
It understands two protocols: [UPnP/DLNA](https://en.wikipedia.org/wiki/Digital_Living_Network_Alliance) or [AirPlay](https://en.wikipedia.org/wiki/AirPlay).

### UPnP - DLNA
* Volumio is a UPnP Media Renderer front-end for MPD (the Music Player Daemon used in Volumio), thanks to [upmpdcli](https://www.lesbonscomptes.com/upmpdcli/)


### Airplay
* AirPlay is an equivalent protocol to DLNA, but proprietary and developed by Apple. It is used by default by iTunes, and on iPhone, iPad, ...
* This protocol is now available on other non-Apple sources (see below)

Both protocols are implemented by default in your Volumio device and nothing needs to be configured there.
However some setup may be needed on your other device to enable sending streams to Volumio.

### Stream from Windows
* You have several solutions to stream from Windows (all the sound going to your usual speakers will be redirected to a DLNA or AirPlay stream):
  * [Stream What You Hear (SWYH)](http://www.streamwhatyouhear.com/), transforming your PC into a DLNA streamer. If it doesn't work, you can also use the "HTTP Live Streaming" function, and indicate the provided URL to Volumio, creating a new Web Radio.
  * [TuneBlade](http://tuneblade.com/), transforming your PC into an Airplay streamer
* If you want to use this solution in order to stream the audio of a movie you're watching, consider that streaming necessitates a delay: in your video software (for example VLC), use the option to compensate this delay (J and K keys on VLC, usually around 2 seconds delay)

### From Android
* In this case too, all the sound going to your usual speakers will be redirected to a DLNA or AirPlay stream
* Usually, your device must be rooted in order to allow the app to capture the audio from the Android system
* Several apps are compatible, including [AllConnect](https://play.google.com/store/apps/details?id=com.tuxera.streambels), [AirAudio](https://play.google.com/store/apps/details?id=eu.airaudio), [AllStream](https://play.google.com/store/apps/details?id=com.kineticgamestudios.airtunes.android) or [BubbleUPnP+Xposed](https://play.google.com/store/apps/details?id=com.bubblesoft.android.bubbleupnp).

## Trouble Shooting
* Don't hesitate to restart your devices (Windows, Android, Volumio, Wifi router, ...) if you can't connect them
