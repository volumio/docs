Volumio is an headless audiophile music player, designed to play music with the highest possible fidelity. Volumio runs on most embedded devices (Raspberry Pi, UDOO, Odroid, Cubieboard, Beaglebone...) and on any ordinary PC (x86).

## Components

Volumio is obtained with 3 main components:

* [Node.js Backend (this repository)](https://github.com/volumio/Volumio2/)

This is Volumio core infrastructure. The Volumio2 backend runs on your device and accepts connections from different user interfaces (see later).
* [Angular.JS Frontend](https://github.com/volumio/Volumio2-UI)

This is Volumio's integrated WebUI. It is deployed in /volumio/http/www folder

* [Debian based minimal OS ](https://github.com/volumio/Build)

This is Volumio's build script: launch it in a Debian or Ubuntu install, to obtain a complete Volumio Image.

## Logins

Logins
* user : *volumio*

* Password : *volumio*

Root login has been disabled by default for security reasons , however user volumio can become root.

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
