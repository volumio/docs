# Some Basics about Hardware Design
This page is for those users, who do not have experience with electronics but are still enthusiastic to play with their Raspi and Volumio to realize their own project.

I do not claim, that this is the ultimate guide, but many of the problems reported by people on the forums seem to come from basic mistakes in the hardware setup. So here come some tipps for a robust design.

## Raspberry Pi Do's and Dont's
* GPIO pins are specified for 3.3V (3V3), do not connect them to higher voltages even if a YouTuber or a DIY web-page tells you that it can withstand it. You are operating outside the specification and misuse the ESD protection. Overvoltage should stay a rare 'event', not become a state. 
* Even if you only connect 3.3V, higher spikes are possible, due to electro-static discharge (ESD), capacitive and inductive components (like long cables). Take care of ESD, use a limiting resistor and a capacitor to control the slew (how fast the voltage on the pad changes). Do not use unneccessarily long cables, connect GND before connecting any signal...
* Never short a power output directly to ground, your Pi *may* survive, but it may also die. You are operating beyond the AMR values (absolute max ratings), where Powers beyond the engineers influence are at work - the danger zone.

The image below shows quite a safe external wiring schematic for an RPi GPIO, that works in most cases, if the resistor and capacitor values are picked correctly. Below I try to explain, what to consider when picking them.

![Safe wiring of a Raspberry Pi GPIO](./img/PU_PD.jpg)
*The left schematic shows a GPIO with a Pull-up resistor R_PU, a limiting resistor R_lim and a decoupling capacitor C. The right hand side has the same schematic but with a Pull-Down resistor instead.*

## What is a Pull-Up or Pull-Down Resistor and why do I need it?
A digital input pin that is not connected to any defined reference potential is isolated from its surroundings. It can have any electric potential, meaning that its voltage compared to GND can have all kinds of values, depending on the charge it carries and potentially changing with electromagnetic fields in its vicinity. 

It is called a 'floating' pin. And since it is something like a tiny capacitor or even worse, a tiny antenna, depending on its charge, it may be in the logical HIGH state (>1.6V for a RPi input), but also in the logical LOW state (<0.9V) - or anywhere in between.
A floating input is undesirable, because its state is undeterminate and so is its behavior when reading it.
This is overcome, by connecting it to either HIGH (3.3V) or LOW (0V) potential via a resistor.
![Schematic of a Pull-Up and a Pull-Down resistor](./img/PU_PD_simple.jpg)
*Schematics of a simple pull-up (PU) and pull-down (PD) resistor. If the switch is open, the GPIO is on the same potential (i.e. it has the same voltage) as the reference (PU:3.3V, PD:GND). When the button is closed, a small current flows from 3.3V to GND and the potential at the GPIO changes (PU:GND, PD:3.3V). You could also interpret the combination of resistor and switch as a voltage divider, where the open switch has infinite resistance and the closed switch 0 Ohms.*

