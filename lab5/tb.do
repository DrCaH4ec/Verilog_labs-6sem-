transcript on

vlib work

vlog -sv +incdir+./ ./*.v

vsim -t 1ns -voptargs="+acc" tb

add wave -radix unsigned /tb/op_a
add wave /tb/op_a
add wave -radix unsigned /tb/op_b
add wave /tb/op_b
add wave -radix unsigned /tb/opsel
add wave -radix unsigned /tb/res
add wave /tb/res
add wave /tb/cf

configure wave -timelineunits us
run -all
wave zoom full