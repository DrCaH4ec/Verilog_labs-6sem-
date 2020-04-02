`timescale 1 ns/10 ps

`define MUX_WIDTH 8
`define ADDR_WIDTH $clog2(`MUX_WIDTH)

module tb();

reg [`MUX_WIDTH-1:0] x;
reg [`ADDR_WIDTH-1:0] addr;
reg en;

wire y;

mux #(`MUX_WIDTH)mux_0(x, addr, y, en);

initial begin
	en = 0;
	x = $random();

	for(addr = 0; addr < `MUX_WIDTH-1; addr = addr + 1)
		#10;
	#10;

	en = 1;

	for(addr = 0; addr < `MUX_WIDTH-1; addr = addr + 1)
		#10;
	#10;

	en = 0;

	x[5] = 1'bz;

	for(addr = 0; addr < `MUX_WIDTH-1; addr = addr + 1)
		#10;
	#10;	

	$stop();

end

endmodule
