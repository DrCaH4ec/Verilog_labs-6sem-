`timescale 1 ns/10 ps

module tb();

reg [7:0] op_a;
reg [7:0] op_b;
reg [1:0] opsel;

wire [7:0] res;
wire cf;

alu alu_0(op_a, op_b, opsel, res, cf);


initial begin
	op_a = $random();
	op_b = $random();

	for(opsel = 0; opsel < 3; opsel = opsel + 1)
		#10;
	#10;

	op_a = $random();
	op_b = $random();

	for(opsel = 0; opsel < 3; opsel = opsel + 1)
		#10;
	#10;

	op_a = $random();
	op_a[1] = 1'bX;
	op_a[4] = 1'bZ;
	op_b = $random();

	for(opsel = 0; opsel < 3; opsel = opsel + 1)
		#10;
	#10;

	$stop();
end

endmodule
