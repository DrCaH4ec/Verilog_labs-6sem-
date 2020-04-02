`timescale 1 ns/10 ps

module tb();

reg [2:0] in;

wire out, out_min;

scheme_2 scheme_2_0(in, out, out_min);

initial begin
	for(in = 0; in < 7; in = in + 1)
		#10;

	#10 $stop();
end

endmodule
