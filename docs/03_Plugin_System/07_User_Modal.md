## User Modal

It is possible to interact with your plugin's user in real time using modals.

Here's an example:

```javascript
var modalData = {
                  title: 'Modal',
                  message: 'Something occured, you may react, or close this window',
                  size: 'lg',
                  buttons: [
                    {
                      name: 'Close',
                      class: 'btn btn-warning'
                    },
                    {
                      name: 'React',
                      class: 'btn btn-info',
                      emit:'react',
                      payload:''
                     }  
                  ]
                }

self.commandRouter.broadcastMessage("openModal", modalData);
```

In the previous example, a modal is created by the plugin at runtime.
Whatever button the user presses, the modal will close.

The "React" button however will also emit a "react" socketIO event, which can be handled directly by the plugin.

This section is potentially incomplete and needs revisiting, but it should work.
