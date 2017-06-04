## Logging

### Enable Logging

For easier usage make sure you assign the `context.logger` instance in the consturctor of your plugin:

```javascript
module.exports = ControllerSpop;
function ControllerSpop(context) {
	var self = this;
	self.logger = this.context.logger;
}
```

### Create Log Message

At any place in your code you can then call the methods of the logger instance:

```javascript
self.logger.info("Youtube::onStart Adding to browse sources");
```

The logger instance has the following methods to create log messages: `info`, `warn`, `error` and `debug`.

Volumio is using [winston](https://github.com/winstonjs/winston) for logging.