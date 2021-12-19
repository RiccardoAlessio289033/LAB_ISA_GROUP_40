set power_preserve_rtl_hier_names true
elaborate fpmul_pipeline -arch pipeline -lib WORK > ./elaborate_fmax_ultra.txt
uniquify
link
create_clock -name MY_CLK -period 1.53 clk
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] clk]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]
compile_ultra
report_timing > report_fmax_ultra.txt
report_area >> report_fmax_ultra.txt
