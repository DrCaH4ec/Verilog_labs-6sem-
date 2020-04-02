`timescale 1 ns / 10 ps

module tb();

reg clk;
reg ARstN;

wire [3:0] out;

counter counter_0(clk, out, ARstN);

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

initial begin
	ARstN = 0;
	#5 ARstN = 1;

	#100 $stop();
end

endmodule
