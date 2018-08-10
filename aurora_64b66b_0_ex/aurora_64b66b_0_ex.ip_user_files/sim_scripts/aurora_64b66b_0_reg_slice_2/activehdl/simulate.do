onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+aurora_64b66b_0_reg_slice_2 -L xil_defaultlib -L xpm -L axis_infrastructure_v1_1_0 -L axis_register_slice_v1_1_16 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.aurora_64b66b_0_reg_slice_2 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {aurora_64b66b_0_reg_slice_2.udo}

run -all

endsim

quit -force
