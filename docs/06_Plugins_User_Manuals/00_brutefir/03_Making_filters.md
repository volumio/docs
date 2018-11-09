## Making Filters

When measurement(s) is exported you have 2 possibilities. You can create initial EQ filter in REW and import it into rePhase as a starting point or you can directly go in rephase and start creating filter from scratch.

### Variant 1 : Creating initial EQ filter in REW

* On the right side of EQ window under Equaliser choose `rePhase`

* Under Target settings configure settings for your speakers

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

### Now, get ready to test your filter!
