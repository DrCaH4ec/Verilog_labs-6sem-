`timescale 1 ns/10 ps

`define PERIOD 4

module tb();

reg clk;
reg [3:1] x;
reg ARstN;

wire [15:0] y;

microprog microprog_0(clk, x, y, ARstN);

initial begin
	clk = 0;
	forever #(`PERIOD/2) clk = ~clk;
end

initial begin
	x = 3'b000;	

	ARstN = 1;
	#5 ARstN = 0;
	#3 ARstN = 1;

	for(x = 0; x < 7; x = x + 1) begin
		#30 ARstN = 0;
		#2 ARstN = 1;
	end

	#30 ARstN = 0;
	#2 ARstN = 1;

	$stop();
end

endmodule
