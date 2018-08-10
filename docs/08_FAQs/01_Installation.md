## Installation

#### How do I install Volumio?

Follow the guide <a href="https://volumio.org/get-started/">here (scroll down)</a>

* __Important__
If you use Windows to write your SD card, it will probably ask you to format the SD card at the end of the writing.
<p style="background-color: rgba(255, 170, 50, 0.3);padding: 20px;border-left: 5px solid orange; border-radius: 4px;color:rgb(255, 170, 50);">
DO NOT FORMAT THE SD CARD NOW! IT WILL ERASE WHAT YOU HAVE DONE JUST BEFORE
</p>

Just eject your SD card and insert it in your device!

#### Why is it important to leave my device alone for 6 minutes (longer on low powered devices such as the RPi Zero) on it's first boot?

Volumio's first boot takes much longer than normal as it carries out a number of essential operations.  These include extending the filesystem to completely fill the SD card/hard drive, regenerate unique SSH keys for your device, install some packages, configure the system, & generate new thumbnails for the default backgrounds.

#### I don't see the Volumio UI, but a login request, what should I do?

Volumio is designed to run headerless; that is to say that there is no graphical UI on the Volumio device itself.  Access the Volumio UI from a browser on some other device (mobile, tablet etc.).

#### How do I set up the wired network settings for Volumio?

If your device is connected to your home network by an ethernet cable, then it should be automatically assigned an IP address by your router. You should be able to see this address from your router UI, and you can access the Volumio UI by entering the IP address in a browser on your mobile, laptop etc.  For Apple and Windows computers running the 'Bonjour' service, and Linux computers running 'Avahi'/'zeroconf' then simply entering 'http://volumio.local' will bring up the Volumio UI.  Generally speaking for Android devices you will need to enter the actual IP address, although some apps will work without you needing to know this.

It is desirable to have a single known (static) IP address for your device if 'volumio.local' does not work.  This can either be set from your router UI, or from Volumio's 'Network Settings.'

<p style="background-color: rgba(255, 170, 50, 0.3);padding: 20px;border-left: 5px solid orange; border-radius: 4px;color:rgb(255, 170, 50);">
Do not directly edit system configuration files ('/etc/network/interfaces') as is frequently suggested on the internet, as this method is now deprecated, and will cause problems with your device.
</p>

#### How do I set up wireless network settings for Volumio?

If your device is not connected to a wired network, then Volumio will automatically start it's own network (Hotspot) called 'Volumio' and assign an IP address of '192.168.211.1' to your device.  You can log onto this network with the default password of 'volumio2', and then setup your wireless settings as you like from 'Network Settings.'  After configuration, the hotspot will switch off, and your device should connect to your wireless network.  The hotspot will be restarted if Volumio is unable to find your network.
