Sometimes it might be useful to connect to Volumio from outside the LAN, via services like NO-IP. Volumio UI uses socket.io to communicate with the backend, so we must tell the UI to connect
to the external IP rather than the LAN's IP.

 #### Tell the UI to bind to new IP

 If you want to achieve this, hardcode your public IP in [https://github.com/volumio/Volumio2/blob/master/http/restapi.js](https://github.com/volumio/Volumio2/blob/master/http/restapi.js line 7

Change:

```
var primaryhost = undefined;
```
To:

```
var primaryhost = 'http://[YOUR_PUBLIC_IP]:3000';
```

your public ip instead of self.host
