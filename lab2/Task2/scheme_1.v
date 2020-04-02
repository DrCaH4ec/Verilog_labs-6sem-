`timescale 1 ns / 10 ps

module scheme_1(x, y);
	
input [2:0] x;
//x1 = HiZ
output y;

assign y = ((x[0] | ~x[1]) & x[2]) | (~x[0] & x[1] & ~x[2]);

endmodule
