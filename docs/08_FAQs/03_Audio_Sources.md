## Audio Sources

#### What audio sources can I add to Volumio?

NAS drive shares (CIFS & NFS) are easily mounted and scanned by Volumio for audio content.  You can add USB hard drives, USB sticks, and use the free space on your SD card for extra or mobile storage.  There are lots of built-in internet web radio streams available, and you can also add your own. Spotify and Youtube are available as plugins. Streaming from mobile devices is provided out-of-the-box by Airplay & UPnP/DLNA.

#### How do I add a NAS drive share?

Navigate to 'Settings' ("cog" icon at the top right), 'My Music' and click on 'Add new drive.'  Volumio will attempt to automatically find any music shares, and settings can be added manually if this is not successful.  You will need to choose a name for the share, and decide between CIFS (default) or NFS protocols (see your NAS GUI for more information). If entering details manually, you will also need to know the IP address of the NAS, and the path to the share (again see NAS GUI).

Please ensure that the permissions on the NAS files are set correctly for CIFS in order for Volumio to be able to access them.  In the case of NFS, file permissions are not so important, BUT you must allow access to the NAS from the IP address of your Volumio device (set in NAS GUI).

#### I'm getting an error adding a CIFS network drive on my NAS

Some users are experiencing problems adding shares from Synology and other NAS manufacturers in recent versions of Volumio. The current fix is to add a **vers=2.0** entry to the "Options" field under the Network Drive's Advanced Options. Depending on the configuration of your NAS, you may require vers=1.0 or vers=3.0. vers=2.0 seems to be a well-accepted default.

__Example__ of a Cifs network drive with options using _vers=1.0_
<img src="./img/cifs_options.jpg">

#### Does Volumio support Airplay & UPnP/DLNA?

Yes, these are enabled by default, and Volumio will act as a renderer for such streams.

#### Does Volumio support Bluetooth?

No, Volumio does not natively support bluetooth, but there are considerable efforts being made by the Community to develop plugins that allow this functionaility.

#### Is there a maximum number of tracks allowed in the music library?

There isn't a maximum number of tracks, but do be aware that indexing of very large collections (>10000) may take some time, especially on lower powered devices.

#### Can I use the unused space of my SD card for music?

Yes, free space on the SD card is available as a Samba share "Internal Storage", which can by used as you like.  Music files transferred there then they will be shown in your Volumio music library in a folder called 'INTERNAL.'
