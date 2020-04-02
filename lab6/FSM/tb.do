transcript on

vlib work

vlog -sv +incdir+./ ./*.v

vsim -t 1ns -voptargs="+acc" tb

add wave /tb/clk
add wave /tb/x
add wave /tb/y
add wave /tb/z
add wave -radix ASCII /fsm_0/state
add wave /tb/ARstN

configure wave -timelineunits us
run -all
wave zoom full