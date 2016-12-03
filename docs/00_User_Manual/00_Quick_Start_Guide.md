### Quick start guide


#### First Boot

* Volumio's first boot will take usually longer, up to 6 minutes if you're on a Raspberry PI 1. Therefore, be patient of first boot and wait about 5 minutes before starting to use Volumio.
* The first time Volumio starts, it will perform some operations:
- Extend the filesystem to fill completely your SD Card\ Hard drive
- Regenerate SSH keys, to make them unique to your device
- Install some packages and configure the system
- Generate new thumbnails for the default backgrounds

#### Network connection

* Volumio works best when its connected to your Network, since it's meant to be used in an headless state: no monitor connected, and controlled via another device (PC, smartphone, tablet etc)
* To connect Volumio to your network, simply attach an ethernet cable to it before starting it up
* If no ethernet is available, you can connect to its hotstpot (see below) and connect to your Wi-fi Network. To do so, go to settings -> Network and connect it from there
* *IMPORTANT* Do not configure your network manually via SSH, this can lead to issues and malfunctions

#### Volumio Hotspot

* If your device has wireless capabilities (and a supported Wireless card) Volumio will create a Wireless Network called **Volumio**, the default password is **volumio2**
* The Hotspot mode will allow you to connect to your Wireless Network without the need to a wired connection, just connect to Volumio Hotspot and configure your network on network options
* Once your Wireless network has been configured, the Hotspot will no longer be visible
* If, for whatever reason, your configured Wireless network is not available, Volumio will automatically re-enable the Hotspot
* You can change the Hotspot options in the Network options, such as its name, password and channel (useful if you experience poor Hotspot performances)
* Once in Hotspot Mode, Volumio can be reached with IP **192.168.211.1** or via **http://volumio.local** as usual


#### UI connection

* The UI can be accessed from any device with a browser: Tablets, PC, Mac, Android Phones, iPhones, Smart TVs, Ebook readers etc. Make sure you have the latest versions of their respective browsers. For an optimal experience, Google Chrome is suggested.
* The UI can be accessed by typing Volumio's IP address on your browser. To find the IP address you can use:
- **ANDROID** [FING](https://play.google.com/store/apps/details?id=com.overlook.android.fing&hl=it)
- **iOS** [Net Analyzer](https://play.google.com/store/apps/details?id=net.techet.netanalyzerlite.an&hl=it)
- **Chrome** [mDNS Browser](https://chrome.google.com/webstore/detail/mdns-browser/kipighjpklofchgbdgclfaoccdlghidp)

* Volumio UI can also be accessed by typing [http://volumio.local](http://volumio.local), or if you renamed your Volumio device http://VOLUMIONAME.local .
- Please note that this function is not available on Android devices, just on Mac and iOs or in Windows (if that does not work, install [Bonjour](http://www.raspyfi.com/wp-content/uploads/BonjourSetup.exe) )
