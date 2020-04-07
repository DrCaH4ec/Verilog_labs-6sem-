transcript on

vlib work

vlog -v +incdir+./ ./*.v
vlog -v +incdir+./ ./alu/*.v

vsim -t 1ns -voptargs="+acc" mips_core_tb

add wave /mips_core_tb/CLOCK_27
add wave /mips_core_tb/KEY_sig
add wave -radix hexadecimal /mips_core_inst/reg_file_0/regs



configure wave -timelineunits us
run -all
wave zoom full