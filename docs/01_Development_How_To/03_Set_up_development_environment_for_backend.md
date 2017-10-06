## Setting up a development environment for Volumio2 NODE Backend

In this scenario, we will develop direclty on the Volumio device, but editing the main files on your PC\MAC. There are several ways to achieve such result

* Mount the /volumio directory of your device to a Folder on your system via sftp (volumio:volumio)
* Use an IDE that allows remote deplyoment (like [Atom](https://atom.io/) or [Webstorm](https://www.jetbrains.com/webstorm/) which we suggest since its simply awesome!)

*IMPORTANT*: If you want to develop on the latest version, you can simply launch this command to obtain the latest code on master branch:

```shell
volumio pull
```

If you want to develop or test a certain branch you can use the following command, replacing `<branch>` with the real name of the branch:

```
volumio pull -b <branch>
```

If you want to develop or test a certain branch of a forked repository you can use the following command, replacing `<branch>` with the real name of the branch and `<repository>` with the real name of the repository URL, e.g. something like `https://github.com/user_who_forked_volumio/Volumio2.git`

```
volumio pull -b <branch> <repository>
```
