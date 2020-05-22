#!/usr/bin/env luajit

require "sysutils"
ev3=require "ev3"
-- Set sensor mode to proximity detection
ev3.sensor2:setMode("IR-PROX")

while true do
	local v=ev3.sensor2:getValues();
	-- define speed from the gap between the current distance
	-- and the target distance fo 30.
	local speed=(v[1]-30)/30
	-- manage speed saturation
	if speed > 1 then
		speed=1
	elseif speed < -1 then
		speed=-1
	end
	-- apply speed
	ev3.motorB:run(speed)
	ev3.motorC:run(speed)
end
