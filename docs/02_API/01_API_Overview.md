## Introduction

### Volumio's main API: websocket

The most used API transport in Volumio2 is its Websockets API as it allows almost real time communication with multiple clients. Volumio's WebUI gets and sends data (almost) exclusively via WS. Volumio's WS layer is powered by [Socket.io](http://socket.io/).
The WebSocket API interface is located at: https://github.com/volumio/Volumio2/blob/master/app/plugins/user_interfaces/websocket/index.js

Full documentation about Volumio Websocket protocol is provided in the next section

### Volumio's REST API

Alternatively, a small subset of system calls are available trough RESTful APIs, in json format. They are available in the REST API section
