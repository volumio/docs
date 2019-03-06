## Rest API

Some commands may be invoked using Rest_api interface.

From a device on the same network, you can use

```
curl volumio.local/api/v1/commands/mycommand

```

Where _volumio.local_ is the device to be reached. You can also use the IP adress instead.

From the device itself (via a keyboard plugged on it or through [SSH](https://volumio.github.io/docs/User_Manual/SSH.html)), use :

```
curl localhost:3000/api/v1/commands/mycommand

```
And of course, _mycommand_ is to be replaced by the command to be used. (see below)


## Available commands

### Playback commands

All API calls will look like:

```
volumio.local/api/v1/commands/?cmd=
```

example:

```
volumio.local/api/v1/commands/?cmd=play
```

Available commands:

* Play
```
volumio.local/api/v1/commands/?cmd=play&N=2
```
where N is optional and is the ordinal number of the track in the queue you wish to start to play from. The above call will play the third track in the queue.

* Toggle between play and pause
```
volumio.local/api/v1/commands/?cmd=toggle
```
* Stop
```
volumio.local/api/v1/commands/?cmd=stop
```

* Pause
```
volumio.local/api/v1/commands/?cmd=pause
```

* Previous
```
volumio.local/api/v1/commands/?cmd=prev
```

* Next
```
volumio.local/api/v1/commands/?cmd=next
```

* Volume
```
volumio.local/api/v1/commands/?cmd=volume&volume=80
```
where volume can be: mute, unmute, plus, minus (plus and minus will increase\decrease as per parameter one click volume steps)

### Music Library

* Get the current state of the player
```
volumio.local/api/v1/getstate
```

Response
```json
{"status":"play","position":0,"title":"La guerra è finita","artist":"Baustelle","album":"La malavita","albumart":"/albumart?web=Baustelle/La%20malavita/extralarge&path=%2FNAS%2FMusic%2FBaustelle%20-%20La%20Malavita","uri":"mnt/NAS/Music/Baustelle - La Malavita/02 la guerra è finita.mp3","trackType":"mp3","seek":4224,"duration":262,"samplerate":"44.1 KHz","bitdepth":"24 bit","channels":2,"random":null,"repeat":null,"repeatSingle":false,"consume":false,"volume":41,"mute":false,"stream":"mp3","updatedb":false,"volatile":false,"service":"mpd"}
```

* Clear the queue
```
volumio.local/api/v1/commands/?cmd=clearQueue
```

* List Playlists
```
volumio.local/api/v1/listplaylists
```
* Play a Playlist
```
volumio.local/api/v1/commands/?cmd=playplaylist&name=Rock
```
Where name is the name of the playlist to play

* Repeat a track
```
volumio.local/api/v1/commands/?cmd=repeat&value=key
```
Where key is _true_ or _false_

* Random Makes the order in which tracks are played random
```
volumio.local/api/v1/commands/?cmd=random&value=key
```
Where key is _true_ or _false_

### Backup

This is the generic command to retrieve a json with the playlist selected in type.
Allowed types are:
* "playlist" replies with custom playlists, sorted by their names.
* "favourites" replies with the playlist of favorites songs.
* "radio-favourites" replies with the playlist of favorites radios.
* "my-web-radio" replies with the playlist of custom radios.

```
volumio.local/api/v1/backup/playlists/:type
```

Reply:

```
[
  {
    "service": "webradio",
    "uri": "http://yp.shoutcast.com/sbin/tunein-station.m3u?id=893796",
    "title": "Dance Wave!",
    "icon": "fa-microphone"
  },
  {
    "service": "webradio",
    "uri": "http://yp.shoutcast.com/sbin/tunein-station.m3u?id=832669",
    "title": "Radio Sobsomoy",
    "icon": "fa-microphone"
  },
  {
    "service": "webradio",
    "uri": "http://yp.shoutcast.com/sbin/tunein-station.m3u?id=862132",
    "title": "ANTENA1 - 94 7 FM",
    "icon": "fa-microphone"
  },
  {
    "service": "webradio",
    "uri": "http://yp.shoutcast.com/sbin/tunein-station.m3u?id=344030",
    "title": "U1 Tirol",
    "icon": "fa-microphone"
  }
]
```
This is an example of volumio.local/api/v1/backup/playlists/radio-favourites.


This is the generic command to retrieve a json with the configurations of every plugin, with their status, sorted by category.

```
volumio.local/api/v1/backup/config/
```
Reply:
```
[
  {
    "cName": "system_controller",
    "plugConf": [
      {
        "name": "updater_comm",
        "status": true,
        "config": ""
      },
      {
        "name": "network",
        "status": true,
        "config": {
          "dhcp": {
            "value": true,
            "type": "boolean"
          },
          "ethip": {
            "value": "127.0.0.1",
            "type": "string"
          },
          "ethnetmask": {
            "value": "255.255.255.0",
            "type": "string"
          },
          "ethgateway": {
            "value": "0.0.0.0",
            "type": "string"
          },
          "wlanssid": {
            "value": "",
            "type": "string"
          },
          "wlanpass": {
            "value": "",
            "type": "string"
          }
        }
      },
      {
        "name": "networkfs",
        "status": true,
        "config": {
          "NasMounts": {
            "53b83b5a-dccf-4d2f-800e-96fdc5dc4eb1": {
              "name": {
                "type": "string",
                "value": "FLAC"
              },
              "ip": {
                "type": "string",
                "value": "DISKSTATION"
              },
              "path": {
                "type": "string",
                "value": "FLAC"
              },
              "fstype": {
                "type": "string",
                "value": "cifs"
              },
              "user": {
                "type": "string",
                "value": ""
              },
              "password": {
                "type": "string",
                "value": ""
              },
              "options": {
                "type": "string",
                "value": ""
              }
            }
          }
        }
      }
```

This is the generic command to restore a playlist:
```
volumio.local/api/v1/restore/playlists
```
You have to specify, as POST fields:
* type:
  * playlist
  * songs
  * radios
  * myRadios
* path:
  * favourites
  * radio-favourites
  * my-web-radio
* data
Type is the kind of data you're sending, path is required for default playlists, to name the correspondent file (since for custom playlists the file will be named after the name found in data), data is a json containing informations properly formatted.

This is the generic command to restore configuration files:

```
volumio.local/api/v1/restore/config
```
You have to specify a POST field named *config*, that has to contain an array of JSON object with plugins and correspondent configurations, sorted by category.
