## Making Filters

After measurement(s) are exported, you have severals possibilities. 
- __Variant 1__ Create initial EQ filter in REW and import it into rePhase as a starting point.
- __Variant 2__ Jump into rePhase and start creating filter from scratch.
- __Variant 3__ Use DRC-FIR filter creation tool from the plugin to create the filter (Note that this only works for single point measurements).

### General tips

For best results with Volumio and BruteFIR I recommend __65536__ filtersize/taps.

When adjusting or making an EQ in rePhase try to follow these simple guidelines:

- Avoid high Q corrections as much as you can.
- Remember that dips are not as audible as rises, so aim to flatten the rises but avoid trying to flatten dips. If dips are deeper than app -8dB there may be a benefit but note that the result will often sound "muddy".
- Avoid high gains as much as you can. Don't go over +18dB, even better if you can stay bellow +12dB.
- Remember your correction will only be good as was your measurement. Repat measurements unless you have good correlation between MMM (RTA) and sweep measurements (make at least 5 of them and average them).
- Remember that Room EQ is not an exact science, so may the Force be with you. ;)

### Target Curves

Speakers in a room typically have non-flat response. The room typically provides a bass boost and a treble dip, even for speakers that are manufacturered to be "flat". Typically when applying correction filters the goal is not to make the speakers sound flat but rather to apply a target curve (often called "House Curve")

Several example target curves are provided with this plugin and are in the `Dsp\target-curves` folder of the Internal Storage of Volumio. These can be loaded into REW or customised when using DRC-FIR. House curves are simple text files in the format of `"Frequency   Gain"`. An example may look like:
```
0       -30
20      6
50      6
400     0
3000    0
16000   -3
20000   -3
22050   -30
```
Target curves used with DRC-FIR need to start at 0 and end at the Nyquist frequency (half the sample rate) and should have a significant drop in volume (-30dB is a good target). Additionally the filename must __not__ contain spaces. 

To use these curves in REW open the preferences and select the desired text file in the `House Curve` tab.
 


### Variant 1 : Creating initial EQ filter in REW

1. With the desired Sweep Response / Average / Pink Noise measurement selected in REW open the `EQ` Window.
2. On the right side of EQ window under Equaliser choose `rePhase`
3. Under Target settings configure settings for your speakers.
   - This setting allows you to adjust for a target curve. 
   - In the graph of the EQ window the target curve is shown as a blue line. 
   - If you have imported a House Curve as described above select "Full Range Speakers" and don't apply any additional cut-offs or slopes. 
4. Under Target settings press`Set target level` to have REW attempt to set the target level automatically or configure it manually. 
   - This process will attempt to reduce rises above the target while leaving dips below it largely unchanged. 
   - The lower target is under your measurement the more overall volume you lose when applying your filter.
5. Under Filter Tasks tweak some of the target settings
   - You may wish to only correct low frequencies, especially when using MMM or Pink Noise measurements as your source.
   - Overall Max Boost will determine how dips in your response are handled. It is recommended to leave this low (e.g. 1dB)
6. Click `Match response to target`
7. (Optional) Click `EQ filters` button to get dialog for additional manual filter adjustment, but this can be done in rePhase
8. Click `Save filter settings to file` to save REW EQ filter which will be imported into rePhase.
9. Save your work under File/Save All Measurement (EQs are saved with each individual measurement so you can come back to them later)
10. Proceed to Variant 2

### Variant 2 : Using rePhase (from scratch or from REW)

1. On the right under the `Measurement` tab click `Import From File` to import REW text measurement we exported on the previous page. 

<img src="./img/rePhase_import.jpg">

2. Click `hide phase`.
3. Under the `Ranges` tab adjust Amplitude so you can see your measurement. REW ranges are typically between 0 dB to 80 dB (you should now have the same measurement graph as in REW).
4. (Skip this step if making a filter from scratch) Under the `Paragraphic Gain EQ` tab click the arrow next to `Tools` and click `import REW filter settings` and import REW parametric EQ filter exported above. The response should change to look more like your target curve.

<img src="./img/rephase_import_REW_filter_settings.jpg">

5. Tweak. This is your chance to adjust the filter, check the tips at the top of the page and tune your filters to suit. 
6. Configure following rePhase parameters under `Impulse Settings:
    - Set taps to 65536 samples
    - Set rate to the desired sample rate (Recommended 96000Hz, and do not exceed 96000Hz)
    - Set your desired filter name under filename and choose directory in which rephase will create filter. (Note: The filename must __not__ contain spaces.)
7. Hit `generate` to generate and save FIR filter
8. Save your work under `File/Save settings`

### Variant 3 : Using DRC-FIR tools from the plugin

Creating filter with automatic tools in the plugin is easy. Simply put the exported impluse from the single REW measurement in the shared folder of Volumio, select a few preset options and click Create. 

1. From Windows explorer, access your volumio network share by typing `\\volumio.local\` 
    - This may be substituted with your volumio IP address.
    - The default login and password is `volumio:volumio`
2. Then, copy your impulse response WAV file to `Dsp/filter-sources`.
3. Go to the plugin setting page and under `DRC-FIR Filter Creation` turn on the `DRC-FIR Settings`
4. Choose the Impulse response from step 2 as file to convert.
5. Choose a target curve. Some samples are provided with the plugin. Custom curves can be made as above and saved in `Dsp\target-curves`
6. Choose a config.
    - We advise to start with __'soft'__ and see how it behaves. Information about these configs can be found on the DRC-FIR Github Documentation [ : DRC-FIR](http://drc-fir.sourceforge.net/)
7. You can give a name to your filter or leave it empty to use the measurement impulse file name. 
    - The plugin will add `samplerate+config+target-curves+.pcm` to the name.
    - So, if name is __left__ the generated filter may be __left-44.1kHz-soft-hk5.pcm__
8. Press `Create filter` and wait until the page is refreshed. 
9. If creating separate L and R filters then repeat Steps 1-8 for the other channel. 

<img src="./img/filter-creation-menu.png">



### Now, get ready to test your filter!
