## SSH access on volumio

Volumio supports command-line access via SSH. This can be helpful if you need
full access to the device, for example if you are debugging a problem or
want to test changes to the system.

Most popular operating systems support making SSH connections in some way:

 * __Windows__ : Install [Putty](https://putty.org/), or use `ssh.exe` on [Windows 10](https://adamtheautomator.com/powershell-ssh/)

 * __Linux__ : ssh command from a terminal

 * __macOS__ : ssh command from the Terminal app
 (You may need to install [openssh](https://www.macupdate.com/app/mac/5675/openssh#) first)

Once it is ready, use to log in:

* user: volumio

* password: volumio

Example (linux) : `ssh volumio@192.168.1.35`

Type `Enter`. It returns:

`volumio@192.168.1.35's password:`

Type `volumio` (password, case sensitive) and `Enter`

And here you are !

<img src="./img/log_ssh.png">

From here you can get full access to your device.
Some commands require Root privileges. To do that use `sudo` with password `volumio`

example `sudo nano /etc/samba/smb.conf`

__WARNING!__  You can damage your __Volumio__ with `sudo`. Editing system files may prevent __Volumio__ to be updated over the air (integrity check will fail).

## How to enable SSH

For security reasons, SSH is disabled by default on all versions after 2.199 (except first boot). It can be however enabled very easily. See below!

### First method: DEV UI (easy)

Navigate to the DEV ui by pointing your browser to VOLUMIOIP/DEV or volumio.local/DEV . Find the SSH section, and click enable. From now on your SSH will be permanently enabled.

<img src="./img/ssh_enable.png">


__Note__ : You'll see no change when clicking on the button, but it will be ok.


### Second method: file (more advanced)

Mount your SD card on your computer.

Create or copy a file called ssh in /boot . You can do it right after flashing Volumio, by creating it in the "Boot" partition of your SD Card.
