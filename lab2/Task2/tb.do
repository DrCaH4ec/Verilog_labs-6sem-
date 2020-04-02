transcript on

vlib work

vlog -sv +incdir+./ ./*.v

vsim -t 1ns -voptargs="+acc" tb

add wave /tb/*
configure wave -timelineunits us
run -all
wave zoom full