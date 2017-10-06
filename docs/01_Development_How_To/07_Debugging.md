## Debugging Volumio2 Backend

<iframe src="https://player.vimeo.com/video/175284169" width="640" height="360" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
<p><a href="https://vimeo.com/175284169">Debugging Volumio 2 with Webstorm</a> from <a href="https://vimeo.com/skikirkwood">Shaggy Dog</a> on <a href="https://vimeo.com">Vimeo</a>.</p>

## Debugging with system journal

You can see all logs, generated both by the system and Volumio with

```shell
sudo journalctl -f
```

This includes outputs to the console too: 

```javascript
console.log('my output')
```

So, ideally, you'll want to:

* Edit the files from your editor of choice
* Upload changes to the Volumio device
* Restart NODE Services
* See the effects via an SSH connection, with sudo journalctl -f
