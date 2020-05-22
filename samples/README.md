# ev3dev-lua sample programs

## Hardware configuration
The robot configuration used for most sample programs introduced here is the following:

```
		 +--+
		 |IR|
	       +-+--+----+
	  ==   |         |   ==
	  ==   |   EV3   |   ==
	  ==---+         +---==
	  == TM|         |TM ==
	  ==---+         +---==
	  ==   +---------+   ==

```

 - IR: Infra Red sensor connected to input port #2
 - TM: Tacho motors
   - left is connected to output port #C
   - right is connected to output port #D

## Software configuration

[ev3dev](https://www.ev3dev.org) operating system with luajit package.
The easiest install is to copy all files in robot's home directory and set executable flag (`chmod +x`) to the lua scripts. Copy also the [ev3.lua](../src/ev3.lua) and [sysutils.lua](sysutils.lua) at the same location.

## Sample programs

  - [test_sensor.lua](test_ensor.lua): display continuously the IR sensor's 1st value.
  - [test_tacho.lua](test_tacho.lua): move forward during 1 second, move backward during 1 second, then stop.
  - [distance.lua](distance.lua): try to keep its distance from an object in front of the IR sensor. Move toward when too far and move backward when too close.
  - [irRemote.lua](irRemote.lua): Drive the bot with the IR remote controller using a not so natural key mapping (see code for details).
