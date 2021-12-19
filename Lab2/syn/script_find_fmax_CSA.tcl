set power_preserve_rtl_hier_names true
elaborate fpmul_pipeline -arch pipeline -lib WORK > ./elaborate_find_fmax_CSA.txt
uniquify
link
create_clock -name MY_CLK -period 0.0 clk
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] clk]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set_implementation DW02_mult/csa I2/mult_134
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]
compile
report_timing > find_fmax_CSA_report.txt
ungroup -all -flatten
change_names -hierarchy -rules verilog
write_sdf ../netlist/fpmul_pipeline_CSA.sdf
write -f verilog -hierarchy -output ../netlist/fpmul_pipeline_CSA.v
write_sdc ../netlist/fpmul_pipeline_CSA.sdc
