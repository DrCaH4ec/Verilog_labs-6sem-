`timescale 1 ns/10 ps

module tb();

reg [2:0] in;

wire out;

scheme_1 scheme_1_0(in, out);

initial begin
	for(in = 0; in < 7; in = in + 1)
		#10;
	#10;

	in[1] = 1'bz;

	#10 $stop();
end

endmodule
