## SSH access on volumio

For security reasons, SSH is disabled by default on all versions after 2.199 (except first boot). It can be however enabled very easily.

### First method: file

Just create or copy a file called ssh in /boot . You can do it right after flashing Volumio, by creting it in the "Boot" partition of your SD Card.

### Second method: DEV UI

Navigate to the DEV ui by pointing your browser to VOLUMIOIP/DEV or volumio.local/DEV . Find the SSH section, and click enable. From now on your SSH will be permanently enabled.
