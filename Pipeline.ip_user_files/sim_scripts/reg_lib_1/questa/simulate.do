onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib reg_lib_opt

do {wave.do}

view wave
view structure
view signals

do {reg_lib.udo}

run -all

quit -force
