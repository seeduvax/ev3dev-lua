
-- **
-- * Basic object handling
Object={
	def=function(t,e) 
		local this={}
		if e then
			this=e
		end
		for k,v  in pairs(t) do
			if type(v)=="function" and k~="new" then
				this[k]=v
			end
		end
		return this
	end
}

-- **
-- * Generic device with file interface to get/set attributes
Device={
	new=function(class,rootDir)
		local this=Object.def(class)
		this._rootDir=rootDir
		return this;	
	end,
	_getAttr=function(this, name) 
		local p=this._rootDir.."/"..name
		local f=io.open(p,'r')
		local v=f:read()
		f:close()
		return v
	end,
	_getNAttr=function(this,name) 
		return tonumber(this:_getAttr(name))
	end,
	_setAttr=function(this, name, value)
		local p=this._rootDir.."/"..name
		f=io.open(p,'w')
		local v=f:write(""..value)
		f:close()
	end
}

-- **
-- * LED Device
LED={
	new=function(class,rootDir)
		local this=Device:new(rootDir)
		Object.def(class,this)
		this._maxBrightness=this:_getNAttr("max_brightness")
		return this
	end,
	getBrightness=function(this)
		return this:_getNAttr("brightness")/this._maxBrightness
	end
} 
-- **
-- * Tacho motor device
TachoMotor={
	new=function(class,rootDir)
		local this=Device:new(rootDir)
		Object.def(class,this)
		this._maxSpeed=this:_getNAttr("max_speed")
		this:_setAttr("stop_action","coast")
		return this
	end,
	-- **
	-- * return current speed. Returned value is negative
	-- * when polarity is inversed
	-- * speed is [-1;1] float value where 1 means max speed.
	getSpeed=function(this)
		local s=this:_getNAttr("speed")/this._maxSpeed
		if this:_getAttr("polarity")=="normal" then
			return s
		else
			return -s
		end
	end,
	-- **
	-- * Run forever a given speed
	-- * @param speed [-1;1] value. 1 means max speed, negative
	-- * value means inversed polarity
	run=function(this,speed)
		if speed>=0 then
			this:_setAttr("polarity","normal")
			this:_setAttr("speed_sp",math.floor(speed*this._maxSpeed))
		else
			this:_setAttr("polarity","inversed")
			this:_setAttr("speed_sp",math.floor(-speed*this._maxSpeed))
		end
		this:_setAttr("command","run-forever")
	end,
	-- **
	-- * Stop motor
	stop=function(this)
		this:_setAttr("command","stop")
	end,
	-- **
	-- * Reset motor (make it stop and reset all motor parameters to
	-- * default value)
	reset=function(this)
		this:_setAttr("command","reset")
	end
}
-- **
-- * Lego Sensor
LegoSensor={
	new=function(class,rootDir)
		local this=Device:new(rootDir)
		Object.def(class,this)
		this._nbValues=this:_getNAttr("num_values")
		return this
	end,
	getMode=function(this)
		return this:_getAttr("mode")
	end,
	setMode=function(this,mode)
		this:_setAttr("mode",mode)
		this._nbValues=this:_getNAttr("num_values")
	end,
	getValues=function(this)
		local v={}
		for i=0,this._nbValues-1 do
			v[i+1]=this:_getNAttr("value"..i)
		end
		return v
	end,
	reset=function(this)
	end
}

local ev3={
	motor={},
	sensor={},
	reset=function(this)
		for k, v in pairs(this.motor) do
			v:reset()
		end
	end,
	setupDevices=function(this,rootDir,table,prefix,class,name)
		for dir in io.popen("ls "..rootDir):lines() do
			if string.sub(dir,1,#prefix)==prefix then
				local d=class:new(rootDir..dir)
				table[#table+1]=d
				local addr=d:_getAttr("address")
				local port=string.sub(addr,#addr,#addr)
				print("Found "..name.." plugged on port "..port)
				this[prefix..port]=d
			end
		end
	end,
	init=function(this)
		this:setupDevices("/sys/class/tacho-motor/",this.motor,"motor",TachoMotor,"tacho motor")
		this:setupDevices("/sys/class/lego-sensor/",this.sensor,"sensor",LegoSensor,"lego sensor")
	end,
	reset=function(this)
		for k,v in pairs(this.motor) do
			v:reset();
		end
		for k,v in pairs(this.sensor) do
			v:reset();
		end
	end

}

ev3:init()

return ev3
