If you're an hardware Audio manufacturer and you've developed a brand new i2s DAC, making it compatible with  Volumio is very easy.

#### Prerequisites

* The kernel driver must be already present in the Kernel that Volumio uses. If that's not true, please [contact us](https://volumio.org/contact/)

#### The dacs.json file

Volumio stores all compatibility data for i2s dac in a single file: the  [dacs.json file](https://github.com/volumio/Volumio2/blob/master/app/plugins/system_controller/i2s_dacs/dacs.json),
here's a brief extract of it :

```json
{ "devices":[
  {"name":"Raspberry PI","data":[
    {"id":"aoide-kazoo-dac","name":"Aoide Kazoo DAC","overlay":"aoide-kazoo-dac","alsanum":"1","mixer":"Digital","modules":"","script":"","needsreboot":"yes"},
    {"id":"generic-dac","name":"Generic I2S DAC","overlay":"hifiberry-dac","alsanum":"1","mixer":"Digital","modules":"","script":"","needsreboot":"yes"},
    {"id":"hifiberry-dacplus","name":"Hifiberry DAC Plus","alsaname":"Hifiberry DAC","overlay":"hifiberry-dacplus","alsanum":"1","mixer":"Digital","modules":"","script":"","eeprom_name":"HiFiBerry DAC+","i2c_address":"4d","needsreboot":"no"},
    {"id":"hifiberry-dac","name":"Hifiberry DAC","overlay":"hifiberry-dac","alsanum":"1","mixer":"Digital","modules":"","script":"","needsreboot":"yes"},
    {"id":"hifiberry-amp","name":"Hifiberry Amp","overlay":"hifiberry-amp","alsanum":"1","mixer":"Master","modules":"","script":"","needsreboot":"yes"},
    {"id":"hifiberry-digi","name":"Hifiberry DIGI","overlay":"hifiberry-digi","alsanum":"1","mixer":"","modules":"","script":"","needsreboot":"yes"},
    {"id":"iqaudio-dacplus","name":"IQaudIO DAC Plus","overlay":"iqaudio-dacplus,auto_mute_amp","alsanum":"1","mixer":"Digital","modules":"","script":"iqamp-unmute.sh","i2c_address":"4c","needsreboot":"no"},
    {"id":"justboom-dac","name":"JustBoom DAC Boards","overlay":"justboom-dac","alsanum":"1","mixer":"Digital","modules":"","script":"","eeprom_name":["JustBoom DAC HAT","JustBoom DAC HAT V1","JustBoom DAC HAT V 10"],"needsreboot":"no"},
    {"id":"iqaudio-amp","name":"IQaudIO Pi-DigiAMP+","overlay":"iqaudio-dacplus,auto_mute_amp","alsanum":"1","mixer":"Digital","modules":"","script":"iqamp-unmute.sh","needsreboot":"yes"},

  ]},
  {"name":"Odroid C1+","data":[
    {"id":"odroid-hifi-shield","name":"HiFi Shield","overlay":"","alsanum":"2","mixer":"","modules":"","script":""}
  ]}
  ]}
```

#### What you need to do

Basically edit the dac.json appropriately and send us a pull request. Here's what you need to change:

* Add your DAC under the specific device it's for, like Raspberry PI or Odroid
* id: An unique identifier. Lowercase and without spaces, possibly use the dt-overlay as id.
* name: the name that will represent your DAC
* overlay: mandatory for raspberry PI. The [DTOverlay parameter](https://www.raspberrypi.org/documentation/configuration/device-tree.md),  used to enable the DAC. If more than one, comma separate them.
* alsaname: if you know how your DAC is named by alsa, its a plus to have it declared here
* alsanum: leave it to 1
* mixer: if your DAC has an hardware mixer, indicate it here, so it will be automatically configured
* script: if you need a script to be launched on start, write here the name and place the script inside the  [scripts folder](https://github.com/volumio/Volumio2/tree/master/app/plugins/system_controller/i2s_dacs/scripts)
* eeprom_name:for Raspberry PI only. Volumio can automatically detect your DAC and configure it without user intervention. The auto-detection method works best by reading the eeprom that every HAT should have. Specifically, we look for the content of `/proc/device-tree/hat/product` . So indicate here such content. Arrays are also accepted, in case this varies over time. This will look like `"eeprom_name":["JustBoom DAC HAT","JustBoom DAC HAT V1","JustBoom DAC HAT V 10"]`
* i2c_address: for Raspberry PI only. As a fallback, we can detect also a specific DAC via its i2c address. Indicate it here. This is a fallback mechanism in case eeprom reading won't work. IMPORTANT: Many dacs can have the same i2c address so use it only if there isn't  already another dac with the same address.
* needs_reboot: on Raspberry PI we can enable some DACs without rebooting, by appying the DTPARAM in userspace. This doesn't work with all dacs. So please try first with this set to no. If that works and you can hear sound, fine. If that does not happen it means that your DAC is not capable of being activated without rebooting, and set this to yes.
