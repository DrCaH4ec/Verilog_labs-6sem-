transcript on

vlib work

vlog -v +incdir+./ ./*.v

vsim -t 1ns -voptargs="+acc" tb

add wave -radix decimal /tb/InA_Re
add wave -radix decimal /tb/InA_Im

add wave -radix decimal /tb/InB_Re
add wave -radix decimal /tb/InB_Im

add wave -radix hexadecimal /tb/Res_Re
add wave -radix hexadecimal /tb/Res_Im

add wave -radix decimal /tb/Res_Re
add wave -radix decimal /tb/Res_Im

add wave -radix unsigned /tb/OpSel

add wave /tb/OF_Re
add wave /tb/OF_Im

add wave /tb/mode


configure wave -timelineunits us
run -all
wave zoom full