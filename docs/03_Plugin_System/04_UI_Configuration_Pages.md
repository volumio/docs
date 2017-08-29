## The Configuration Pages

To allow an easy development of plugin, we need a structured but still flexible way to configure plugins. Volumio uses a json based markup languages to describe the visual and functional aspects of configuration pages. This supports multilanguage and should be flexible enough to allow any kind of setting to be modified. If you feel your case is not covered, feel free to open an issue or discussion at

[https://github.com/volumio/Volumio2/](https://github.com/volumio/Volumio2/)

## Introduction

Configurations resides on single .json files, pertaining to a core component or a specific plugin. This file is `UIConfig.json` and it's interpreted by the `getUIConfig` function present in every plugin. The very same system is used by both Volumio core plugins and community developed plugins, the only difference is that for core functions (such as Wi-fi browser, NAS Browser and some others) we developed special controllers in the UI. You can take a look at them in the  [core elements part of Volumio2 UI](https://github.com/volumio/Volumio2-UI/tree/master/src/app/plugin/core-plugin) .

This the flow of events that results in the visualization of the configuration page:

1. Click on cog wheel, this sends the message `getUiConfig` for the category and plugin name
2. CommandRouter forwards it to the Plugins
3. The Plugin executes the `getUIConfig` function which parses and handles the `UIConfig.json` file
4. Once this is done, it returns the full config, which is a json based object.
5. UI parses it and visualizes it
6. Upon saving, data is sent back as an object

### The UIConfig.json file

It's the json file which describes visually and functionally the configuration page. A very simple example is spotify's plugin config file:

```json
{
  "page": {
    "label": "Spotify Configuration"
  },
  "sections": [
   {
      "id": "section_account",
      "element": "section",
      "label": "Spotify account",
      "icon": "fa-plug",
      "onSave": {"type":"controller", "endpoint":"music_service/spop", "method":"saveSpotifyAccount"},
      "saveButton": {
        "label": "Save",
        "data": [
          "username",
          "password",
          "bitrate"
        ]
      },
      "content": [
        {
          "id": "username",
          "type":"text",
          "element": "input",
          "doc": "This is the username of your Spotify account",
          "label": "Username",
          "value": ""
        },
        {
          "id": "password",
          "type":"password",
          "element": "input",
          "doc": "This is the password of your Spotify account",
          "label": "Password",
          "value": ""
        },
        {
          "id":"bitrate",
          "element": "switch",
          "doc": "High bitrate",
          "label": "Set for high bitrate",
          "value": true
        }
      ]
   }
  ]
}

```

Let's break it down and analyze in its sections:

```json
  "page": {
    "label": "Spotify Configuration"
  }
```

This is the Page's tite.

```
"sections": [
 {
    "id": "section_account",
    "element": "section",
    "label": "Spotify account",
    "icon": "fa-plug",
    "onSave": {"type":"controller", "endpoint":"music_service/spop", "method":"saveSpotifyAccount"},
    "saveButton": {
      "label": "Save",
      "data": [
        "username",
        "password",
        "bitrate"
      ]
    }
```    

Those are the sections descriptors. A section is typically a block of options which are related one to each other. Each section has:
* id : used to identify it
* element: the type, which is of course section
* label: the title of the section
* icon: the icon showed, it's a  [font-awesome icon](http://fontawesome.io/icons/)
* onSave: it's the function invoked in the plugin index.js file, the payload will be a json object (see saveButton data item)
* saveButton label : pretty self-explanatory
* saveButton data : this will be the payload sent along, taking data from the elements into the array. In the case above the payload will be {"username":usernameset,"password":passwordset,"bitrate":bitratedata}. Failing to add elements to the array will not result in a crash, the info/settings will just be omitted from the payload.


```
"content": [
  {
    "id": "username",
    "type":"text",
    "element": "input",
    "doc": "This is the username of your Spotify account",
    "label": "Username",
    "value": ""
  }
```

Content defines all the elements available in a section. It needs the following fields:

* id : the id, this one is the one referred in saveButton data
* type : type of the element, for a comprehensive list of examples see later
* doc : an explanation of what the field does, please try to use translations as opposed to static text, that way anyone can translate it into their own language.
* label: label, please try to use translations as opposed to static text, that way anyone can translate it into their own language. 
* value: this is the current value of the element, can be manipulated in the `getUIConfig` function. It can be either a boolean (true | false), a string or a number.
* Optionally, you can also require a confirmation popup by adding the entry `'askForConfirm': {'title': 'Confirm', 'message': 'Do you want to save this values?'}`
* If you want to hide or show an element dynamically based on the state on another option (in the same section), you can use `'visibleIf': {'field': 'spotify_service', 'value': true}`


### Element Types

#### Text input

```
                'id': 'playerName',
                'element': 'input',
                'type': 'text',
                'label': 'Player Name',
                'attributes': [
                  {'placeholder': 'call me with a fancy name'}, {'maxlength': 10}
                ],
                'value': 'Volumio'
```

#### switch
```
               'id': 'airplay',
               'element': 'switch',
               'label': 'Airplay',
               'description': 'Apple airplay',
               'value': true             
```

#### select
```
'id': 'kernel_profile',
               'element': 'select',
               'label': 'Kernel profile',
               'value': {'value': 2 ,'label': 'Less Jitter'},
               'options': [
                 {
                   'value': 1,
                   'label': 'Default'
                 },
                 {
                   'value': 2,
                   'label': 'Less Jitter'
                 },
                 {
                   'value': 3,
                   'label': 'Jitter'
                 },
                 {
                   'value': 4,
                   'label': 'Focus'
                 }
               ]
```

#### button 1: Open a modal to ask for confirmation before emitting data and message
```
'id': 'update',
              'element': 'button',
              'label': 'System updates',
              'description': 'You can check?...',
              'onClick': {
                'type': 'emit',
                'data': 'search-for-upgrade',
                'message': 'updateCheck',
                'askForConfirm': {'title': 'Confirm', 'message': 'are you sure?'}
```


#### button 2: Directly emit data and message
```
		  'id':'albumartcache',
		  'element': 'button',
		  'label': 'TRANSLATE.APPEARANCE.ALBUMART_RESET_CACHE',
		  'doc': 'TRANSLATE.APPEARANCE.ALBUMART_RESET_CACHE_DOC',
		  'onClick': {'type':"emit', 'message':'callMethod', 'data':{'endpoint':'miscellanea/albumart','method':'clearAlbumartCache','data':''}}
```

#### button 3: Open a URL in a new page
```
            'id':'volumiolink',
              'element': 'button',
              'label': 'Go To Volumio Website',
              'description": 'Open Volumio Website',
              'onClick': {'type':'openUrl', 'url':'https://volumio.org'}       
```

#### Equalizer
```
'id': 'eq',
'type': 'section',
'label': 'Equalizer',
'onSave': {
  'type': 'plugin',
  'endpoint': 'music_services/eq',
  'method': 'saveEqValues'
},
'saveButton': {
  'label': 'Save eq settings',
  'data': [
    'bandEqualizer', 'equalizerSelector'
  ]
},
'content': [
  {
    'id': 'eq_switch',
    'element': 'switch',
    'label': 'Test eq switch',
    'value': true
  },    
  {
   'id': 'bandEqualizer',
   'element': 'equalizer',
   'label': 'Music EQ',
   'description': 'Desc',
   'visibleIf': {'field': 'eq_switch', 'value': true},
   'config': {
     orientation: 'vertical',
     bars: [
       {
         min: -100,
         max: 100,
         step: 20,
         value: 20,
         tooltip: 'always'
       },
       {
         min: 0,
         max: 50,
         step: 20,
         value: 25,
         tooltip: 'hide'
       },
       {
         min: 0,
         max: 50,
         step: 20,
         value: 25,
         tooltip: 'always'
       }
     ]
   }
 }
 ```
 #### Equalizer Selector
 ```
 {
              'id': 'equalizerSelector',
              'element': 'equalizer',
              'label': 'Slider selector',
              'description': 'Desc',
              'config': {
                orientation: 'horizontal',
                bars: [
                  {
                    min: 0,
                    max: 50,
                    step: 10,
                    value: [10, 20],
                    range: true,
                    tooltip: 'always'
                  },
                  {
                    ticks: [1, 2, 3],
                    ticksLabels: ['Min', 'Medium', 'Max'],
                    value: 2,
                    tooltip: 'show'
                  },
                  {
                    ticks: [1, 2, 3, 4, 5],
                    ticksPositions: [0, 20, 40, 80, 100],
                    ticksLabels: ['1', '2', '3', '4', '5'],
                    tickSnapBounds: 20,
                    value: 4,
                    tooltip: 'show'      
                  }
 ```

### Translating text

In order to allow people to translate the plugin into their own languages it is advised to use translations as opposed to static lines of text. It only takes up a little more time, but saves time in the long run.

Requirements:
* i18n module (it needs to be places in the node_modules directory)
* a i18n directory with at least one (preferably (also) English) language file e.g.: strings_en.json

You can translate strings by calling the TRANSLATE command in the text field followed by any number of nodes, you can make it as complex as you want, but keep it readable please.

Example of a UIConfig element
```
               'id': 'docs',
               'element': 'input',
               'doc': 'TRANSLATE.DOCS.WHYSHOULDITRANSLATE',
               'label': 'TRANSLATE.DOCS.EXAMPLE',
               'description': 'TRANSLATE.DOCS.DESC',
               'value': true             
```

The following is an example of a translation snippet.
```
{
	"DOCS":{
	    "WHYSHOULDITRANSLATE":"Translation allow for neater integration into systems with other languages",
	    "EXAMPLE":"Please translate this to your own language",
	    "DESC":"You can fill in any translation here",
        ...
```

You don't need to use all caps if you don't want to, I use those because they stand out like that.
