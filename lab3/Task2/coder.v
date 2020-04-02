`timescale 1 ns / 10 ps


module coder(x, y);

input [8:0] x;

output reg [3:0] y;

always @* begin
	casez(x)
		9'b000000000: y = -5;//-5
		9'b000000001: y = -4;//-4
		9'b000000010: y = -3;//-3
		9'b000000100: y = -2;//-2
		9'b000001000: y = -1;//-1
		9'b000010000: y = 0;//0
		9'b000100000: y = 1;//1
		9'b001000000: y = 2;//2
		9'b010000000: y = 3;//3
		9'b100000000: y = 4;//4
		default: y = 4'bz;
	endcase
end

endmodule
