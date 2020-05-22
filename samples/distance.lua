#!/usr/bin/env luajit

require "sysutils"
ev3=require "ev3"

while true do
	local v=ev3.sensor2:getValues();
	local speed=(v[1]-30)/30
	
	if speed > 1 then
		speed=1
	elseif speed < -1 then
		speed=-1
	end
	ev3.motorB:run(speed)
	ev3.motorC:run(speed)
end
