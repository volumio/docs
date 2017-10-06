# Design Principles

The main idea is to provide a mechanism to describe the configuration section of the UI and the configuration of plugins that is flexible and not bound to code.
To reach this the whole hs to be described with an higher level language.
Plugin\Core component Configuration is composed of different parts:

## Configuration File

Configurations reside on single .json files, pertaining to a core component or a specific plugin.
Every core component that needs a configuration file (example: network controller, Network Mount Controller, Playback Settings) will have their json specific file into /app/config .
If a controller has its own folder, the json config file will be placed in the same controller folder, along with the index.js file. The configuration will be handled by [Convict ](https://github.com/mozilla/node-convict) and it will look this way:

Each item is described as follows:

      "KEY":{
          "value":"VALUE",
          "type":"[boolean|int|string|password|ipaddress|page|section|select]",
          "label":"Blah blah"
          }

where:

*   KEY [MANDATORY] identifies the item.

*   VALUE [OPTINAL] this attribute contains the current item value. Its format depends on the type. For example a boolean
 type will contains true or false while a string type can contain any string.

*   TYPE [MANDATORY] this attribute describes the data type. As of now the above values
 are supported. More can (and will) come in the future.

*   DOC [MANDATORY] This attribute contains the label associated to the item, in the locale specified by the caller


(Example for Wired Network Config File)

     var wirednetworkconf = convict({
      dhcp: {
        doc: "DHCP Configuration",
        format: ["dhcp", "static"],
       default: "dhcp",
        value: "dhcp"
       },
       ip: {
        doc: "Static IP Address ",
        format: "ipaddress",
        default: "null",
         value: "IP_ADDRESS",
      },
        netmask: {
         doc: "Netmask",
         format: "ipaddress",
         default: 255.255.255.0,
         value: "255.255.255.0"
       },
       gateway: {
        doc: "Gateway",
        format: "ipaddress",
        default: "null",
        value: " "
        }
      });

Another example is SPOP's config file , the spotify daemon:

        var spopconf = convict({
        spotify_username: {
         doc: "Spotify Username",
         format: ["*"],
        default: "null",
         env: " "
       },
        spotify_username: {
        doc: "Spotify Username",
         format: "*",
        default: "null",
        env: " ",
      },
       high_bitrate: {
        doc: "Prefer High Bitrate Streams",
        format: ["true", "false"],
        default: "true",
        env: "true"
       },
       enabled: {
         doc: "Enable Spotify Service",
         format: "*",
         default: "false",
         env: "false"
       },
     });




## Index File

Each configuration will have in its parent index.js (the actual core component\plugin file), among the others,  methods that describes:

### Required Start

If the Component\ plugin needs a daemon or service to be up and running, it's invoke function must be present.

start

### Required Re-Start

If the Component\ plugin needs a daemon or service to be restarted when its configuration changes, it's restart function must be present.

restart

### Install

A function that installs the required (if any) external packages. This can be a shell script, an apt package. It must perform the installation and report a Success message or an error message, with indication of what happened.

### A method for  specific component function

Example: if this is a sources plugin, which services are exposed and how to retrieve them.
TO BE FURTHER DISCUSSED



### Display Section

This will be invoked by the front end when the pertaining configuration page is to be shown. This function will appropriately parse and serve via the Socket Interface a "layout" of the pertaining configuration page. We'll use a standardized way to provide the UI with predefined layout elements and DOMs, that will be consistent across the whole Volumio frontend system.

DOM COMPONENTS

Initially we'll have only 2 DOM:
 - Section: This will be used as containers for specific configurations inclusion.
 - Page Title: speaks for itself
Example: Network Configuration Page (name),  will contain 2 sections: Wired And Wireless.

ELEMENTS

The elements are used just to manipulate the configuration in the most appropriate way. And their number will be finite. We're taking standard bootstrap naming and examples as reference, even if look and feel will be customized .

- Select
- Input (text or string)
- Save\Discard Bar
- Progress Bar Selector
- Checkbox Radio Button

Those configurations fields can be nested, and with DOM style element included, will represent a "skeleton" for the UI frontend to wrap and build accordingly.
As a mere example, let's see how Wireless Configuration Page will look like (this is the emitted object via socket.io to the backend) :

    "networkpage":{
        "title":"Network Settings"
          "section":{
                "title":"Wired Networking",
                "label":"Network configuration",
                "children":{
                        "wifi":{
                            "value":"true",
                            "type":"boolean",
                            "label":"Enable Wifi"
                            }
                    }
                },
            "sub_page_b":{
                        "type":"page",
                        "label":"System configuration"
                        "children":{}
                        },
                    }
                }





## Linking items in a hierarchy
Items can be linked in a tree hierarchy. To do this the attribute children is specified. Its value is an object containig subitems. Below an example:

    "main":{
        "type":"page",
        "label":"Network Configuration"
        "children":{
                "type":"section",
                "label":"Wired Network",
                "children":{
                        "dhcp":{
                            "type":"select",
                            "label":"DHCP Network Settings",
                            "current_value":"true",
                            "options":[{true: Automatic (DHCP)},{false:Static}],
                            },
                               "children":{
                                   "type":"section",
                                   "label":"Static IP Configuration",
                                   "visibleif" "dhcp:false" //show if dhcp is set to false :{
                                       "IP":{
                                       "type":"text_box",
                                       "value":" ",
                                       "format":ipaddress,
                                       "label":"IP"
                                      },
                                       "netmask":{
                                       "type":"text_box",
                                       "value":" ",
                                       "format":ipaddress,
                                       "label":"Netmask"
                                      },
                                       "gateway":{
                                       "type":"text_box",
                                       "value":" ",
                                       "format":ipaddress,
                                       "label":"Gateway"
                                      },
                              }
                    }
                },
            "wireless_section":{
                "type":"section",
                "label":"Wireless Network",

                        },
                    }
                    }
     
