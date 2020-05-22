#!/usr/bin/env luajit

require "sysutils"
ev3=require "ev3"
-- set IR Sensor to Remote command mode
ev3.sensor2:setMode("IR-REMOTE")
-- active motor speed.
local s=0.5
while true do
	local speedLeft=0
	local speedRight=0
	-- get IR sensor state
	local v=ev3.sensor2:getValues()[1];
	if v==3 then
		-- key top-right pressed, move forward
		speedRight=s
		speedLeft=s
	elseif v==4 then
		-- key bottom-right pressed, move backward
		speedRight=-s
		speedLeft=-s
	elseif v==7 then
		-- keys top-right + bottom-left, rotate left
		speedRight=s
		speedLeft=-s
	elseif v==6 then
		-- keys top-left + bottom-right, rotate right
		speedRight=-s
		speedLeft=s
	end
	-- apply computed speed to motors
	ev3.motorC:run(speedLeft)
	ev3.motorB:run(speedRight)
end
