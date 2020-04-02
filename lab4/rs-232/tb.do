transcript on

vlib work

vlog -sv +incdir+./ ./*.v

vsim -t 1ns -voptargs="+acc" tb


add wave /tb/clk_r
add wave /tb/clk_t

add wave /tb/data
add wave /tb/data_p
add wave /tb/d_out

add wave /tb/d_in

add wave /tb/en

add wave /tb/ParityCheck
add wave /tb/err

add wave /tb/busy

add wave -radix unsigned /tb/state

configure wave -timelineunits us
run -all
wave zoom full