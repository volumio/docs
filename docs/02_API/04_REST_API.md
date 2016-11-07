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
This is an example of volumio.local/api/v1/backup/playlists/radio-favourites
