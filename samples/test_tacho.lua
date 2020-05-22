#!/usr/bin/env luajit


require "sysutils"
ev3=require "ev3"

ev3.motorB:run(0.2)
ev3.motorC:run(0.2)
sleep(1)
if ev3.motorD then
    ev3.motorD:run(1)
end
ev3.motorB:run(-0.2)
ev3.motorC:run(-0.2)
sleep(1)

ev3:reset()


