Volumio is an headless audiophile music player, designed to play music with the highest possible fidelity. Volumio runs on most embedded devices (Raspberry Pi, UDOO, Odroid, Cubieboard, Beaglebone...) and on any ordinary PC (x86).

Volumio is obtained with 3 main components:

* [Node.js Backend (this repository)](https://github.com/volumio/Volumio2/wiki)
* [Angular.JS Frontend](https://github.com/volumio/Volumio2-UI)
* [Debian based minimal OS ](https://github.com/volumio/Build)

### Logins

Logins
* user : *volumio*

* Password : *volumio*

Root login has been disabled by default, however user volumio can become root.

### Volumio 2 Virtual Machines

Useful for fast developing, no need for a Raspberry Pi (also much faster)

VMWARE Image is suggested, as Network configuration is tricky with Virtual Box

* [VMWare Virtual Machine - Beta1](http://repo.volumio.org/Volumio2/DevTools/VolumioVM-VMWare.zip)
* [Virtual Box Virtual Machine - Alpha5](http://repo.volumio.org/Volumio2/DevTools/VolumioVM-VirtualBox.zip)



System Images built with [Volumio Builder](https://github.com/volumio/Build)

## Preliminary Setup

IMPORTANT NOTE:
Volumio is designed to be an highly integrated system. This means that the WebUi is optimized to work along with the custom made Volumio system, and therefore it needs to run in a very tightly controlled environment. IT WON'T WORK on standard Raspbian or other non-volumio OSes. If you want to know what kind of customizations we're using, take a look at the [Volumio Builder](https://github.com/volumio/Build)


Volumio works with 5.5.0 version of NodeJS. Reports of working\not working node version are appreciated!

Clone the repo in the directory of your choice (default: /volumio)

```shell
git clone https://github.com/volumio/Volumio2.git volumio
cd volumio
```

Make sure /volumio folder is owned volumio user

```shell
sudo chown -R volumio:volumio /volumio
```

And that /data folder exists and is owned by volumio user

```shell
sudo mkdir /data
sudo chown -R volumio:volumio /data
```

All other dependecies are in the package JSON, from the working directory just run (as user volumio)

```shell
npm install
```

You can run all the servers in one single step just running with nodejs

```shell
node index.js
```

Finally, point your browser to http://(ip address):3000 to access the UI.

A DEV Console is available at http://(ip address):3000/dev

To make development more comfortable, a samba server is installed. This way the /volumio folder is accessible (and editable) via Network. Just mount it on your dev workstation and it will be available as local filesystem.
Testing on PI is strongly suggested.

Please take a look at the

## Development 101

To maximize efficiency and reduce code regression we're using [Git Workflow](https://guides.github.com/introduction/flow/). For example, to create a new feature you'll:
* Create a new branch, named after the feature
* Do your things on the branch
* Test if everything is fine and we don't have regressions
* Submit a Pull Request for branch dev


All new improvements and developments are meant to be done on the dev branch, once it's declared stable it will be merged to master and deployed to happy Volumio users.


## Development Guidelines

* [Forum Threads](http://volumio.org/forum/discussion-t2098-10.html) for internal discussion, remember to subscribe topics.
* Document your work where possible on the [Wiki](https://github.com/volumio/Volumio2/wiki).
* This is intended to run on Low Power Devices (r-pi). Let's keep code efficient and lightweight.
* To allow code mantainability, always comment your code properly and update DOCs if needed.
* Adhere to [MVC Best Practices](http://www.yiiframework.com/doc/guide/1.1/en/basics.best-practices) to maximize project quality.
* Have fun and enjoy what you're doing!
