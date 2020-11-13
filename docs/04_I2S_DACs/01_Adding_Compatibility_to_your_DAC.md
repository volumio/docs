## Adding Compatibility to your DAC

If you're an hardware Audio manufacturer and you've developed a brand new i2s DAC, making it compatible with  Volumio is very easy.

### Prerequisites

* The kernel driver must be already present in the Kernel that Volumio uses. If that's not true, please [contact us](https://volumio.org/contact/)

### The dacs.json file

Volumio stores all compatibility data for i2s dac in a single file: the  [dacs.json file](https://github.com/volumio/Volumio2/blob/master/app/plugins/system_controller/i2s_dacs/dacs.json),
here's a brief extract of it (November 13th 2020):

```
{ "devices":[
  {"name":"Raspberry PI","data":[
    {"id":"adafruit-max98357","name":"Adafruit MAX98357","overlay":"hifiberry-dac","alsanum":"2","mixer":"","modules":"","script":"","needsreboot":"yes"},
    {"id":"adafruit-uda1334a","name":"Adafruit UDA1334A","overlay":"hifiberry-dac,i2s-mmap","alsanum":"2","mixer":"","modules":"","script":"","needsreboot":"yes"},
    {"id":"allo-boss-dac","name":"Allo BOSS","overlay":"allo-boss-dac-pcm512x-audio","alsanum":"2","mixer":"Digital","modules":"","script":"","needsreboot":"yes"},
    {"id":"allo-digione","name":"Allo DigiOne","overlay":"allo-digione","alsanum":"2","mixer":"","modules":"","script":"","needsreboot":"yes"},
    {"id":"allo-katana-dac","name":"Allo Katana","overlay":"allo-katana-dac-audio","alsanum":"2","mixer":"Master","modules":"","script":"","needsreboot":"yes"},
    {"id":"audio-injector-isolated","name":"AudioInjector Isolated","overlay":"audioinjector-isolated-soundcard","alsanum":"2","mixer":"Master","modules":"","script":"","needsreboot":"yes"},
    {"id":"audio-injector-ultra","name":"AudioInjector Ultra 2","overlay":"audioinjector-ultra","alsanum":"2","mixer":"DAC","modules":"","script":"","needsreboot":"yes"},
    {"id":"piano-dac","name":"Allo Piano","overlay":"allo-piano-dac-pcm512x-audio","alsanum":"2","mixer":"Digital","modules":"","script":"","needsreboot":"yes"},
    {"id":"piano-dac-plus","name":"Allo Piano 2.1","overlay":"allo-piano-dac-plus-pcm512x-audio","alsanum":"2","mixer":"Digital","modules":"","script":"","needsreboot":"yes"},
    {"id":"applepi-dac","name":"ApplePi DAC","overlay":"applepi-dac","alsanum":"2","mixer":"","modules":"","script":"","needsreboot":"yes"},
    {"id":"audiophonics-es9028q2m-dac","name":"Audiophonics I-Sabre ES9028Q2M","overlay":"i-sabre-q2m","alsanum":"2","mixer":"Digital","modules":"","script":"","needsreboot":"yes"},
    {"id":"bassfly","name":"BassFly-uHAT","overlay":"hifiberry-dac","alsanum":"2","mixer":"","modules":"","script":"bassfly-init.sh","needsreboot":"yes"},
    {"id":"bassfly-mic","name":"BassFly-uHAT with I2S Mic","overlay":"googlevoicehat-soundcard","alsanum":"2","mixer":"","modules":"","script":"bassfly-init.sh","needsreboot":"yes"},
    {"id":"bassowl","name":"BassOwl-HAT","overlay":"bassowl","alsanum":"2","mixer":"Master","modules":"","script":"","needsreboot":"yes"},
    {"id":"fe-pi-audio","name":"Fe-Pi Audio","overlay":"fe-pi-audio","alsanum":"2","mixer":"PCM","modules":"","script":"","needsreboot":"yes"},
    {"id":"generic-dac","name":"Generic I2S DAC","overlay":"hifiberry-dac","alsanum":"2","mixer":"","modules":"","script":"","needsreboot":"yes"},
    {"id":"hifiberry-amp","name":"HiFiBerry Amp","overlay":"hifiberry-amp","alsanum":"2","mixer":"Master","modules":"","script":"","needsreboot":"yes"},
    {"id":"hifiberry-amp2","name":"HiFiBerry Amp2","overlay":"hifiberry-dacplus","alsanum":"2","mixer":"Digital","modules":"","script":"","eeprom_name":"HiFiBerry DAC+","i2c_address":"4d","needsreboot":"no"},
    {"id":"hifiberry-dac","name":"HiFiBerry DAC","overlay":"hifiberry-dac","alsanum":"2","mixer":"","modules":"","script":"","needsreboot":"yes"},
    {"id":"hifiberry-dacplus","name":"HiFiBerry DAC Plus","overlay":"hifiberry-dacplus","alsanum":"2","mixer":"Digital","modules":"","script":"","eeprom_name":"HiFiBerry DAC+","i2c_address":"4d","needsreboot":"no"},
    {"id":"hifiberry-dacplusadc","name":"HiFiBerry DAC Plus ADC","overlay":"hifiberry-dacplusadc","alsanum":"2","mixer":"Digital","modules":"","script":"","i2c_address":"4d","needsreboot":"no"},
    {"id":"hifiberry-dacpluspro","name":"HiFiBerry DAC+ Pro","overlay":"hifiberry-dacplus","alsanum":"2","mixer":"Digital","modules":"","script":"","i2c_address":"4d","needsreboot":"no"},
    {"id":"hifiberry-dacplusadcpro","name":"HiFiBerry DAC Plus ADC PRO","overlay":"hifiberry-dacplusadcpro","alsanum":"2","mixer":"Digital","modules":"","script":"","i2c_address":"4d","needsreboot":"no"},
    {"id":"hifiberry-dacplusdsp","name":"HiFiBerry DAC Plus DSP","overlay":"hifiberry-dacplusdsp","alsanum":"2","mixer":"Digital","modules":"","script":"","i2c_address":"4d","needsreboot":"no"},
    {"id":"hifiberry-dac2hd","name":"HiFiBerry DAC2 HD","overlay":"hifiberry-dacplushd","alsanum":"2","mixer":"DAC","modules":"","script":"","eeprom_name":"DAC 2 HD","i2c_adress":"4d","needsreboot":"no"},
    {"id":"hifiberry-digi","name":"HiFiBerry Digi","overlay":"hifiberry-digi","alsanum":"2","mixer":"","modules":"","script":"","needsreboot":"yes"},
    {"id":"hifiberry-digi-pro","name":"HiFiBerry Digi+ Pro","overlay":"hifiberry-digi-pro","alsanum":"2","mixer":"","modules":"","script":"","needsreboot":"no"},
    {"id":"hifibox-dac","name":"HiFiBox DAC","overlay":"hifiberry-dacplus","alsanum":"2","mixer":"Digital","modules":"","script":"","eeprom_name":["HiFiBox DAC HAT","HiFiBox DAC HAT V1","HiFiBox DAC HAT V 10"],"needsreboot":"no"},
    {"id":"iqaudio-dacplus","name":"IQaudIO DAC Plus","overlay":"iqaudio-dacplus,unmute_amp ","alsanum":"2","mixer":"Digital","modules":"","script":"iqamp-unmute.sh","i2c_address":"4c","needsreboot":"no"},
    {"id":"iqaudio-digiplus","name":"IQaudIO Pi-Digi+","overlay":"iqaudio-digi-wm8804-audio","alsanum":"2","mixer":"","modules":"","script":"","needsreboot":"yes"},
    {"id":"iqaudio-amp","name":"IQaudIO Pi-DigiAMP+","overlay":"iqaudio-dacplus,unmute_amp ","alsanum":"2","mixer":"Digital","modules":"","script":"iqamp-unmute.sh","needsreboot":"yes"},
    {"id":"justboom-amp","name":"JustBoom Amp Boards","overlay":"justboom-dac","alsanum":"2","mixer":"Digital","modules":"","script":"","eeprom_name":["JustBoom DAC HAT","JustBoom DAC HAT v1.1"],"needsreboot":"yes"},
    {"id":"justboom-dac","name":"JustBoom DAC Boards","overlay":"justboom-dac","alsanum":"2","mixer":"Digital","modules":"","script":"","eeprom_name":["JustBoom DAC HAT","JustBoom DAC HAT v1.1"],"needsreboot":"yes"},
    {"id":"justboom-digi","name":"JustBoom Digi Boards","overlay":"justboom-digi","alsanum":"2","mixer":"","modules":"","script":"","eeprom_name":["JustBoom Digi HAT","JustBoom Digi HAT v1.1"],"needsreboot":"yes"},
    {"id":"mamboberry-dac","name":"Mamboberry LS DAC+","overlay":"hifiberry-dac","alsanum":"2","mixer":"","modules":"","script":"","needsreboot":"yes"},
    {"id":"merus-amp","name":"MERUS™ Amp piHAT ZW","overlay":"merus-amp","alsanum":"2","mixer":"","modules":"","script":"","needsreboot":"yes"},
    {"id":"nanosound-dac","name":"NanoSound DAC","overlay":"hifiberry-dacplus","alsanum":"2","mixer":"Digital","modules":"","script":"","needsreboot":"no"},
    {"id":"osa-dacberry-one-plus","name":"OSA DACBerry ONE+","overlay":"hifiberry-dacplus","alsanum":"2","mixer":"Digital","modules":"","script":"","needsreboot":"no"},
    {"id":"osa-dacberry-pro","name":"OSA DACBerry PRO","overlay":"iqaudio-dacplus","alsanum":"2","mixer":"Digital","modules":"","script":"","needsreboot":"no"},
    {"id":"502-dac","name":"PI 2 Design 502DAC","overlay":"hifiberry-dacplus","alsanum":"2","mixer":"Digital","modules":"","script":"","needsreboot":"yes"},
    {"id":"502-dac-pro","name":"PI 2 Design 502DAC Pro","overlay":"hifiberry-dacplus","alsanum":"2","mixer":"Digital","modules":"","script":"","needsreboot":"yes"},
    {"id":"503hta-hybrid","name":"PI 2 Design 503HTA Hybrid Tube Amp","overlay":"hifiberry-dac","alsanum":"2","mixer":"","modules":"","script":"","needsreboot":"yes"},
    {"id":"phat-beat","name":"pHAT BEAT","overlay":"hifiberry-dac","alsanum":"2","mixer":"","modules":"","script":"","needsreboot":"yes"},
    {"id":"phat-dac","name":"pHAT DAC","overlay":"hifiberry-dac","alsanum":"2","mixer":"","modules":"","script":"","needsreboot":"yes"},
    {"id":"picade-hat","name":"Picade HAT","overlay":"hifiberry-dac","alsanum":"2","mixer":"","modules":"","script":"","needsreboot":"yes","eeprom_name":["Picade HAT"]},
    {"id":"pisound","name":"pisound","overlay":"pisound","alsanum":"2","mixer":"","modules":"","script":"","needsreboot":"no"},
    {"id":"raspiaudio","name":"raspiaudio","overlay":"googlevoicehat-soundcard","alsanum":"2","mixer":"","modules":"","script":"","needsreboot":"yes"} ,
    {"id":"raspidacv3","name":"RaspiDACv3","overlay":"raspidac3","alsanum":"2","mixer":"Digital","modules":"","script":"","needsreboot":"yes"},
    {"id":"rpi-dac","name":"R-PI DAC","overlay":"rpi-dac","alsanum":"2","mixer":"Digital","modules":"","script":"","needsreboot":"yes"},
    {"id":"soekris-dac","name":"Soekris dam 1021","overlay":"hifiberry-dac","alsanum":"2","mixer":"","modules":"","script":"","needsreboot":"yes"},
    {"id":"speaker-phat","name":"Speaker pHAT","overlay":"hifiberry-dac","alsanum":"2","mixer":"","modules":"","script":"","needsreboot":"yes"},
    {"id":"st400-dac-amp","name":"ST400 Dac (PCM5122) - Amp","overlay":"iqaudio-dacplus","alsanum":"2","mixer":"Digital","modules":"","script":"","needsreboot":"yes"},
    {"id":"taudac","name":"TauDAC - DM101","overlay":"taudac","alsanum":"2","mixer":"","modules":"","script":"","eeprom_name":"TauDAC-DM101","needsreboot":"yes"},
    {"id":"terraberry-dac2","name":"Terra-Berry DAC 2/3","overlay":"i-sabre-q2m","alsanum":"2","mixer":"","modules":"","script":"","needsreboot":"yes"},
    {"id":"es90x8q2m-dac","name":"Volumio ESS 9028QM","overlay":"es90x8q2m-dac","alsanum":"2","mixer":"Digital","modules":"","script":"","i2c_address":"48","needsreboot":"no"}
  ]},
  {"name":"Odroid C1+","data":[
    {"id":"odroid-hifi-shield","name":"HiFi Shield","overlay":"","alsanum":"2","mixer":"","modules":"","script":""}
  ]},
  {"name":"Sparky","data":[
    {"id":"piano-dac","name":"Allo Piano","overlay":"","alsanum":"1","mixer":"Digital","modules":["snd-soc-allo-piano-dac"],"script":"","needsreboot":"yes"},
    {"id":"piano-dac-plus","name":"Allo Piano 2.1","overlay":"","alsanum":"1","mixer":"Digital","modules":["snd-soc-allo-piano-dac-plus"],"script":"","needsreboot":"yes"}
  ]},
  {"name":"Tinkerboard","data":[
    {"id":"hifiberry-amp","name":"HiFiBerry Amp","overlay":"hifiberry-amp","alsanum":"0","mixer":"Master","modules":"","script":"","needsreboot":"yes"},
    {"id":"hifiberry-dac","name":"HiFiBerry DAC","overlay":"hifiberry-dac","alsanum":"0","mixer":"","modules":"","script":"","needsreboot":"yes"},
    {"id":"hifiberry-dacplus","name":"HiFiBerry DAC Plus","overlay":"hifiberry-dacplus","alsanum":"0","mixer":"Digital","modules":"","script":"","needsreboot":"yes"},
    {"id":"iqaudio-dacplus","name":"IQaudIO DAC Plus","overlay":"iqaudio-dacplus","alsanum":"0","mixer":"Digital","modules":"","script":"iqamp-unmute.sh","needsreboot":"yes"},
    {"id":"rpi-dac","name":"R-PI DAC","overlay":"rpi-dac","alsanum":"0","mixer":"Digital","modules":"","script":"","needsreboot":"yes"}
  ]}
]}

```


### What you need to do

Basically edit the dac.json appropriately and send us a pull request. Here's what you need to change:

* Add your DAC under the specific device it's for, like Raspberry PI or Odroid
* id: An unique identifier. Lowercase and without spaces, possibly use the dt-overlay as id.
* name: the name that will represent your DAC
* overlay: mandatory for raspberry PI. The [DTOverlay parameter](https://www.raspberrypi.org/documentation/configuration/device-tree.md),  used to enable the DAC. If more than one, comma separate them.
* alsaname: if you know how your DAC is named by alsa, its a plus to have it declared here
* alsanum: leave it to 2 for RPI and Odroid, 1 for Sparky, 0 for Thinkerboard
* mixer: if your DAC has an hardware mixer, indicate it here, so it will be automatically configured
* script: if you need a script to be launched on start, write here the name and place the script inside the  [scripts folder](https://github.com/volumio/Volumio2/tree/master/app/plugins/system_controller/i2s_dacs/scripts)
* eeprom_name:for Raspberry PI only. Volumio can automatically detect your DAC and configure it without user intervention. The auto-detection method works best by reading the eeprom that every HAT should have. Specifically, we look for the content of `/proc/device-tree/hat/product` . So indicate here such content. Arrays are also accepted, in case this varies over time. This will look like `"eeprom_name":["JustBoom DAC HAT","JustBoom DAC HAT V1","JustBoom DAC HAT V 10"]`
* i2c_address: for Raspberry PI only. As a fallback, we can detect also a specific DAC via its i2c address. Indicate it here. This is a fallback mechanism in case eeprom reading won't work. IMPORTANT: Many dacs can have the same i2c address so use it only if there isn't  already another dac with the same address.
* needs_reboot: on Raspberry PI we can enable some DACs without rebooting, by appying the DTPARAM in userspace. This doesn't work with all dacs. So please try first with this set to no. If that works and you can hear sound, fine. If that does not happen it means that your DAC is not capable of being activated without rebooting, and set this to yes.
