## System Architecture


There are two halves of this project on the server side: Volumio OS and the Volumio Core. The Volumio OS is a customized Debian Jessie distribution and ecosystem of software packages which serves as the framework for the system. The Volumio Core is a serverside application (written in Javascript) which runs the music player, music library, and other functions.

### Architecture Overview

<img src="./img/architecture.png" width="624">

Volumio Core has an MVC-like architecture which breaks the player functionality into modules. The modules are organized by function: clients, interfaces, core, controllers, services, and output.

### Clients
The clients represent anything that can open a connection with the Volumio server and send commands. This is code that runs on the client machine, whether it be a PC, tablet, phone, or watch. The Volumio WebUI is one of the possible clients you can use to connect to the Volumio server. It communicates to the server using a standard websocket protocol. And since this is a standard protocol, users may code any other web interface they want, and have it drive Volumio. We also have many users who use MPD clients to drive Volumio. Volumio2 will have a dedicated MPD emulation interface which will be able to interact with your favorite MPD controller.

### Interface Plugins
Which brings us to our next group of modules, the interfaces. Interfaces serve as the intermediaries between the clients and the Volumio core. They translate what are typically text commands into function calls that the core executes. These interface modules are designed to be interchangeable - they offer a set of standard methods that the core can call, and return data in a standard format. We are developing this standard as we go, but the general idea is that users can drop in their own interface modules, which will allow for more interface options than just websocket and MPD emulation. For example, one could write an interface module for hard controls (real knobs and buttons, imagine that!), for local kiosk-style control, etc.

### Core Modules
The core modules run the logic behind the Volumio player. The state machine module contains logic for switching between player states like play, pause, and stop. The play-queue module maintains the list of tracks which are queued up to play. The play queue may contain tracks from any music service. The music library module (more about this later) maintains a database of all the tracks across all services that the user has active. and allows for browsing and searching. The device selector would allow a user to switch between different output sinks - this is yet to be coded, I'm still trying to figure out what this means! The volume module allows for hardware or software level control of the output volume. Finally, the command router module contains no logic, it merely routes function calls to the various other modules.

### Music Controller Plugins
The music controllers are modules which can communicate with individual music services or daemons. Each music service will have its own controller module. The controller can retrieve music information from the service or daemon, and can also send commands to control playback. It is important to note here that each music daemon likely has its own built in play queue and playback status. The Volumio state machine keeps in sync with each of these separate play queues and statuses. This allows the user to interact with Volumio as if it were a single music player, and the Volumio Core controls each of the music services separately in the background. We are currently planning controllers for MPD, Spop, and possibly GMusic. We are also going to add a controller for Libgroove, a nice local audio renderer that can serve as an alternative to MPD. Libgroove uses libav for audio decoding (the same as what VLC uses). Each music controller module will be interchangeable like the user interface modules. Users can write controllers for new music services they would like to add.

### Music Services
The music services are music player daemons or interfaces to online music sources. Some of these will come bundled as part of the Volumio OS, but users can install their own as well.

### Output Stack
The audio output stack is comprised of system-level controllers and other handlers. Under the most basic setup, this only requires ALSA, the system-level interface to your DAC. There is also the option to add SOX into the stack, which would allow for manipulation of audio data. One of the requests we often hear is for multi-room streaming and other output device selection options. Those features would probably go in this output stack somewhere. Currently, I'm still hazy on how this might work, so anyone feel free to jump in with advice!

## Technologies Used
* [Node.js](https://nodejs.org/) as the serverside application framework
* [Socket.io](http://socket.io/) for websocket communication
* [Express](http://expressjs.com/) as the HTTP webserver for the Volumio WebUI
* [Angular](https://angularjs.org/) as the WebUI framework
* [LevelDB](http://leveldb.org/) as the persistent database system
* [Kew](https://github.com/Medium/kew) to run the promise-based asynchronous execution of code (click [here](https://github.com/kriskowal/q/wiki/General-Promise-Resources) to learn what a promise is)
