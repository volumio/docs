## General

#### What is Volumio?

__Volumio__ is a free and Open Source Linux Distribution, which runs on a variety of devices, typically small and cheap computers like the Raspberry Pi, but also on low power PCs, notebooks or thin clients. It is designed and finely-tuned exclusively for bit-perfect music playback, transforming your device into a headless Audiophile Music Player, that is controlled via your mobile phone, computer or tablet.

#### What devices are supported?

There are recent images available for the Raspberry Pi (all variants : Raspberry Pi 3 Model B, Raspberry Pi 3 Model B+, Raspberry Pi Zero, Raspberry Pi Zero W.), x86/x64 (PC/MAC), Odroid C1/C2, Allo Sparky, Asus Tinkerboard.

In the community portings page of the forum, you'll find image for other devices : Pine64, Rock64, Sopine and other system : <a href="https://volumio.org/forum/community-portings-f26.html">Community portings on the forum</a>

#### What are the device RAM (memory) requirements for Volumio?

Volumio will work much more smoothly and quickly in devices with more RAM.  The recommended mimimum is 1GB, but people are running devices with less.

#### How do I enable ssh?

ssh is disabled by default, except on the first boot, for security reasons.  It is a simple procedure to <a href="https://volumio.github.io/docs/User_Manual/SSH.html">enable it</a> if required.

#### What is a plugin?

The concept of a plugin is to expand the functionality of Volumio in a particular way, for example backup of data files. Most of these are written by the Volumio Community, and can be installed from the 'Plugins' section of the Volumio UI.  Officially approved plugins may be installed directly from within the UI, whereas others are required to be downloaded as a zip file first.

For more details, have look here : [Plugins System Overview](https://volumio.github.io/docs/Plugin_System/Plugin_System_Overview.html)

There is a list of the currently available plugins <a href="https://volumio.org/forum/volumio-plugins-collection-t6251.html">here.</a>

#### Is there an app for Volumio?

Many people like to control Volumio simply from a browser, but there are dedicated apps available from both Apple's App Store & Google Play. Indeed, the official Volumio android app is one way of showing your support for Volumio.

#### What files format can be read ?

Volumio uses mpd and other players.

Mpd is compiled in order to read following files :

__Readable formats:__

 * [mad] mp3 mp2
 * [mpg123] mp3
 * [vorbis] ogg oga
 * [oggflac] ogg oga
 * [flac] flac
 * [opus] opus ogg oga
 * [sndfile] wav aiff aif au snd paf iff svx sf voc w64 pvf xi htk caf sd2
 * [audiofile] wav au aiff aif
 * [dsdiff] dff
 * [dsf] dsf
 * [faad] aac
 * [mpcdec] mpc
 * [wavpack] wv
 * [modplug] 669 amf ams dbm dfm dsm far it med mdl mod mtm mt2 okt s3m stm ult umx xm
 * [ffmpeg] 16sv 3g2 3gp 4xm 8svx aa3 aac ac3 afc aif aifc aiff al alaw amr anim apc ape asf atrac au aud avi avm2 avs bap bfi c93 cak cin cmv cpk daud dct divx dts dv dvd dxa eac3 film flac flc fli fll flx flv g726 gsm gxf iss m1v m2v m2t m2ts m4a m4b m4v mad mj2 mjpeg mjpg mka mkv mlp mm mmf mov mp+ mp1 mp2 mp3 mp4 mpc mpeg mpg mpga mpp mpu mve mvi mxf nc nsv nut nuv oga ogm ogv ogx oma ogg omg opus psp pva qcp qt r3d ra ram rl2 rm rmvb roq rpl rvc shn smk snd sol son spx str swf tak tgi tgq tgv thp ts tsp tta xa xvid uv uv2 vb vid vob voc vp6 vmd wav webm wma wmv wsaud wsvga wv wve
 * [gme] ay gbs gym hes kss nsf nsfe sap spc vgm vgz
 * [pcm]

__Web Radios__

Volumio can play web radio.

__Airplay__

Volumio can read Airplay streams using shairport-sync-reader

__Upnp__

Volumio can read Upnp stream

__More readable files__

With use of plugins, Volumio can read miscellanious streaming services

* Spotify (from webUI or Spotify connect)
* Youtube streams
* Qobuz (using MyVolumio)
* Tidal (using MyVolumio) _Not available yet_
* Other to come
