# Adding Music from a shared folder on a Synology
`tested on Synology DS412 in combination with Volumio 0.978 for Raspberry Pi 3`

Since both Synology and Volumio for Raspberry PI are Unix based the preference is to use NFS type file sharing.
> For more information visit: [https://en.wikipedia.org/wiki/Network_File_System](url)

**Synology preparation**
To enable NFS on Synology follow the detailed guide from Synology [https://www.synology.com/en-global/knowledgebase/DSM/tutorial/File_Sharing/How_to_access_files_on_Synology_NAS_within_the_local_network_NFS]

The guide will explain in great detail the steps required.

The final NFS rule configuration is shown in the screenshot. The most important part is the **Squash** setting. The required access is RW and since it's wise to disable the Guest account on your Synology, the Squash setting must be set to Map all users to admin.

<img width="546" alt="screen shot 2016-08-20 at 16 14 07" src="https://cloud.githubusercontent.com/assets/15366175/17831725/2e34df3c-66f1-11e6-962b-a608ec729d96.png">

**Volumio preparation**

- Go to settings > My Music
- + Add New Drive
- Make sure you configure the share as shown in the screenshot.

> volume1 is normally the first part of the path, followed by the name of your share. In this case **Music**

Since we shared using NFS no username and password is required and

<img width="515" alt="screen shot 2016-08-20 at 15 59 46" src="https://cloud.githubusercontent.com/assets/15366175/17831660/27a0e2ee-66ef-11e6-9200-fa05cf3ec5bc.png">
