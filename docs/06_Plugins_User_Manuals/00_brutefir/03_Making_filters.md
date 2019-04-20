## Making Filters

When measurement(s) is exported, as we seen, you have severals possibilities.
- __Variant 1__ Create initial EQ filter in REW and import it into rePhase as a starting point
- __Variant 2__ Go in rephase and start creating filter from scratch.
- __Variant 3__ Use the filter creation tools from the plugin and create filter using DRC-FIR.

__General tips__

For best results with Volumio and BruteFIR I recommend sampling rate of __96000__ and __65536__ filtersize/taps.

When doing EQ in rePhase try to follow these simple guidelines:

- Avoid high Q corrections as much as you can.

- Remember that dips are not as hearable as rises, so flatten the rise points but avoid to flatten dips unless they are deeper than app -8dB.

- Avoid high gains as much as you can. Don't go over +18dB, even better if you can stay bellow +12dB.

- There is an initial 6dB attenuation in BruteFIR. If your max filter is (for example) set to +16dB then set additional 10dB of attenuation in BruteFIR settings to avoid clipping.

- Measure carefully! your correction will only be good as was your measurement. Repat measurements unless you have good correlation between MMM (RTA) and sweep measurements (make at least 5 of them and average them).

- Remember that Room EQ is not an exact science, so may the Force be with you. ;)


### Variant 1 : Creating initial EQ filter in REW

* On the right side of EQ window under Equaliser choose `rePhase`

* Under Target settings configure settings for your speakers.

* Under Target settings press`Set target level` to have REW set the target level or configure it manually

* Under Filter tasks hit `Match response to target`.

* Hit `EQ filters` button to get dialog for additional manual filter adjustment

* Hit `Save filter settings to file` to save REW EQ filter (which will be imported into rePhasse

* Save your work under File/Save All Measurement


### Variant 2 : Using rePhase

* Choose `Measurement/import` from file to import REW measurement

<img src="./img/rePhase_import.jpg">

* Choose `hide phase`

* Choose Ranges and adjust Amplitude to be from 0 dB to 70 dB (you should now have the same measurement graph as done in REW)

* Under Paragraphic Gain EQ choose `import REW filter settings` to import REW parametric EQ filter

<img src="./img/rephase_import_REW_filter_settings.jpg">

* Configure following rePhase parameters: set taps to 65536, rate to 96000, filename to the name of of the filter and choose directory in which rephase will create filter

* Hit `generate` to generate and save FIR filter

* Save your work under `File/Save settings`

### Variant 3 : Using DRC-FIR tools from the plugin

Creating filter with automatic tools in the plugin is easy. You have too put the exported impluse from REW in the shared folder of Volumio.

From your Windows files explorer, access to it by typing `file://ipadressofvolumio`

Then, go in `brutefirfilter/filter-sources` and put your Wav file here.

Go in the plugin setting page and in filter creation section, choose the file as file to convert.

Choose a target curve. 2 samples are provided with the plugin.
This file define how the corrected curve should look like. You can create or adjust one of the sample given.
These files are placed in shared folder of Volumio under `brutefirfilter/target-sources`

Choose a config.

We advice to start with __'soft'__ and see how it behaves..

You can give a name for your filter, or leaave empty the field to re-use the ipmort name.

The plugin will add `samplerate+config+target-curves+.pcm` to the name.

- So, if name is __left__ the generated filter will be __left-44.1kHz-soft-hk5.pcm__

Sample rate is taken from the value set in the plugin.
## Warning : Do not set above 96Khz

Press `Create filter` and wait until the page is refreshed. Do the the samee for both channels.

<img src="./img/filter-creation-menu.png">



### Now, get ready to test your filter!
