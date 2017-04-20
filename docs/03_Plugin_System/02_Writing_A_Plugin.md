## The Plugin Zip File

The  plugin zip file will be created as the last step of the plugin creation and it must contains :


### Mandatory Files

|Name   | Format  | Content  |
|---|---|---|
| install.sh  | Bash script  | this file contains a script of action and dependencies installation needed for the plugin. It’s a BASH script. It MUST be executable.    
| index.js  |  javascript | 	this is main file, written in node.js  
| node_modules  |  	folder | folder that contains all node modules needed      
| config.json  |  json | this file contains all the parameters to be save for the plugin.
| Package.json  | json  | 	this file contains description of the plugin and the list of required node dependencies
| Uninstall.sh  | Bash script  | this file contains the script to remove the plugin.    

<p style="background-color: rgba(255, 170, 50, 0.3);padding: 20px;border-left: 5px solid orange; border-radius: 4px;color:rgb(255, 170, 50);">
  CAREFUL: The zip must contain the files in the plugins root folder, NOT the root folder itself!
</p>

Details and examples of mandatories files.
Here you will find more details for each files listed above, what they contain, how to write a working plugin. Examples based on Spop plugin.

#### Install.sh
This file allows download and installation of dependencies for the plugin. It’s a executable file written in BASH.

```bash
#!/bin/bash

echo "Installing Spop Dependencies"
sudo apt-get update
sudo apt-get -y install libasound2-dev libreadline-dev libsox-dev libsoup2.4-dev libsoup2.4-1 libdbus-glib-1-dev libnotify-dev --no-install-recommends



echo "Installing Spop and libspotify"

DPKG_ARCH=`dpkg --print-architecture`

echo $DPKG_ARCH
cd /tmp
wget http://repo.volumio.org/Packages/Spop/spop-${DPKG_ARCH}.tar.gz
sudo tar xvf /tmp/spop-${DPKG_ARCH}.tar.gz -C /
rm /tmp/spop-${DPKG_ARCH}.tar.gz


sudo chmod 777 /etc/spopd.conf

#required to end the plugin install
echo "plugininstallend"

```

IMPORTANT THINGS  TO NOTICE

* Use "echo" to detail what's going during the install, this will help you debugging, and notify the user what goes on during install
* Since we are installing compiled binaries (that need to be compiled for both x86 and armhf, using `dpkg --print-architecture` as part of the file name will ensure an architecture-agnostic script)
* For security reasons dpkg is not allowed, so if you need to install binaries, tar them and download the tar accordingly
* We have no environment variable set, so make sure you cd in the desired folder
* Ensure to give proper permissions to file you'll need to edit later on (node runs with user volumio)
* To avoid installing unwanted stuff, make sure to place `--no-install-recommends` after your to-install list
* `echo "plugininstallend"` must be placed at the end of the install script to signal that installation has ended.

#### Index.js

Index.js
This file is the main file of the plugin. It is written in javascript. Please refer to [index.js section](../Plugin_System/Index.js)  for a detailed explanation.

##### config.json
File in which is saved default parameters, and the way saved parameters will be saved.

```json
{
  "enabled": {
    "type": "boolean",
    "value": false
  },
  "username": {
      "type": "string",
      "value": ""
  },
  "password": {
    "type": "string",
    "value": ""
  },
  "bitrate": {
    "type": "boolean",
    "value": true
  }
}
```

#### package.json
This file contains package description and dependencies
```json
{
  "name": "spop",
  "version": "1.0.0",
  "description": "Spotify plugin for Volumio2",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC",
  "volumio_info": {
    "prettyName": "Spotify",
    "icon": "fa-spotify",
    "plugin_type": "music_service",
    "boot_priority":1
  },
  "dependencies": {
    "fast.js": "^0.1.1",
    "fs-extra": "^0.28.0",
    "kew": "^0.7.0",
    "net": "^1.0.2",
    "nodetools": "^1.0.0",
    "spotify-web-api-node": "^2.3.0",
    "v-conf": "^0.10.0"
  }
}
```

IMPORTANT THINGS  TO NOTICE

The relevant parts are:

* name: this will be the plugin's name folder
* licence: use any licence, you're not bound to GPL here
* dependencies: indicate the node modules this plugin requres, to avoid yourself the extra hassle of 2 different zip files for x86 and ARM, try to choose node modules that don't need to be compiled or rely on external dependencies
* make sure to indicate propery the pretty name, icon and plugin type. The more straightforward, the better
* version, this is used to keep track of version and request for updates if new versions are found
* boot priority, accepts a numerical value from 1 to 10. Useful if you need to start your plugin after one another. 1 means it is started first, 10 means it will be started at last. 

#### Uninstall.sh
Bash file. As install file MUST be executable. Here you will basically revert what you did in the install.sh file .


|  Name |  Format |  Content |  
|---|---|---|
| i18n  | folder  | contains string_en.json and other strings to translate the plugin  
| Uiconfig.json  | json  | this file describe the UI of the plugin.  
| Other   | Text, image, sound, script, executable...  | required file / script to use in the plugin such as executable or service,image, sound,  application key...  
| RequiredConf.json   |  	json | Configuration key or variables mandatory for the plugin to work. Useful to add a new parameter with an update  

Details and examples of optional files
Depending on the plugin, other file may be nedeed.

#### UIConfig.json
This file describes the user interface for the plugin configuration, that will appear while clicking on the cog. Please note that the filename is case sensitive.

Please refer to UI Configuration Pages for reference.

#### I18n
This folder contains languages strings if you want to translate your plugin

You have to have one file per language.

The file naming is “strings_en.json” for english.

Of course replace “en” by the language to be translated “it”, “fr”, “es”.

This is a json file.
```json
{
  "spotify_username":"Spotify username",
  "spotify_password":"Spotify password",
  "high_bitrate":"High quality",
  "search_results":"Number of results",
  "plugins":"Last.fm",
  "last_fm_username":"Last.fm username",
  "last_fm_password":"Last.fm password",
  "SEARCH_SONGS_SECTION":"Spotify songs",
  "SEARCH_ALBUMS_SECTION":"Spotity albums",
  "SEARCH_ARTISTS_SECTION":"Spotify artists"

}
```

#### Other
Your plugin may require other files such as image, sound, executable, configuration files etc… You have to include these files in the ZIP file and ensure proper permissions if they'll need to be edited.
