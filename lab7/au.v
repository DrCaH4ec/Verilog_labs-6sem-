`timescale 1 ns / 10 ps


`include "defines.v"

module au(InA_Re, InA_Im, InB_Re, InB_Im, OpSel, Res_Re, Res_Im, OF_Re, OF_Im, mode);

input [`DATA_WIDTH-1:0] InA_Re;
input [`DATA_WIDTH-1:0] InA_Im;
input [`DATA_WIDTH-1:0] InB_Re;
input [`DATA_WIDTH-1:0] InB_Im;
input [4:0] OpSel;
input mode;	//0 - simple math | 1 - complex math

output reg [`DATA_WIDTH-1:0] Res_Re;
output reg [`DATA_WIDTH-1:0] Res_Im;
output OF_Re;
output OF_Im;


wire [`DATA_WIDTH-1:0] AddSubResult [1:0];
wire [1:0] AddSubOF;
addsub addsub_0(InA_Re, InA_Im, InB_Re, InB_Im, OpSel[2], AddSubResult[`Re], AddSubResult[`Im], AddSubOF[`Re], AddSubOF[`Im]);


wire [`DATA_WIDTH-1:0] ShiftResult [1:0];
shifter shifter(InA_Re, InA_Im, InB_Re[3:0], InB_Im[3:0], OpSel, ShiftResult[`Re], ShiftResult[`Im], mode);	//for ShiftAmount use 4 low bits of InB

assign OF_Re = (OpSel[1:0] == 1'b00) ? AddSubOF[`Re] : 0;
assign OF_Im = (OpSel[1:0] == 1'b00) ? AddSubOF[`Im] : 0;

always @* begin
	casez(OpSel[1:0])
		//add/sub
		2'b00: begin
			Res_Re = AddSubResult[`Re];
			Res_Im = AddSubResult[`Im];
		end
		//shift
		2'b01: begin
			Res_Re = ShiftResult[`Re];
			Res_Im = ShiftResult[`Im];
		end

		default: begin
			Res_Re = 0;
			Res_Im = 0;			
		end

	endcase
end


endmodule
