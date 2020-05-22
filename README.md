# ev3dev-lua

## What
ev3dev-lua is a lua library to create robot software running on the [ev3dev](https://www.ev3dev.org/) platform. It binds high level lua objects to the ev3dev sysfs user interface.
It may provide in the future additional utilities such as timer to support development of robotic application.

## Getting started
Copy the library files from the [src](src) directory to your system wide lua library directory. Then write your lua script, just begin with the lib use directive. For instance assuming there is on tacho motor plugged on EV3 output port B and one sensor on input port 3:
``` 
ev3=require "ev3"
-- start motor at half speed
ev3.motorB:run(0.5)
-- get sensor values and print first
local v=ev3.sensor3:getValues()
print("Sensor 3 v[1]="..v[1])
-- run motor revered polarity quarter speed
ev3.motorB:run(-0.25)
-- stop motor
ev3.motorB:stop()
``` 
Of course running the script above will not give spectacular results, since chaining the motor commands without any delay will not give enough time to see something happen.

## See examples
The [samples](samples) directory hosts some examples of use of the ev3dev-lua library.

Caution: most examples require luajit and ffi to bind to the standard lib C's sleep function. But the ev3dev-lua library should run as well using any lua flavor from 5.0 to 5.3 and probably next when available.
