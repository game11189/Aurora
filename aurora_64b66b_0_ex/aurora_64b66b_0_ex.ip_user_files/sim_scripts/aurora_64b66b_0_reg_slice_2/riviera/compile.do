vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm
vlib riviera/axis_infrastructure_v1_1_0
vlib riviera/axis_register_slice_v1_1_16

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm
vmap axis_infrastructure_v1_1_0 riviera/axis_infrastructure_v1_1_0
vmap axis_register_slice_v1_1_16 riviera/axis_register_slice_v1_1_16

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../ipstatic/hdl" "+incdir+../../../ipstatic/hdl" \
"/opt/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/opt/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"/opt/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"/opt/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axis_infrastructure_v1_1_0  -v2k5 "+incdir+../../../ipstatic/hdl" "+incdir+../../../ipstatic/hdl" \
"../../../ipstatic/hdl/axis_infrastructure_v1_1_vl_rfs.v" \

vlog -work axis_register_slice_v1_1_16  -v2k5 "+incdir+../../../ipstatic/hdl" "+incdir+../../../ipstatic/hdl" \
"../../../ipstatic/hdl/axis_register_slice_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic/hdl" "+incdir+../../../ipstatic/hdl" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0_reg_slice_2/sim/aurora_64b66b_0_reg_slice_2.v" \

vlog -work xil_defaultlib \
"glbl.v"

