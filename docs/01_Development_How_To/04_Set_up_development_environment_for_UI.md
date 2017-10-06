## Setting up a development environment for Volumio2 UI

Volumio2 UI is an [AngularJS](https://angularjs.org/) based WebAPP. You can develop on it from your PC\MAC but you need to have a Volumio device on your network.
The UI communicates with Volumio's backend via [WebSockets](/docs/API/WebSocket_APIs) using Socket.io [Socket.io](http://socket.io/)

To set up a development environment on your PC\MAC do:

### Install dependencies (only first time)
* Download and install [Node.js](https://nodejs.org/it/download/)
* Download and install [Bower](https://bower.io/#install-bower)
* Download and install [Gulp](https://github.com/gulpjs/gulp/blob/master/docs/getting-started.md)

### Prepare Volumio2 UI Development folder

* Clone the UI with:

```shell
 git clone https://github.com/volumio/Volumio2-UI
```

We suggest developing on the *development* branch, and to push your Pull requests there:

```shell
 cd Volumio2-UI
 git checkout development
```

* Install npm dependencies
```shell
npm install
```

* Install bower dependencies
```shell
bower install
```

* Tell the UI where our Volumio instance is :

Now, you can develop on it, while retrieving data from Volumio2 backend (you must have a Volumio2 device on your network and know its IP address). To tell the UI where to find Volumio 2 backend, create a file with the IP of Volumio2 in
```shell
/src/app/local-config.json
```
The file will look like

```json
{
  "localhost": "http://192.168.31.234"
}
```

Now, feel free to edit and see live changes on a local browser with dynamically generated UI. To do so:
```shell
gulp serve --theme="volumio"
```

Once finished, to deploy on Volumio 2, first build it. if you want production optimization use --env="production"

```shell
gulp build --theme="volumio" --env="production"
```

And deploy by copying the content of dist directory on Volumio2 device to:
```shell
/volumio/http/www
```