`timescale 1 ns/10 ps

`define PERIOD 4

module tb();

reg clk;
reg x;
reg y;
reg ARstN;

wire [1:2] z;

fsm fsm_0(clk, x, y, z, ARstN);

initial begin
	clk = 0;
	forever #(`PERIOD/2) clk = ~clk;
end

initial begin
	x = 0;
	y = 0;

	ARstN = 1;
	#5 ARstN = 0;
	#3 ARstN = 1;
end

initial
	forever #(`PERIOD) x = $random;

initial
	forever #(`PERIOD) y = $random;	

initial #120 $stop();


endmodule
