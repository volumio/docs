## Development environment

In order to develop new functionalities of Volumio, depending on which part you want to improve, you need to set up a development environment.
Volumio is designed to be an highly integrated system. This means that the WebUi is optimized to work along with the custom made Volumio system, and therefore it needs to run in a very tightly controlled environment. IT WON'T WORK on standard Raspbian or other non-volumio OSes. If you want to know what kind of customizations we're using, take a look at the [Volumio Builder](https://github.com/volumio/Build)

So, we suggest to have a running Volumio device connected to your local network, while developing on your machine.

### Setting up a development environment for Volumio2 NODE Backend

In this scenario, we will develop direclty on the Volumio device, but editing the main files on your PC\MAC. There are several ways to achieve such result

* Mount the /volumio directory of your device to a Folder on your system via sftp (volumio:volumio)
* Use an IDE that allows remote deplyoment (like [Atom](https://atom.io/) or [Webstorm](https://www.jetbrains.com/webstorm/) which we suggest since its simply awesome!)

*IMPORTANT*: If you want to develop on the latest version, you can simply launch this command to obtain the latest code on master branch:

```shell
volumio pull
```

If you want to develop or test a certain branch you can use the following command, replacing *<branch>* with the real name of the branch:

```shell
volumio pull -b <branch>
```

If you want to develop or test a certain branch of a forked repository you can use the following command, replacing *<branch>* with the real name of the branch and *<repository>* with the real name of the repository URL, e.g. something like https://github.com/user_who_forked_volumio/Volumio2.git

```shell
volumio pull -b <branch> <repository>
```



### Setting up a development environment for Volumio2 UI

Volumio2 UI is an [AngularJS](https://angularjs.org/) based WebAPP. You can develop on it from your PC\MAC but you need to have a Volumio device on your network.
The UI communicates with Volumio's backend via [WebSockets](/docs/API/WebSocket_APIs) using Socket.io [Socket.io](http://socket.io/)

To set up a development environment on your PC\MAC do:

#### Install dependencies (only firt time)
* Download and install [Node.js](https://nodejs.org/it/download/)
* Download and install [Bower](https://bower.io/#install-bower)
* Download and install [Gulp](https://github.com/gulpjs/gulp/blob/master/docs/getting-started.md)

#### Prepare Volumio2 UI Development folder

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

### Setting up a development environment for Volumio 2 images

We suggest to develop on a debian based environment

#### Install dependencies

```
git squashfs-tools kpartx multistrap qemu-user-static samba debootstrap parted dosfstools qemu binfmt-support qemu-utils
```

#### Set up development folder 

- clone the build repo on your local folder  : git clone https://github.com/volumio/Build build
- if on Ubuntu, you may need to remove `$forceyes` from line 989 of /usr/sbin/multistrap
- cd to /build and type

```
./build.sh -b <architecture> -d <device> -v <version>
```

where switches are :

 * -b `<arch>` Build a full system image with Multistrap. Options for the target architecture are **arm** or **x86**.
 * -d `<dev>`  Create Image for Specific Devices. Supported device names:
             **pi**, **odroidc1/2/xu4/x2**, udoo, cuboxi, bbb, cubietruck, compulab, **x86**
 * -l `<repo>` Create docker layer. Give a Docker Repository name as the argument.
 * -v `<vers>` Version

Example: Build a Raspberry PI image from scratch, version 2.0 :
```
./build.sh -b arm -d pi -v 2.0 -l reponame
```

You do not have to build the architecture and the image at the same time.

Example: Build the architecture for x86 first and the image version MyVersion in a second step:
```
./build.sh -b x86

./build.sh -d x86 -v MyVersion
```
