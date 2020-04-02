transcript on

vlib work

vlog -sv +incdir+./ ./*.v

vsim -t 1ns -voptargs="+acc" tb


add wave /tb/clk
add wave /tb/ARstN
add wave /tb/out

configure wave -timelineunits us
run -all
wave zoom full