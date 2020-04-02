transcript on

vlib work

vlog -sv +incdir+./ ./*.v

vsim -t 1ns -voptargs="+acc" tb

add wave -radix unsigned /tb/addr
add wave -radix binary /tb/x
add wave /tb/en
add wave /tb/y
configure wave -timelineunits us
run -all
wave zoom full