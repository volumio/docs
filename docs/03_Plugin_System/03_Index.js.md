### Index.js aka the plugin's core

The index.js file of every plugin is where the magic goes on. It has some predefined and mandatory functions and a standardized layout. Depending on you'r plugin's category, this structure needs to change accordingly. We'll start by detailing a generic plugin structure.

### Generic structure

The first part is about module dependencies, we'll need to list all the node modules our plugin depends on (example taken from Spotify plugin).

```javascript
'use strict';

var libQ = require('kew');
var libNet = require('net');
var libFast = require('fast.js');
var fs=require('fs-extra');
var config = new (require('v-conf'))();
var exec = require('child_process').exec;
var SpotifyWebApi = require('spotify-web-api-node');
var nodetools = require('nodetools');
```

IMPORTANT TIPS:
* Node modules allow you to develop faster, by relaying on already-written code to overcome the majority of tasks, to look for them [search here](https://www.npmjs.com/package/package)
* The `'use strict';` declaration at the beginning will ensure no obvious coding mispractices will happen, [more info on the matter](http://www.w3schools.com/js/js_strict.asp)
* Use the minimum amount of modules needed, and try to avoid modules that needs compilation (you will spot those because they'll take longer on npm install), so you will avoid to mantain two separate versions for x86 and arm architectures.

Then we will define the plugin class and reference to other core Volumio's internals:

```javascript
module.exports = ControllerSpop;
function ControllerSpop(context) {
	// This fixed variable will let us refer to 'this' object at deeper scopes
	var self = this;

	this.context = context;
	this.commandRouter = this.context.coreCommand;
	this.logger = this.context.logger;
	this.configManager = this.context.configManager;

}
```
IMPORTANT TIPS:
* Substitute `ControllerSpop` with something that resembles your plugin name. For example `ControllerGPIO` or `ControllerSoundcloud`
* We'll start every prototype (see later) with this Controller naming


Then we add all the required functions for a generic plugin:


#### On Volumio Start

This is the code that gets executed when Volumio starts and triggers the plugin start. Typically, what you do is load the plugin configuration.

```javascript
ControllerSpop.prototype.onVolumioStart = function()
{
	var configFile=this.commandRouter.pluginManager.getConfigurationFile(this.context,'config.json');
	this.config = new (require('v-conf'))();
	this.config.loadFile(configFile);

}
```

#### On Start

This instead is what happens when the Plugin starts. It's different from On Volumio Start since this function is triggered only if the plugin is enabled. In this case we're starting the spop daemon (responsible for Spotify Playback).

```javascript
ControllerSpop.prototype.onStart = function() {
	var self = this;

	var defer=libQ.defer();

	self.startSpopDaemon()
		.then(function(e)
		{
			setTimeout(function () {
				self.logger.info("Connecting to daemon");
				self.spopDaemonConnect(defer);
			}, 5000);
		})
		.fail(function(e)
		{
			defer.reject(new Error());
		});
	this.commandRouter.sharedVars.registerCallback('alsa.outputdevice', this.rebuildSPOPDAndRestartDaemon.bind(this));

	return defer.promise;
};
```
IMPORTANT:

* You'll notice that we use promises here. That's why Volumio needs to know when the plugin has actually started, or if it failed. So what we're doing is returning the promise on successful start, and rejecting it if it doesn't start properly.
* The strange function  `this.commandRouter.sharedVars.registerCallback('alsa.outputdevice', this.rebuildSPOPDAndRestartDaemon.bind(this));` does one important thing. It binds to a shared system value (alsa.outputdevice, which is the output device) and when it changes it triggers the function `rebuildSPOPDAndRestartDaemon` that rewrites spop config file and restarts it.

#### On stop

When a plugin is stopped, this function gets executed. What we're doing here is killing the spop daemon.

```javascript
ControllerSpop.prototype.onStop = function() {
	var self = this;

	self.logger.info("Killing SpopD daemon");
	exec("killall spopd", function (error, stdout, stderr) {

	});

	return libQ.defer();
};
```

#### Get Configuration files

Very straightforwarding, we load the .json configuration file for this plugin.

```javascript
ControllerSpop.prototype.getConfigurationFiles = function()
{
	return ['config.json'];
}
```

#### Get UI configuration

This function is triggered when we want to access the plugin configuration. For a better understanding of the configuration pages see [Configuration Pages ](../Plugin_System/UI_Configuration_Pages)

```javascript
ControllerSpop.prototype.getUIConfig = function() {
	var defer = libQ.defer();
	var self = this;

	var lang_code = this.commandRouter.sharedVars.get('language_code');

	self.commandRouter.i18nJson(__dirname+'/i18n/strings_'+lang_code+'.json',
		__dirname+'/i18n/strings_en.json',
		__dirname + '/UIConfig.json')
		.then(function(uiconf)
		{

			uiconf.sections[0].content[0].value = self.config.get('username');
			uiconf.sections[0].content[1].value = self.config.get('password');
			uiconf.sections[0].content[2].value = self.config.get('bitrate');

			defer.resolve(uiconf);
		})
		.fail(function()
		{
			defer.reject(new Error());
		});

	return defer.promise;
};

```

IMPORTANT:
* With `var lang_code = this.commandRouter.sharedVars.get('language_code');` we retrieve the current language code. If translation is provided under the `/i18n/` folder, we'll translate the configuration page, if not we'll default to english.
* We use promises here as well, since it will take some time to parse the UIConfig.json and translate it. Not using promises will result in configuration not working.
* With `uiconf.sections[0].content[0].value = self.config.get('username');` we're simply subsituting the first element's value of the first section with the `username` value taken from the plugins configuration.  That's how we can populate the UI Configuration Page with actual values.

### Optional functions for generic plugins


#### Get configuration from other plugins

There are cases where we want to get configuration parameters from other plugins, for example to know if an i2s DAC has been enabled or not. We will then use the `executeOnPlugin` method which will allow us to execute any method on any plugin. For code clarity we wrapped it into the `getAdditionalConf` function, accepting 3 parameters which are mandatory for the aforementioned `executeOnPlugin`:

* TYPE (plugin category)
* CONTROLLER (plugin name)
* DATA (the configuration parameter we want to get)

Please note that the function to get config parameters is not always `getConfigParam` but could be also just `getConf`. Check the individual plugin to see which is the correct function.

```javascript
ControllerAlsa.prototype.getAdditionalConf = function (type, controller, data) {
	var self = this;
	return self.commandRouter.executeOnPlugin(type, controller, 'getConfigParam', data);
};
```

#### Set configuration from other plugins

Same as above, also here `setConfigParam`could be also `setConf` or `setUiConfig`. Check the individual plugin to see which is the correct function.

```javascript
UpnpInterface.prototype.setAdditionalConf = function () {
	var self = this;

	return self.commandRouter.executeOnPlugin(type, controller, 'setConfigParam', data);
};
```

#### Restart

Sometimes it might be useful to have a function to restart the plugin. Here's an example for upnp interface in Volumio.

```javascript
UpnpInterface.prototype.onRestart = function () {
	var self = this;

	exec('/usr/bin/sudo /usr/bin/killall upmpdcli', function (error, stdout, stderr) {
		if (error) {
			self.logger.error('Cannot kill upmpdcli '+error);
		} self.startUpmpdcli();
	});
};
```

### Mandatory Functions for Music Sources Plugin

Music sources requires an extra bit of functions to be hooked properly into Volumio. Basically the need to expose their "browsable" structure of data, allow search and provide a translation for their displayed name on Music Sources. Missing any of those will result in a non working plugin, and possibly a broken Volumio.

Those are:

* addToBrowseSources
* handleBrowseUri
* explodeUri
* search

#### Add to Browse sources

This functions adds the new music source to Main Browse Menu.
Rules to Follow:

* Invoke this function ONLY when the plugin starts properly, and if you're relying on a daemon only when successful connection has been established with the daemon and the service.
* Every call to the `uri` specified here, will be handled by this plugin. Basically, when clicking "Spotify", we'll handle the request in this plugin via the function and return the sub-categories available. Those will be handled by the `handleBrowseUri` function later on.

```javascript
ControllerSpop.prototype.addToBrowseSources = function () {
	var data = {name: 'Spotify', uri: 'spotify',plugin_type:'music_service',plugin_name:'spop'};
	this.commandRouter.volumioAddToBrowseSources(data);
};
```
#### Handle Browse uri

This function is responsible to interpret the desired URI (basically the browse point requested) and return the available items. Some examples:

* Webradios browsing:

```javascript
ControllerWebradio.prototype.handleBrowseUri=function(curUri)
{
    var self=this;
    var response;

    if (curUri.startsWith('radio')) {
        if (curUri == 'radio')
            response = self.listRoot(curUri);
        else {
            if (curUri.startsWith('radio/myWebRadio')) {
                response = self.listMyWebRadio(curUri);
            }
            if (curUri.startsWith('radio/byGenre')) {
                if (curUri == 'radio/byGenre')
                    response = self.listRadioGenres(curUri);
                else
                    response = self.listRadioForGenres(curUri);
            }
            if (curUri.startsWith('radio/favourites')) {
                response = self.listRadioFavourites(curUri);
            }
             if (curUri==='radio/top500') {
                    response = self.listTop500Radios(curUri);
            }
             else if (curUri.startsWith('radio/byCountry')) {
                 if (curUri == 'radio/byCountry')
                     response = self.listRadioCountries(curUri);
                 else
                     response = self.listRadioForCountry(curUri);

             }
        }
    }

    return response;
}
```
* Music Library and playlist browsing:

```javascript
ControllerMpd.prototype.handleBrowseUri = function (curUri) {
    var self = this;

    var response;

    if (curUri.startsWith('music-library')) {
        response = self.lsInfo(curUri);
    }else if (curUri.startsWith('playlists')) {
        if (curUri == 'playlists')
            response = self.listPlaylists(curUri);
        else response = self.browsePlaylist(curUri);
    }

    return response;
};

```

* Spotify browsing

```javascript
ControllerSpop.prototype.handleBrowseUri=function(curUri)

{
	var self=this;

	//self.commandRouter.logger.info(curUri);
	var response;

	if (curUri.startsWith('spotify')) {
		if(curUri=='spotify')
		{
			response=libQ.resolve({
				navigation: {
					prev: {
						uri: 'spotify'
					},
					list: [
						{
							service: 'spop',
							type: 'folder',
							title: 'My Playlists',
							artist: '',
							album: '',
							icon: 'fa fa-folder-open-o',
							uri: 'spotify/playlists'
						},
						{
							service: 'spop',
							type: 'folder',
							title: 'Featured Playlists',
							artist: '',
							album: '',
							icon: 'fa fa-folder-open-o',
							uri: 'spotify/featuredplaylists'
						},
						{
							service: 'spop',
							type: 'folder',
							title: 'What\'s New',
							artist: '',
							album: '',
							icon: 'fa fa-folder-open-o',
							uri: 'spotify/new'
						},
						{
							service: 'spop',
							type: 'folder',
							title: 'Genres & Moods',
							artist: '',
							album: '',
							icon: 'fa fa-folder-open-o',
							uri: 'spotify/categories'
						}
					]
				}
			});
		}
		else if(curUri.startsWith('spotify/playlists'))
		{
			if(curUri=='spotify/playlists')
				response=self.listPlaylists();
			else
			{
				response=self.listPlaylist(curUri);
			}
		}
		else if(curUri.startsWith('spotify/featuredplaylists'))
		{
			response=self.featuredPlaylists(curUri);
		}
		else if(curUri.startsWith('spotify/webplaylist'))
		{
			response=self.listWebPlaylist(curUri);
		}
		else if(curUri.startsWith('spotify/new'))
		{
			response=self.listWebNew(curUri);
		}
		else if(curUri.startsWith('spotify/categories'))
		{
			response=self.listWebCategories(curUri);
		}
		else if(curUri.startsWith('spotify/album'))
		{
			response=self.listWebAlbum(curUri);
		}
		else if(curUri.startsWith('spotify/category'))
		{
			response=self.listWebCategory(curUri);
		}
		else if(curUri.startsWith('spotify:artist:'))
		{
			response=self.listWebArtist(curUri);
		}
	}

	return response;
};
```

BEST PRACTICES:
* Hardcode all expected uris, and handle errors in case you receive an unknown one
* Use separate functions for every uri tpye
* Use promises where possible
* If you use an external API service with API limits, cache where possible.
* Navigation is nested, so make sure you provide the upper level (needed for going back while browsing)
* You can display an icon by using `icon` and using a  [font-awesome icon](http://fontawesome.io/icons/)
* You can display an image by using `albumart`, you can then pass a direct url or use the Albumart Server
* The albumart API is: `/albumart?web=artist/album/large&path=path` all encoded which becomes `/albumart?web=Alabama%20Shakes/Sound%20%26%20Color/large&path=%2FUSB%2FALABAMA%20SHAKES%20S%20%26%20C`

EXPECTED RESULTS:

* Local folders

```
{
  "navigation": {
    "prev": {
      "uri": "music-library"
    },
    "list": [
      {
        "type": "folder",
        "title": "Calibro 35 (2008)",
        "icon": "fa fa-folder-open-o",
        "uri": "music-library/USB/Calibro 35 (2008)"
      },
      {
        "type": "folder",
        "title": "In Sight",
        "icon": "fa fa-folder-open-o",
        "uri": "music-library/USB/In Sight"
      }
    ]
  }
}
```

* Local files
```
{
  "navigation": {
    "prev": {
      "uri": "music-library/USB"
    },
    "list": [
      {
        "service": "mpd",
        "type": "song",
        "title": "Sound & Color",
        "artist": "Alabama Shakes",
        "album": "Sound & Color",
        "icon": "fa fa-music",
        "uri": "music-library/USB/ALABAMA SHAKES S & C/01 Sound & Color.mp3"
      },
      {
        "service": "mpd",
        "type": "song",
        "title": "Don't Wanna Fight",
        "artist": "Alabama Shakes",
        "album": "Sound & Color",
        "icon": "fa fa-music",
        "uri": "music-library/USB/ALABAMA SHAKES S & C/02 Don't Wanna Fight.mp3"
      }
    ]
  }
}
```

* Webradios
```
{
  "navigation": {
    "prev": {
      "uri": "radio/byGenre"
    },
    "list": [
      {
        "service": "webradio",
        "type": "webradio",
        "title": "Oldies FM",
        "artist": "",
        "album": "",
        "icon": "fa fa-microphone",
        "uri": "http://yp.shoutcast.com/sbin/tunein-station.m3u?id=728640"
      },
      {
        "service": "webradio",
        "type": "webradio",
        "title": "San Francisco's 70's HITS!",
        "artist": "",
        "album": "",
        "icon": "fa fa-microphone",
        "uri": "http://yp.shoutcast.com/sbin/tunein-station.m3u?id=1087995"
      }
    ]
  }
}
```

* Spotify Categories (similar to local folders)
```
{
  "navigation": {
    "prev": {
      "uri": "spotify"
    },
    "list": [
      {
        "service": "spop",
        "type": "folder",
        "title": "My Playlists",
        "artist": "",
        "album": "",
        "icon": "fa fa-folder-open-o",
        "uri": "spotify/playlists"
      },
      {
        "service": "spop",
        "type": "folder",
        "title": "Featured Playlists",
        "artist": "",
        "album": "",
        "icon": "fa fa-folder-open-o",
        "uri": "spotify/featuredplaylists"
      }
    ]
  }
}
```

* Spotify Songs (streaming plugins)
```
{
  "navigation": {
    "prev": {
      "uri": "spotify"
    },
    "list": [
      {
        "service": "spop",
        "type": "song",
        "title": "Vienna",
        "artist": "Thom Sonny Green",
        "album": "High Anxiety",
        "albumart": "https://i.scdn.co/image/dac9ef993de0a5758cc6e655080306d40814edc9",
        "uri": "spotify:track:5cgSWdlxIelg5N9OjfkRow"
      },
      {
        "service": "spop",
        "type": "song",
        "title": "40 Beers",
        "artist": "Thom Sonny Green",
        "album": "High Anxiety",
        "albumart": "https://i.scdn.co/image/dac9ef993de0a5758cc6e655080306d40814edc9",
        "uri": "spotify:track:2r6oZ0GBqJaCnqqR72yiFc"
      }
    ]
  }
}

```
#### Explode uri

This function takes care of retrieving all informations related to a particular URI, it's needed both by queue and state machine. Some examples:



* Local files (MPD)

```javascript
ControllerMpd.prototype.explodeUri = function(uri) {
    var self = this;

    var defer=libQ.defer();

    var items = [];
    var cmd = libMpd.cmd;

    if(uri.startsWith('search://'))
    {
        //exploding search
        var splitted=uri.split('/');

        var argument=splitted[2];
        var value=splitted[3];

        if(argument==='artist')
        {
            var commandArtist = 'search artist '+' "' + value + '"';

            self.mpdReady.then(function () {
                self.clientMpd.sendCommand(cmd(commandArtist, []), function (err, msg) {
                    var subList=[];

                    if (msg) {
                        var lines = msg.split('\n');
                        for (var i = 0; i < lines.length; i++) {
                            var line = lines[i];

                            if (line.startsWith('file:')) {
                                var path = line.slice(5).trimLeft();
                                var name = path.split('/');
                                var count = name.length;

                                var artist = self.searchFor(lines, i + 1, 'Artist:');
                                var album = self.searchFor(lines, i + 1, 'Album:');
                                var title = self.searchFor(lines, i + 1, 'Title:');
                                var time = parseInt(self.searchFor(lines, i + 1, 'Time:'));

                                if (title) {
                                    title = title;
                                } else {
                                    title = name;
                                }

                                items.push({
                                    uri: 'music-library/'+path,
                                    service: 'mpd',
                                    name: title,
                                    artist: artist,
                                    album: album,
                                    type: 'track',
                                    tracknumber: 0,
                                    albumart: self.getAlbumArt({artist:artist,album: album},uri),
                                    duration: time,
                                    trackType: 'mp3'
                                });
                            }

                        }

                        defer.resolve(items);
                    }
                    else if(err)  defer.reject(new Error('Artist:' +err));
                    else defer.resolve(items);
                });
            });
        }
        else if(argument==='album')
        {
            var commandAlbum = 'search album '+' "' + value + '"';

            self.mpdReady.then(function () {
                self.clientMpd.sendCommand(cmd(commandAlbum, []), function (err, msg) {
                    var subList=[];

                    if (msg) {

                        var lines = msg.split('\n');
                        for (var i = 0; i < lines.length; i++) {
							var line = lines[i];

                            if (line.startsWith('file:')) {
                                var path = line.slice(5).trimLeft();
                                var name = path.split('/');
                                var count = name.length;

                                var artist = self.searchFor(lines, i + 1, 'Artist:');
                                var album = self.searchFor(lines, i + 1, 'Album:');
                                var title = self.searchFor(lines, i + 1, 'Title:');
                                var time = parseInt(self.searchFor(lines, i + 1, 'Time:'));

                                if (title) {
                                    title = title;
                                } else {
                                    title = name;
                                }

                                items.push({
                                    uri: 'music-library/' + path,
                                    service: 'mpd',
                                    name: title,
                                    artist: artist,
                                    album: album,
                                    type: 'track',
                                    tracknumber: 0,
                                    albumart: self.getAlbumArt({artist: artist, album: album}, uri),
                                    duration: time,
                                    trackType: 'mp3'
                                });
                            }
                        }
                        defer.resolve(items);
                    }
                    else if(err)  defer.reject(new Error('Artist:' +err));
                    else defer.resolve(items);
                });
            });
        }
        else defer.reject(new Error());
    }
    else {
        var uriPath='/mnt/'+self.sanitizeUri(uri);
        self.commandRouter.logger.info('----------------------------'+uriPath);
        var uris=self.scanFolder(uriPath);
        var response=[];

        libQ.all(uris)
            .then(function(result)
            {
                for(var j in result)
                {

                    self.commandRouter.logger.info("----->>>>> "+JSON.stringify(result[j]));

                    if(result!==undefined && result[j].uri!==undefined)
                    {
                        response.push({
                            uri: self.fromPathToUri(result[j].uri),
                            service: 'mpd',
                            name: result[j].name,
                            artist: result[j].artist,
                            album: result[j].album,
                            type: 'track',
                            tracknumber: result[j].tracknumber,
                            albumart: result[j].albumart,
                            duration: result[j].duration,
                            samplerate: result[j].samplerate,
                            bitdepth: result[j].bitdepth,
                            trackType: result[j].trackType
                        });
                    }

                }

                defer.resolve(response);
            }).fail(function(err)
        {
            self.commandRouter.logger.info("explodeURI: ERROR "+err);
            defer.resolve([]);
        });
    }

    return defer.promise;
};

```

* Webradio

```javascript
ControllerWebradio.prototype.explodeUri = function(uri) {
    var self = this;

    var defer=libQ.defer();

    defer.resolve({
        uri: uri,
        service: 'webradio',
        name: uri,
        type: 'track'
    });

    return defer.promise;
};
```

#### Search

Every Music Service should provide a search function, but that's not mandatory. A typical search function MUST use promises and return objects formatted exactly like the above browse results. This is what a search backbone look like, where all search results are pushed into a list array and then resolved.

```javascript
ControllerSpop.prototype.search = function (query) {

	var self=this;

	var defer=libQ.defer();

  defer.resolve(list);


  			}, function (err) {
  				self.logger.info('An error occurred while searching ' + err);
  			});
  		});

  	return defer.promise;
```
