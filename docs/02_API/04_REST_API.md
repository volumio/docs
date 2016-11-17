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
