#!/usr/bin/env luajit

require "sysutils"
ev3=require "ev3"

while true do
	local v=ev3.sensor2:getValues();
	print(">> "..v[1])
	sleep(1)
end
