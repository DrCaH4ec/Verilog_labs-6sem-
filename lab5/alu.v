`timescale 1 ns / 10 ps

module alu(op_a, op_b, opsel, res, cf);

input [7:0] op_a;
input [7:0] op_b;
input [1:0] opsel;

output [7:0] res;
output cf;

reg [8:0] temp;
initial temp = 0;

assign res = temp[7:0];
assign cf = temp[8];

always @* begin
	casez(opsel)
		0: temp =  (op_a << 1) + op_b; //this operation was optimized
		1: temp = op_a;
		2: temp = op_a + 1;
		3: temp = op_a - op_b - 1;
	endcase
end

endmodule
