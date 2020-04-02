`timescale 1 ns / 10 ps
//3)	F = A’*B*(C*B*A’ + B*C’) ;
//	F = A’*B ;
module scheme_2(x, y, y_min);
	
input [2:0] x;

output y;
output y_min;

assign y_min = ~x[0] & x[1];
assign y = ~x[0] & x[1] & (x[2] & x[1] & ~x[0] | x[1] & ~x[2]);

endmodule
