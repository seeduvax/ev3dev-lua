local ffi=require "ffi"

ffi.cdef[[
	void sleep(int s);
]]

sleep=ffi.C.sleep
