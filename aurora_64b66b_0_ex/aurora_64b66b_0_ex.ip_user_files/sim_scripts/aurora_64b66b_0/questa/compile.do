vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm

vlog -work xil_defaultlib -64 -sv \
"/opt/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/opt/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"/opt/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"/opt/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_aurora_lane.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_rx_startup_fsm.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_tx_startup_fsm.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/example_design/aurora_64b66b_0_axi_to_drp.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_standard_cc_module.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_reset_logic.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_cdc_sync.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0_core.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_axi_to_ll.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_block_sync_sm.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_common_reset_cbcc.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_common_logic_cbcc.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_cbcc_gtx_6466.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_channel_err_detect.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_channel_init_sm.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_ch_bond_code_gen.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_64b66b_descrambler.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_err_detect.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_global_logic.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/example_design/gt/aurora_64b66b_0_wrapper.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_polarity_check.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_lane_init_sm.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_ll_to_axi.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/example_design/gt/aurora_64b66b_0_multi_wrapper.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_rx_ll_datapath.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_rx_ll.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_width_conversion.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_64b66b_scrambler.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_sym_dec.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_sym_gen.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/example_design/gt/aurora_64b66b_0_gtx.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_tx_ll_control_sm.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_tx_ll_datapath.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0/src/aurora_64b66b_0_tx_ll.v" \
"../../../../aurora_64b66b_0_ex.srcs/sources_1/ip/aurora_64b66b_0/aurora_64b66b_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

