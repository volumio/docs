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
volume mute                        Mutes
volume unmute                      Unmutes
volume plus                        Increases Volume of one step
volume minus                       Decreases Volume of one step
seek plus                          Forwards 10 seconds in the song
seek minus                         Backwards 10 seconds in the song
seek <seconds>                     Plays song from selected time
repeat                             Toggles repetition of queue
random                             Toggles randomization of queue


[[PLAYBACK CONTROL]]

play
pause
next
previous
stop
clear



[[VOLUMIO SERVICE CONTROL]]

vstart                               Starts Volumio Service
vstop                                Stops Volumio Service
vrestart                             Restarts Volumio Service


[[VOLUMIO DEVELOPMENT]]

pull                               Pulls latest github status on master from https://github.com/volumio/Volumio2.git
pull -b <branch>                   Pulls branch <branch> from https://github.com/volumio/Volumio2.git
pull -b <branch> <repository>      Pulls branch <branch> from git repository <repository>
dev                                Start Volumio in develpment mode, with Nodemon and Remote Debugger
kernelsource                       Gets Current Kernel source (Raspberry PI only)
plugin init                        Creates a new plugin
plugin refresh                     updates plugin in the system
plugin package                     compresses the plugin
plugin publish                     publishes the plugin on git
plugin install                     installs the plugin locally
plugin update                      updates the plugin
logdump <description>              dump logs to $LOGDUMP instead of uploading

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
