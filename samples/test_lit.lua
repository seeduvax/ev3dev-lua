#!/usr/bin/env luajit

require "ev3dev_ffi"

ev3.ev3_init()
ev3.set_light(EV3.LIT_LEFT,EV3.LIT_OFF)
ev3.set_light(EV3.LIT_RIGHT,EV3.LIT_OFF)
ffi.C.sleep(1)
ev3.set_light(EV3.LIT_LEFT,EV3.LIT_GREEN)
ffi.C.sleep(1)
ev3.set_light(EV3.LIT_LEFT,EV3.LIT_RED)
ffi.C.sleep(1)
ev3.set_light(EV3.LIT_LEFT,EV3.LIT_AMBER)
ffi.C.sleep(1)
ev3.set_light(EV3.LIT_LEFT,EV3.LIT_OFF)
ev3.set_light(EV3.LIT_RIGHT,EV3.LIT_GREEN)
ffi.C.sleep(1)
ev3.set_light(EV3.LIT_RIGHT,EV3.LIT_RED)
ffi.C.sleep(1)
ev3.set_light(EV3.LIT_RIGHT,EV3.LIT_AMBER)
ffi.C.sleep(1)
ev3.set_light(EV3.LIT_RIGHT,EV3.LIT_OFF)
ffi.C.sleep(1)
ev3.ev3_uninit()