The Raspberry Pi has integrated Pull-up and Pull-down resistors inside its microprocessor chip, which can be activated by the system at boot time. But it is also possible to connect external resistors to the pin (and there are reasons to do so). [See below](#why-does-it-matter-for-playing-with-my-raspberry-pi).

## What is a limiting resistor?
A limiting resistor is connected to the GPIO pin in such a way, that all current into or out of the pin has to pass the resistor. The limiting resistor will determine the maximum current out of the pin, as long as the max voltage is controlled and it is not bypassed or shorted.
When configured as output, the pin has minimum current values that it can safely drive, to give a well-defined HIGH and LOW state, called I_OH and I_OL. 

Suppose you connect a circuit to your RPi, that shorts a GPIO to GND, because you configured it as input and want to drive it low. Suppose now, that you load a software, that wants to use the same pin as output and configures it to HIGH. What happens is, that the RPI tries to bring the pad up to 3.3V, while it is shorted to GND - it will not succeed, but it may get permanently damaged doing so. 

The same thing happens, if the pad is connected to 3.3V and you configure it as output and try to put it to LOW. Now the Pi will try to pull the pad to 0V and current will flow uncontrolled into the pad. The limiting resistor will keep the current limited, even if you accidentally load a software that mis-configures your GPIO. 

1kOhm will limit the current to 3.3V/1kOhm = 3.3mA, which should be low enough, to get the high level at 2.6V or higher and the LOW level at 0.4V or lower, since both are specified at 4mA drive strength. So even an accidental setting as output will never damage your pin. 2kOhm may even be a better choice, since the Pi can supply only 3mA on all pins simultaneously.
See the [Raspberry Pi Documentation for details](https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#voltage-specifications).

## What is the capacitor good for?
The capacitor between the GPIO and ground will smooth things out - it will attenuate mechanically induced bounce and ringing from the line and will reduce high frequency noise. Thus it will help protect your input and make the signal more stable. It will also generate less interrupts at the GPIO, because the smoothing out of high-frequency noise will reduce the edges, that the microprocessor needs to react on.
Together with the resistors is forms an RC-filter. You can either use *C=100nF* as a rule of thumb or calculate the proper value based on your button bounce specification as shown in the [Debouncing section](./01_Debouncing.md).

## Do I need all those three elements?
Well, yes and no. It depends on your use of the system. As explained, using all three of them adds some safety and protection to your GPIO. It makes damaging it more unlikely. 
However, you can leave out the pull-resistor and use the internal ones and you can leave out the limiting resistor, if you make sure the input is never accidentally reconfigured the wrong way. You can also leave away the capacitor - but without the three cheap components, the system has a less robust design and leaves more responsibility with the user and the programmer.

## Why does it matter for playing with my Raspberry Pi?
A modern GPIO (General Purpose Input/Output) in a microprocessor typically has plenty of configurable properties. It can be an input or an output or in a High-Impedance (high-Z) state. The input can be floating, have a pull up or a pull down. The output sometimes has configurable drive strength etc.
To connect buttons and rotary encoders (which are actually kind of buttons) we typically use the GPIOs as inputs. So we may want to use the built-in pull-up (PU) and pull-down (PD) resistors, which can be activated by setting registers in the chip - for volumio this is already configured at boot up. The internal pull-resistors of the RPi [are around 50-65kOhms](https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#voltage-specifications).
The advantage of using them is, that you do not need to buy external resistors and solder them to a board - it saves you a few cents and some space. However, if you experiment with your Pi and change the GPIO configuration you may create undesired states (e.g. you use a switch to pull a GPIO with internal PU to ground, now you configure the GPIO as output, while the switch is closed and still connected).

![Simplified schematic of a GPIO configured as input. Output functionality is not shown for simplicity](./img/GPIO_in.jpg)

*Simplified schematic of the internal wiring of a GPIO pin. Output functionality is not shown for simplicity. The input pin (GPIO) is internally connected to GND and and 3.3V via two protective diodes, for Overvoltage and ESD protection. The input itself is then connected to a Schmitt-Trigger, that has a high-impedance input. To prevent the input from floating, it can be either wired to 3.3V via the PU or to GND via the PD. Instead of a switch, the internal Pulls are activated via CMOS devices.
It is also possible, to deactivate both - the GPIO will have high impedance and may float if not externally pulled.*

## Is it a problem if I use internal and external Pull-resistors at the same time?
Even if the interal PU or PD is set, you can still connect an external PU or PD. Just be aware, that the values need to match each other.

![GPIO with internal PU and external PD](./img/extPD_intPU.jpg)
*Example of a circuit with internal Pull-up activated and external Pull-down + limiting Resistor connected. This is still working without issues, if the resistor values are matching.*

What happens if you activate internal PU and connect external PD? 
* Switch open:
    * Current of *I = 3.3V / (R_PU + R_lim + R_PD)* will flow from the internal 3.3V rail via the R_PU to the pin and then via R_lim and R_PD to GND.
    * The voltage at the input of the Schmitt-Trigger will be *V_in = 3.3V x (R_PD + R_lim) / (R_PD + R_PU + R_lim)*
    * Since the input is supposed to be logical LOW, the [V_in should be  <= V_IL=0.9V](https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#voltage-specifications). 
    This means, that R_PD + R_lim <= R_PU / (3.3V / 0.9V - 1)=18.75kOhm (with R_PU = 50kOhm). This means, that the external pull-down resistor should be smaller than 16.75kOhms if we pick R_lim = 2kOhm. Otherwise, the voltage-devider formed by external and internal resistor will bring your voltage at the Schmitt-Trigger Input into the undefined zone between HIGH and LOW. 10kOhm is a good value. 
    * The current over all the three resistors will only be 3.3V/(50kOhm + 2kOhm + 10kOhm) = 53µA
    * If the the GPIO gets accidentally configured as Output and pulled high, the current will be 275µA.
* Switch closed:
    * Current will flow over the switch and the external PD and will be *I = 3.3V / 10kOhm = 330µA*
    * Voltage at the Schmitt-Trigger input will be the full *V = 3.3V, since the internal PU is shorted by the switch.
    * If the GPIO gets accidentally configured as output and pulled low, the current will be 1.65mA

## How to determine the default configuration of your GPIOs?
* By default, GPIO BCM2...8 should be pulled high at boot and GPIO BCM9...27  pulled-low.
* On Raspberry Pi 4, you can issue `raspi-gpio get` to read the current setting of the GPIO pins
* On older versions of the Pi, this is not available and there is no simple method to determine the state
* Using a multimeter to measure the voltage at the pin is not reliable, since the multimeter is high-ohmic and may not correctly show the voltage of a floating pin
* You can try to read out the pin state directly after boot, but that may also give you wrong info for floating pins because it just gives you the reading at the Schmitt-Trigger (remember the paragraph about pull-up and pull-down resistors).
* Below is the output of a `gpio readall` on one of my Volumio RPi's.

```
 +-----+-----+---------+------+---+---Pi 2---+---+------+---------+-----+-----+
 | BCM | wPi |   Name  | Mode | V | Physical | V | Mode | Name    | wPi | BCM |
 +-----+-----+---------+------+---+----++----+---+------+---------+-----+-----+
 |     |     |    3.3v |      |   |  1 || 2  |   |      | 5v      |     |     |
 |   2 |   8 |   SDA.1 | ALT0 | 1 |  3 || 4  |   |      | 5v      |     |     |
 |   3 |   9 |   SCL.1 | ALT0 | 1 |  5 || 6  |   |      | 0v      |     |     |
 |   4 |   7 | GPIO. 7 |   IN | 1 |  7 || 8  | 1 | ALT0 | TxD     | 15  | 14  |
 |     |     |      0v |      |   |  9 || 10 | 1 | ALT0 | RxD     | 16  | 15  |
 |  17 |   0 | GPIO. 0 |   IN | 0 | 11 || 12 | 0 | IN   | GPIO. 1 | 1   | 18  |
 |  27 |   2 | GPIO. 2 |   IN | 0 | 13 || 14 |   |      | 0v      |     |     |
 |  22 |   3 | GPIO. 3 |   IN | 0 | 15 || 16 | 0 | IN   | GPIO. 4 | 4   | 23  |
 |     |     |    3.3v |      |   | 17 || 18 | 0 | IN   | GPIO. 5 | 5   | 24  |
 |  10 |  12 |    MOSI |   IN | 0 | 19 || 20 |   |      | 0v      |     |     |
 |   9 |  13 |    MISO |   IN | 0 | 21 || 22 | 0 | IN   | GPIO. 6 | 6   | 25  |
 |  11 |  14 |    SCLK |   IN | 0 | 23 || 24 | 1 | IN   | CE0     | 10  | 8   |
 |     |     |      0v |      |   | 25 || 26 | 1 | IN   | CE1     | 11  | 7   |
 |   0 |  30 |   SDA.0 |   IN | 1 | 27 || 28 | 1 | IN   | SCL.0   | 31  | 1   |
 |   5 |  21 | GPIO.21 |   IN | 1 | 29 || 30 |   |      | 0v      |     |     |
 |   6 |  22 | GPIO.22 |   IN | 1 | 31 || 32 | 1 | IN   | GPIO.26 | 26  | 12  |
 |  13 |  23 | GPIO.23 |   IN | 0 | 33 || 34 |   |      | 0v      |     |     |
 |  19 |  24 | GPIO.24 |   IN | 0 | 35 || 36 | 1 | IN   | GPIO.27 | 27  | 16  |
 |  26 |  25 | GPIO.25 |   IN | 0 | 37 || 38 | 0 | IN   | GPIO.28 | 28  | 20  |
 |     |     |      0v |      |   | 39 || 40 | 0 | IN   | GPIO.29 | 29  | 21  |
 +-----+-----+---------+------+---+----++----+---+------+---------+-----+-----+
 | BCM | wPi |   Name  | Mode | V | Physical | V | Mode | Name    | wPi | BCM |
 +-----+-----+---------+------+---+---Pi 2---+---+------+---------+-----+-----+
 ```

 The table shows an ASCII representation of the pin header in the center + additional info:
 * Physical pins with physical numbering in the center (Pin 1 has a square solderpad on the RPi PCB)
 * The columns titled *V* show you the current value of the pin. 1 means logical *High* and 0 means logical *Low*. Since nothing is connected, This typically tells you, if the pin has the internal Pull-up or Pull-Down resistors activated, but for a floating pin, it can be random.
 * Mode tells you, how the pin is configured:
    * IN is an Input, e.g. for connecting a button or rotary encoder
    * OUT is an Output, e.g. for connecting an LED
    * ALTx is an alternative assignment, e.g. a communication interface (SPI, I2C, ...)
* Name is the name of the pin and tells you something about it's function:
    * 3.3v and 5v are outputs (as mentioned, never connect the 5v to a GPIO)
    * 0v is a Ground (GND) pin - this is the reference potential for your schematic
    * GPIO.xx is a *General Purpose Input/Output* meaning, that you are free to configure it as you need
    * SDA, SCL, MOSI, MISO, SCLK, TxD, RxD, CE0, CE1 are various communication interfaces (you can google for RS232, SPI, I2C for details)
be carefull, there are breakout-boards that use the BCM numbering, mine e.g. has 'GPIO21' printed beside pin 40.
* wPi column contains the Pin number in the wiringPi notation (same as in the GPIO name)
* BCM tells you the *Broadcom* pin number as in the datasheet of the Manufacturer of the RPi microprocessor **This is the Pin number that is used in the Plugin settings**

**ATTENTION: Careful what pin numbering you use!**

As you can see from the table, my GPIOs with BCM2...8 are '1' as expected, but BCM12 and BCM16 are also high, while they should be low. So it is hard to rely on this info. Making a safe design even more important.

If you connect a DAC-HAT like e.g. HifiBerry to the Pin-Header, it will reserve some pins for various functions. Those pins cannot be used for any other purpose. Check in the documentation of the HAT or try to figure out by running `gpio readall` with the HAT connected and the driver loaded.

## How to wire a rotary encoder
Since many people report problems with wiring their rotary encoder, I'll show an example for clean wiring to your Raspberry Pi. This is not the minimal solution and you can do it with less components, but if you play with your Raspberry, it will add some safety to your schematic.

![Rotary encoder with push button wired to RPi.](./img/rotary%20with%20r%20and%20c.jpg)
*The image shows a rotary with three pull-up resistors (green), three limiting resistors (orange) and three capacitors, that reduce bounce and control the edge of the signal. For any regular rotary encoder, this is a working solution.
The KY-040 used by some people on their Volumio system, is a rotary encoder soldered to a small PCB with two pull-up resistors already included in the same board. I indicate that by the red dashed box. If you use it, you will not need Pull-Ups for the two channels of the rotation. You may still want to add limiting resistors and decoupling capacitors to the KY-040, potentially with an extra pull-up or pull-down for the switch.*


