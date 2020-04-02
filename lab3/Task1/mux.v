`timescale 1 ns / 10 ps

module mux#(parameter MUX_WIDTH = 8)(x, addr, y, en);

parameter ADDR_WIDTH = $clog2(MUX_WIDTH);

input [MUX_WIDTH-1:0] x;
input [ADDR_WIDTH-1:0] addr;
input en;

output y;

assign y = en ? 1'bz : x[addr];

endmodule
