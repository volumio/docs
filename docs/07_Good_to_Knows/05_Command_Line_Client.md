Volumio has a command line client which can be invoked with the command

```bash
volumio
```


By invoking it, you'll see the help output with a list of the available commands:

```bash
Usage : volumio <argument1> <argument2>

[[PLAYBACK STATUS]]

status                             Gives Playback status information
volume                             Gives Current Volume Information
volume <desired volume>            Sets Volume at desired level 0-100


[[PLAYBACK CONTROL]]

play
pause
next
previous


[[VOLUMIO SERVICE CONTROL]]

start                               Starts Volumio Service
stop                                Stops Volumio Service
restart                             Restarts Volumio Service
```


#### Command Line Client Development

The command line client is located at

```
/volumio/app/plugins/system_controller/volumio_command_line_client/volumio.sh
```

While some dynamic commands (like volume controls) are located at

```
/volumio/app/plugins/system_controller/volumio_command_line_client/commands
```
