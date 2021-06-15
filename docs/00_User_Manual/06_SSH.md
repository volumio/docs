## SSH access on volumio

Volumio supports command-line access via SSH. This can be helpful if you need
full access to the device, for example if you are debugging a problem or
want to test changes to the system.

Most popular operating systems support making SSH connections in some way:

 * __Windows__ : Install [Putty](https://putty.org/), or use `ssh.exe` on [Windows 10](https://adamtheautomator.com/powershell-ssh/)

 * __Linux__ : ssh command from a terminal

 * __macOS__ : ssh command from the Terminal app
 (You may need to install [openssh](https://www.macupdate.com/app/mac/5675/openssh#) first)

Once you have enabled SSH access (see below), you can log in with:

* user: volumio

* password: volumio

Example (Linux) :
<pre>
laptop$ ssh volumio@192.168.1.54
volumio@192.168.1.54's password:
</pre>
Type in the password at the prompt and press the `<Enter>` key.
(The password will not be shown on the screen)

And here you are !

<pre>
volumio@192.168.1.54's password:
                       ___
                      /\_ \                        __
         __  __    ___\//\ \    __  __    ___ ___ /\_\    ___
        /\ \/\ \  / __`\\ \ \  /\ \/\ \ /' __` __`\/\ \  / __`\
        \ \ \_/ |/\ \L\ \\_\ \_\ \ \_\ \/\ \/\ \/\ \ \ \/\ \L\ \
         \ \___/ \ \____//\____\\ \____/\ \_\ \_\ \_\ \_\ \____/
          \/__/   \/___/ \/____/ \/___/  \/_/\/_/\/_/\/_/\/___/

             Free Audiophile Linux Music Player - Version 2.0

          C 2015 Michelangelo Guarise - Volumio Team - Volumio.org


Volumio Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
volumio@192.168.1.54:~$
</pre>

From here you can get full access to your device.

Sometimes you will want to run commands that require superuser (or 'root')
privileges. To do that use the `sudo` command. For example:

<pre>
volumio@192.168.1.54:~$ sudo nano /etc/samba/smb.conf
[sudo] password for volumio:
</pre>

This runs the command `nano /etc/samba/smb.conf` as the superuser.
When prompted for the password, use the same one you used to log in with.

__WARNING!__  You can damage your __Volumio__ with `sudo`. If you delete
the wrong file or use incorrect syntax when editing a file, the system may
stop working correctly.

Please be aware that editing system files may stop you being able to update
__Volumio__ over the air. This is because the system does an integrity check
(to make sure the update will apply correctly). If changes are detected, the
integrity check will fail and the update will not proceed.

## How to enable SSH

For security reasons, SSH is disabled by default on all versions after 2.199 (except first boot). It is easy to enable (and disable).

### First method: DEV UI (easy)

Navigate to http://volumio.local/dev or http://yourvolumioip/dev, where 'yourvolumioip' is the actual IP addess of your device eg. 192.168.1.54.
Find the SSH section, and click 'enable'. From now on your SSH will be permanently enabled. To disable SSH again, click 'disable'.

<img src="./img/ssh_enable.png">


__Note__ : When clicking on the button, you will see no change in the browser window, but the SSH server will be started.


### Second method: file (more advanced)

This involves adding a file with a special name to the SD card containing your __Volumio__.

 * Flash __Volumio__ to the SD card, if you have not done so already
 * Mount the SD card on your computer
 * Create a file called `ssh` in the `/boot` partition on the card.<br>
 The file does not need anything inside it, but the name must be `ssh`.

