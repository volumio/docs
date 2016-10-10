## Introduction

The most used API transport in Volumio2 is its Websockets API as it allows almost real time communication with multiple clients. Volumio's WebUI gets and sends data (almost) exclusively via WS. Volumio's WS layer is powered by [Socket.io](http://socket.io/).
The WebSocket API interface is located at: https://github.com/volumio/Volumio2/blob/master/app/plugins/user_interfaces/websocket/index.js

## Scenarios

Websocket communication in Volumio is identifiable in the most basic server/client architecture. The Server is Volumio itself (aka the host where Volumio is running), the client can be one or more WebUIs or other consumers (Apps and so on). In some cases, Volumio hosts can also act as client, to communicate with other hosts on the same network.

## Events
Socket.io allows to invoke events triggered by other events, emit and receive communications (on its most basic implementation). As an example, defining which event should be invoked on a client connection  looks like:

```js
self.libSocketIO.on('connection', function (connWebSocket) {
  // use connWebSocket here
});
```

This way, we can define what event should be triggered when a particular message is received:

```js
connWebSocket.on('bringmepizza', function () {
  givehimpizza();
});
```

Typically, every message we send or receive to Volumio's Backend will have this structure:

```js
io.emit('message','data');
```

Where message can be for example "play" and data can be the song number.
A good policy for sending data on emits is to configure them as objects: they're easier to parse and easily extendable.
So our message can be:

```js
io.emit('addToPlaylist', {"name": "Music", "service": "mpd", "uri": "music-library/..."});
```
## Events Documentation

### Basic Playback Commands
```
**Play:** play
**Pause:** pause
**Stop:** stop
**Previous:** previous
**Next:** next
**Seek** seek N (N is the time in seconds that the playback will keep)
**Random** setRandom(true|false)
**repeat** setRepeat(true|false)
```

### Get Player State

```
GetState
```

Reply:
```json
{"status":"play",
"position":"0",
"title":"Macaco",
"artist":"Paolo Conte",
"album":"Paolo Conte",
"albumart":"http://img2-ak.lst.fm/i/u/300x300/1b82dd5e54554209bf2326ffb76f6814.png",
"seek":"25390",
"duration":"146",
"samplerate":"44100",
"bitdepth":"16",
"channels":"2",
"volume":"100",
"mute":"false",
"service":"mpd"}

```

Where

* **status** is the status of the player
* **position** is the position in the play queue of current playing track (if any)
* **title** is the item's title
* **artist** is the item's artist
* **album** is the item's album
* **albumart** the URL of AlbumArt (via last.fm APIs)
* **seek** is the item's current elapsed time
* **duration** is the item's duration, if any
* **samplerate** current samplerate
* **bitdepth** bitdepth
* **channels** mono or stereo
* **volume** current Volume
* **mute** if true, Volumio is muted
* **service** current playback service (mpd, spop...)

### Search

```
search {value:'query'}
```

Where query is my search query. (note that for using live search, DO NOT send queries with less than 3 characters, they will dramatically slow search operations).

### Volume
Set to percentage, raise or lower, mute or unmute.

Message: *volume*

Data:

* numeric value between 0 and 100
* *mute*
* *umute*
* *+*
* *-*

**Example**
```
io.emit('volume', 90);
io.emit('volume', '+');
```

### Mute
Message: *mute*

**Example**
```
io.emit('mute', '');
```

### Unmute
Message: *unmute*

**Example**
```
io.emit('unmute', '');
```

### Multiroom
```
getMultiRoomDevices
```

Retrieves all devices connected to the same network.
Input: None

Output (through pushMultiRoomDevices socket.io event):

```json
   {
      "misc": {"debug": true},
      "list": [
         {
				"id":"uuid",
				"host":"",
				"name":"",
				"isSelf":true|false,
				"state": {
					"status": "",
					"volume": 0,
					"mute": true|false,
					"artist": "",
					"track": ""
				},
                                {
				"id":"uuid",
				"host":"",
				"name":"",
				"isSelf":true|false,
				"state": {
					"status": "",
					"volume": 0,
					"mute": true|false,
					"artist": "",
					"track": ""
				}
      ]
   }
```



### Browse Music Library

```
browseLibrary objBrowseParameters
```

Where `objBrowseParameters` are the parameters we want to dig into. This returns the desired level in the music library along with navigation and pagination informations.

```js
{
  navigation: {
    prev: {
      uri: ''
    },
    list: [
      {service: 'mpd', type: 'song',  title: 'track a', artist: 'artist a', album: 'album', icon: 'music' uri: 'uri'},
      {type: 'folder',  title: 'folder a', icon: 'folder-open-o' uri: 'uri'},
      {type: 'folder',  title: 'folder b', albumart: '//ip/image' uri: 'uri2'},
      {type: 'playlist',  title: 'playlist', icon: 'bars' uri: 'uri4'}
    ]
  }
}
```

The browsable items can be;

- Track
- Folder (can also be a category)
- Playlist

Their parameters are:

- Type: track, folder, category
- Title: If this is a song: title, if folder or category is their name.
- Artist and Album: used only if the type is song
- Icon or image: Select the icon to display (naming of [Font-Awesome](https://fortawesome.github.io/Font-Awesome/icons/) ) , or image (URL served by Volumio Backend or external service)
- Uri: Uri

### Get Music Library Available filters

```
getBrowseFilters
```

This returns available filters (browse by)

```js
{name:'Genres by Name', index: 'index:Genres by Name'},
{name:'Artists by Name', index: 'index:Artists by Name'},
{name:'Albums by Name', index: 'index:Albums by Name'},
{name:'Albums by Artist', index: 'index:Albums by Artist'},
{name:'Tracks by Name', index: 'index:Tracks by Name'}
```

### Get Music Sources
```
getBrowseSources
```

This returns a list of available Music Sources

```js
{name:'USB', uri: 'usb'},
{name:'NAS', uri: 'nas'},
{name:'Web Radio', uri: 'web-radio'},
{name:'Spotify', uri: 'spotify'}
```

### Custom Browse Source

This can be useful when creating a new plugin, to inject custom views in the browse sources panel, along with top-level custom actions.
```js
{
  "name": "Custom Source",
  "pluginName": "streaming_controller",
  "pluginType": "music_service",
  "uri": "stream",
  "info": "Additional info",
  "menuItems": [
    {
      "name": "play",
      "socketCall": {
        "emit": "callMethod",
        "payload": {
          "endpoint": "music_service/streaming_controller",
          "method": "launchStream",
          "data": ""
        }
      }
    },
    {
      "name": "rip",
      "socketCall": {
        "emit": "callMethod",
        "payload": {
          "endpoint": "music_service/streaming_controller",
          "method": "updateStream",
          "data": ""
        }
      }
    },
    {
      "name": "eject",
      "socketCall": {
        "emit": "callMethod",
        "payload": {
          "endpoint": "music_service/streaming_controller",
          "method": "refreshStream",
          "data": ""
        }
      }
    }
  ]}
```

### Get Current Play Queue

```
GetQueue
```

The queue is a json object:
```js
[ { uri: 'NAS/Flac/Paolo Conte - 1984 - Paolo Conte [1995 Reissue]/10 - Macaco.flac',
    service: 'mpd',
    name: 'Macaco',
    artist: 'Paolo Conte',
    album: 'Paolo Conte',
    type: 'track',
    tracknumber: '0',
    albumart: 'http://img2-ak.lst.fm/i/u/300x300/1b82dd5e54554209bf2326ffb76f6814.png' },
  { uri: 'NAS/Flac/Paolo Conte - 1984 - Paolo Conte [1995 Reissue]/01 - Sparring Partner.flac',
    service: 'mpd',
    name: 'Sparring partner',
    artist: 'Paolo Conte',
    album: 'Paolo Conte',
    type: 'track',
    tracknumber: '1',
    albumart: 'http://img2-ak.lst.fm/i/u/300x300/1b82dd5e54554209bf2326ffb76f6814.png' }]
```


### Remove Item from queue

```
removeFromQueue N
```

where `N` is the track number in the queue, 0 for the first, 9 for the tenth and so on

### Add Item to Queue

```
addToQueue {'uri:uri'}
```

where `uri` is the uri of the item we want to add

If we want to add an individual track from a .cue file:

```
addPlayCue {uri:'uriofsong',number:3}
```

### Playlist handling

```
createPlaylist
deletePlaylist {value:playlistname}
listPlaylist
addToPlaylist
removeFromPlaylist
playPlaylist
enqueue
```

#### createPlaylist

This method creates a new playlist

Input:

```json
   {
    "name":"myplaylist"
   }
```

Output:

```json
   {
    "success":true|false
    "reason":"failure details"
   }
```

The reason field is set only if success is false

#### deletePlaylist

This method deletes a playlist

Input:

```json
   {
    "name":"myplaylist"
   }
```

Output:

```json
   {
    "success":true|false
    "reason":"failure details"
   }
```

The reason field is set only if success is false

#### listPlaylist

This method lists all playlists in the system

Input: None

Output (through event pushListPlaylist):

```json
   [
     "playlistA",
     "playlistB",
     ...
   ]
```

The reason field is set only if success is false

#### addToPlaylist

This method adds a song to an existing playlist

Input:

```json
   {
    "name":"my playlist",
    "service":"mpd",
    "uri":"USB/..."
   }
```

Output:

```json
   {
    "success":true|false
    "reason":"failure details"
   }
```

The reason field is set only if success is false

#### removeFromPlaylist

This method removes all occurrences of a song from an existing playlist

Input:

```json
   {
    "name":"my playlist",
    "uri":"USB/..."
   }
```

Output:

```json
   {
    "success":true|false
    "reason":"failure details"
   }
```

The reason field is set only if success is false

#### playPlaylist

This method clears the queue, adds the playlist and play

Input:

```json
   {
    "name":"my playlist"
   }
```

Output:

```json
   {
    "success":true|false
    "reason":"failure details"
   }
```

The reason field is set only if success is false

#### enqueue

This method enqueue all songs of a playlist

Input:

```json
   {
    "name":"my playlist"
   }
```

Output:

```json
   {
    "success":true|false
    "reason":"failure details"
   }
```

The reason field is set only if success is false



### CallMethod on Plugin

Each method of a plugin can be execute through a websocket call. As of now there's no ACL or any security feature but thi s will change in the future. To execute a method the following socket.io command shall be issued:

```
callMethod
```

The payload shall be a json with the following structure:
```json
   {
    "endpoint":"category/name",
    "method":"methodName",
    "data": {}
   }
```

where:

* **endpoint** is a string used to target the plugin. Its structure is a linux path like string containing the plugin category, a slash and the plugin name. An example: endpoint:'music_service/spop'.
* **method** is a string containing the name of the method to be executed.
* **data** is a complex value (can be a string or a  Json) and is passed as is to the method.

**IMPORTANT:** There should be no "-" in this call, due to FE parsing method (it converts / to -). So plugins and functions should not contain "-".

Once the method returns, the result is pushed back to the client with the event 'pushMethod'.

## Miscellaneous

### Sleep & Alarm Clock

```
getSleep
```

Triggers :

```
pushSleep {enabled:true|false, time:hh:mm:}
```

To set sleep mode:

```
setSleep {enabled:true|false, time:hh:mm:}
```

```
getAlarms
```

Triggers:

```
pushAlarms {[{id:1,enabled:true, time:hh:mm, playlist:uriplaylist},{id:2,enabled:true, time:hh:mm, playlist:uriplaylist}]}
```

To add a new alarm:

```
addAlarm {time:hh:mm, playlist:uriplaylist}
```
When a new Playlist gets added, the Values enabled:true and id (as progressive numbering) are added by default by the Backend.

To edit an alarm:

```
setAlarm {id:1,enabled:true, time:hh:mm, playlist:uriplaylist}
```
Those values will replace the values of the correspondent playlist id.

To remove an alarm:

```
removeAlarm {id:3}
```
