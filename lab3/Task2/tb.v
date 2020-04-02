`timescale 1 ns/10 ps

module tb();

reg [8:0] x;

wire [3:0] y;
integer i;

coder coder_0(x, y);

initial begin
	x = 0;
	#10;
	x[0] = 1;

	for(i = 0; i < 10; i = i + 1)
		#10 x = (9'b000000001) << i;
	#10;

	for(x = 0; x < 20; x = x + 1)
		#10;

	$stop();

end

endmodule
