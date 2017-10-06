### Index.js aka the plugin's core

The index.js file of every plugin is where the magic goes on. It has some predefined and mandatory functions and a standardized layout. Depending on you'r plugin's category, this structure needs to change accordingly. We'll start by detailing a generic plugin structure.

### Generic structure

The first part is about module dependencies, we'll need to list all the node modules our plugin depends on (example taken from Spotify plugin).

```javascript
'use strict';

var libQ = require('kew');
var libNet = require('net');
var libFast = require('fast.js');
var fs=require('fs-extra');
var config = new (require('v-conf'))();
var exec = require('child_process').exec;
var SpotifyWebApi = require('spotify-web-api-node');
var nodetools = require('nodetools');
```

IMPORTANT TIPS:
* Node modules allow you to develop faster, by relaying on already-written code to overcome the majority of tasks, to look for them [search here](https://www.npmjs.com/package/package)
* The `'use strict';` declaration at the beginning will ensure no obvious coding mispractices will happen, [more info on the matter](http://www.w3schools.com/js/js_strict.asp)
* Use the minimum amount of modules needed, and try to avoid modules that needs compilation (you will spot those because they'll take longer on npm install), so you will avoid to mantain two separate versions for x86 and arm architectures.

Then we will define the plugin class and reference to other core Volumio's internals:

```javascript
module.exports = ControllerSpop;
function ControllerSpop(context) {
	// This fixed variable will let us refer to 'this' object at deeper scopes
	var self = this;

	this.context = context;
	this.commandRouter = this.context.coreCommand;
	this.logger = this.context.logger;
	this.configManager = this.context.configManager;

}
```
IMPORTANT TIPS:
* Substitute `ControllerSpop` with something that resembles your plugin name. For example `ControllerGPIO` or `ControllerSoundcloud`
* We'll start every prototype (see later) with this Controller naming


Then we add all the required functions for a generic plugin:


#### On Volumio Start

This is the code that gets executed when Volumio starts and triggers the plugin start. Typically, what you do is load the plugin configuration.

```javascript
ControllerSpop.prototype.onVolumioStart = function()
{
	var configFile=this.commandRouter.pluginManager.getConfigurationFile(this.context,'config.json');
	this.config = new (require('v-conf'))();
	this.config.loadFile(configFile);

}
```

#### On Start

This instead is what happens when the Plugin starts. It's different from On Volumio Start since this function is triggered only if the plugin is enabled. In this case we're starting the spop daemon (responsible for Spotify Playback).

```javascript
ControllerSpop.prototype.onStart = function() {
	var self = this;

	var defer=libQ.defer();

	self.startSpopDaemon()
		.then(function(e)
		{
			setTimeout(function () {
				self.logger.info("Connecting to daemon");
				self.spopDaemonConnect(defer);
			}, 5000);
		})
		.fail(function(e)
		{
			defer.reject(new Error());
		});
	this.commandRouter.sharedVars.registerCallback('alsa.outputdevice', this.rebuildSPOPDAndRestartDaemon.bind(this));

	return defer.promise;
};
```
**IMPORTANT:**

* You'll notice that we use promises here. That's why Volumio needs to know when the plugin has actually started, or if it failed. So what we're doing is returning the promise on successful start, and rejecting it if it doesn't start properly.
* The strange function  `this.commandRouter.sharedVars.registerCallback('alsa.outputdevice', this.rebuildSPOPDAndRestartDaemon.bind(this));` does one important thing. It binds to a shared system value (alsa.outputdevice, which is the output device) and when it changes it triggers the function `rebuildSPOPDAndRestartDaemon` that rewrites spop config file and restarts it.

#### On stop

When a plugin is stopped, this function gets executed. What we're doing here is killing the spop daemon. We must resolve the promise to signal everything was ok

```javascript
ControllerSpop.prototype.onStop = function() {
	var self = this;

	self.logger.info("Killing SpopD daemon");
	exec("/usr/bin/sudo /usr/bin/killall spopd", function (error, stdout, stderr) {
		if(error){
			self.logger.info('Cannot kill spop Daemon')
		}
	});

	return libQ.resolve();
};
```

#### Get Configuration files

Very straightforwarding, we load the .json configuration file for this plugin.

```javascript
ControllerSpop.prototype.getConfigurationFiles = function()
{
	return ['config.json'];
}
```

#### Get UI configuration

This function is triggered when we want to access the plugin configuration. For a better understanding of the configuration pages see [Configuration Pages ](../Plugin_System/UI_Configuration_Pages)

```javascript
ControllerSpop.prototype.getUIConfig = function() {
	var defer = libQ.defer();
	var self = this;

	var lang_code = this.commandRouter.sharedVars.get('language_code');

	self.commandRouter.i18nJson(__dirname+'/i18n/strings_'+lang_code+'.json',
		__dirname+'/i18n/strings_en.json',
		__dirname + '/UIConfig.json')
		.then(function(uiconf)
		{

			uiconf.sections[0].content[0].value = self.config.get('username');
			uiconf.sections[0].content[1].value = self.config.get('password');
			uiconf.sections[0].content[2].value = self.config.get('bitrate');

			defer.resolve(uiconf);
		})
		.fail(function()
		{
			defer.reject(new Error());
		});

	return defer.promise;
};

```

IMPORTANT:
* With `var lang_code = this.commandRouter.sharedVars.get('language_code');` we retrieve the current language code. If translation is provided under the `/i18n/` folder, we'll translate the configuration page, if not we'll default to english.
* We use promises here as well, since it will take some time to parse the UIConfig.json and translate it. Not using promises will result in configuration not working.
* With `uiconf.sections[0].content[0].value = self.config.get('username');` we're simply subsituting the first element's value of the first section with the `username` value taken from the plugins configuration.  That's how we can populate the UI Configuration Page with actual values.

### Optional functions for generic plugins


#### Get configuration from other plugins

There are cases where we want to get configuration parameters from other plugins, for example to know if an i2s DAC has been enabled or not. We will then use the `executeOnPlugin` method which will allow us to execute any method on any plugin. For code clarity we wrapped it into the `getAdditionalConf` function, accepting 3 parameters which are mandatory for the aforementioned `executeOnPlugin`:

* TYPE (plugin category)
* CONTROLLER (plugin name)
* DATA (the configuration parameter we want to get)

Please note that the function to get config parameters is not always `getConfigParam` but could be also just `getConf`. Check the individual plugin to see which is the correct function.

```javascript
ControllerAlsa.prototype.getAdditionalConf = function (type, controller, data) {
	var self = this;
	return self.commandRouter.executeOnPlugin(type, controller, 'getConfigParam', data);
};
```

#### Set configuration from other plugins

Same as above, also here `setConfigParam`could be also `setConf` or `setUiConfig`. Check the individual plugin to see which is the correct function.

```javascript
UpnpInterface.prototype.setAdditionalConf = function () {
	var self = this;

	return self.commandRouter.executeOnPlugin(type, controller, 'setConfigParam', data);
};
```

#### Restart

Sometimes it might be useful to have a function to restart the plugin. Here's an example for upnp interface in Volumio.

```javascript
UpnpInterface.prototype.onRestart = function () {
	var self = this;

	exec('/usr/bin/sudo /usr/bin/killall upmpdcli', function (error, stdout, stderr) {
		if (error) {
			self.logger.error('Cannot kill upmpdcli '+error);
		} self.startUpmpdcli();
	});
};
```
