## Adding Music from a shared folder on a Synology

The following has been tested on a Synology DS412 in combination with Volumio 0.978 for Raspberry Pi 3.

Since both Synology and Volumio for Raspberry Pi are Unix based the preference is to use NFS (Network File System) type file sharing. More information about NFS is available [on Wikipedia](https://en.wikipedia.org/wiki/Network_File_System).

#### Synology preparation

To enable NFS on Synology follow the [detailed guide from Synology](https://www.synology.com/en-global/knowledgebase/DSM/tutorial/File_Sharing/How_to_access_files_on_Synology_NAS_within_the_local_network_NFS). This guide explains in great detail the steps required.

The final NFS rule configuration is shown in the following screenshot. The most important part is the `Squash` setting. The required access is `RW` and since it's wise to disable the Guest account on your Synology, the `Squash` setting must be set to `Map all users to admin`.

<img width="546" alt="Synology NFS configuration panel" src="https://cloud.githubusercontent.com/assets/15366175/17831725/2e34df3c-66f1-11e6-962b-a608ec729d96.png">

#### Volumio preparation

- Go to `Settings > My Music`
- Press `+ Add New Drive`
- Make sure you configure the share as shown in the screenshot below. `volume1` is normally the first part of the path, followed by the name of your share (in this case, `Music`)

Since we are using an NFS share, no username nor password are required.

<img width="515" alt="Volumio audio sources panel" src="https://cloud.githubusercontent.com/assets/15366175/17831660/27a0e2ee-66ef-11e6-9200-fa05cf3ec5bc.png">
