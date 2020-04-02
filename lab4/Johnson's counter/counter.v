`timescale 1 ns / 10 ps

module counter(clk, out, ARstN);

input clk;
input ARstN;

output reg [3:0] out;


always @(posedge clk or negedge ARstN) begin
	if(!ARstN)
		out = 0;
	else begin
		if(!out[3])
			out = (out << 1) | 1;
		else
			out = (out << 1);
	end
end

endmodule
