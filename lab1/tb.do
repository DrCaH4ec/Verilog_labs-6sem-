transcript on

vlib work

vlog -sv +incdir+./ ./*.v

vsim -t 1ns -voptargs="+acc" tb

add wave -radix unsigned /tb/ina
add wave -radix unsigned /tb/inb
add wave -radix unsigned /tb/out
add wave /tb/clk
add wave /tb/clr
configure wave -timelineunits us
run -all
wave zoom full