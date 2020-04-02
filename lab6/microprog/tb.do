transcript on

vlib work

vlog -sv +incdir+./ ./*.v

vsim -t 1ns -voptargs="+acc" tb

add wave /tb/clk
add wave /tb/x
add wave -radix ASCII /tb/y
add wave /tb/ARstN

configure wave -timelineunits us
run -all
wave zoom full