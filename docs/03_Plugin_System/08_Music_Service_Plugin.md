## Index.js aka the plugin's core for Music Sources Plugins

Music sources requires an extra bit of functions to be hooked properly into Volumio. Basically the need to expose their "browsable" structure of data, allow search and provide a translation for their displayed name on Music Sources. Missing any of those will result in a non working plugin, and possibly a broken Volumio.

Those are:

* addToBrowseSources
* handleBrowseUri
* explodeUri
* search

Optional functions are:

* getTrackInfo

### Folders and Structures

In your plugin you may want to show folders and songs. Volmuio knows several different types that offer different functionalities to the user.

Those types offer the user the opportunity to add it to its favorites or to a playlist by clicking on the burger mneu:

* folder
* song
* playlist

Those types are simply for browsing without additional functionality - the burger menu isn't shown either.

* item-no-menu

Use the type property on the object you are returning the the required and optional functions:

```json
{
  "title": "Spotify result",
  "icon": "fa fa-music",
  "availableListViews": [
    "list", "grid"
  ],
  "items": [
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
```

### Required Functions

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
					lists: [
                    {
                    "title": "Spotify Folders",
                    "icon": "fa fa-folder-open-o",
                    "availableListViews": ["list","grid"],
                    "items": [
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
* The `title` and `icon` attributes are used to divide sections with different content in it, like showing albums and songs for a particular artists. They become separators.
* The `availableListViews` attribute is used to indicate the visualizations options available for this particular list of items. Generally folders, albums and artists have both list and grid views available, while tracks and genres are visualized only in list mode.


GENERIC OUTPUT EXAMPLE:

```json
{
  "navigation": {
    "lists": [
      {
        "title": "Artists",
        "icon": "fa icon",
        "availableListViews": [
          "list",
          "grid"
        ],
        "items": [
          {
            "service": "mpd",
            "type": "song",
            "title": "Led Zeppelin",
            "icon": "fa fa-music",
            "uri": "search://artist/Led Zeppelin"
          }
        ]
      },
      {
        "title": "Webradios",
        "icon": "",
        "availableListViews": [
          "list"
        ],
        "items": [
          {
            "service": "webradio",
            "type": "webradio",
            "title": "ledjam",
            "artist": "",
            "album": "",
            "icon": "fa fa-microphone",
            "uri": "http://yp.shoutcast.com/sbin/tunein-station.m3u?id=492072"
          },
          {
            "service": "webradio",
            "type": "webradio",
            "title": "NAXI 80-e RADIO (NAXI,Belgrade,Serbia, NAXI,Beograd,Srbija) - 128k",
            "artist": "",
            "album": "",
            "icon": "fa fa-microphone",
            "uri": "http://yp.shoutcast.com/sbin/tunein-station.m3u?id=68544"
          }
        ]
      }
    ],
    "prev": {
      "uri": "/"
    }
  }
}
```

EXPECTED RESULTS EXAMPLES:

* Local folders

```json
{
  "navigation": {
    "prev": {
      "uri": "music-library"
    },
    "lists": [
      {
      "availableListViews": ["list","grid"],
      "items": [
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
    ]
  }
}
```

* Local files
```json
{
  "navigation": {
    "prev": {
      "uri": "music-library/USB"
    },
    "lists": [
      {
      "availableListViews": ["list"],
      "items": [
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
    ]
  }
}
```

* Webradios
```json
{
  "navigation": {
    "prev": {
      "uri": "radio/byGenre"
    },
    "lists": [
    {
      "availableListViews": ["list"],
      "items": [
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
    ]
  }
}
```

* Spotify Categories (similar to local folders)
```json
{
  "navigation": {
    "prev": {
      "uri": "spotify"
    },
    "lists": [
    {
      "availableListViews": ["list","grid"],
      "items": [
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
    ]
  }
}
```

* Spotify Songs (streaming plugins)
```json
{
  "navigation": {
    "prev": {
      "uri": "spotify"
    },
    "lists": [
    {
      "availableListViews": ["list"],
      "items": [
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

Every Music Service should provide a search function, but that's not mandatory. A typical search function MUST use promises and return objects formatted exactly like the above browse results. This is what a search backbone look like, where all search results are pushed into a list array and then resolved. Remember to divide search results (like artist, folders etc) with the APIs detailed above (title and icon) and to respect visualization types.

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

As result the following structure is expected:

```json
{
  "title": "Spotify result",
  "icon": "fa fa-music",
  "availableListViews": [
    "list", "grid"
  ],
  "items": [
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
```

### Optional Functions

#### Get Track Info

This method is called by volumio when the user adds e.g. a song to a playlist or to the favorites. 
You have to return a promise that will resolve as soon as you have collected all details about the URI that is passed in as parameter.

The expected format is an array containing the following information - the more you provide, the more the UI can visualize (e.g. if you are missing an albumart you can also use the icon property).

```json
[
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
```

The example code is shown from the YouTube plugin:

```javascript
Youtube.prototype.getTrackInfo = function (uri) {
  var self = this;
  var deferred = libQ.defer();

  if (uri.startsWith('youtube')) {
    var uriParts = uri.split('/');
    var id = uriParts.pop();
    var kind = uriParts.pop();

    switch (kind) {
      case 'playlist':
        self.getPlaylistItems(id).then(function (playlistItems) {
          if (playlistItems.navigation.lists.length > 0
            && playlistItems.navigation.lists[0].items.length > 0) {
            console.log(playlistItems.navigation.lists[0].items)
            deferred.resolve(playlistItems.navigation.lists[0].items);
          } else {
            deferred.reject(new Error('Failed to load playlist info.'));
          }
        });
        break;
      case 'video':
        self.getVideo(id).then(function (videoItems) {
          console.log(JSON.stringify(videoItems));
          if (videoItems.items.length > 0) {
            deferred.resolve(videoItems.items);
          } else {
            deferred.reject(new Error('Failed to load video info.'));
          }
        });
        break;
      default:
        self.logger.error("Youtube::getTrackInfo unknown uri kind: " + kind);
        deferred.reject(new Error('Unknown uri kind ' + kind));
        break;
    }

  } else {
    self.logger.info("Youtube::getTrackInfo unknown uri: " + uri);
    deferred.reject(new Error('Unknown uri ' + uri));
  }

  return deferred.promise;
}
```
