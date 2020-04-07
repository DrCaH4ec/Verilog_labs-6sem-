`timescale 1 ns / 10 ps

`include "defines.v"

module complex_num(InA_Re, InA_Im, InB_Re, InB_Im, OpSel, Res_Re, Res_Im, OF_Re, OF_Im, mode);

input [`DATA_WIDTH-1:0] InA_Re;
input [`DATA_WIDTH-1:0] InA_Im;
input [`DATA_WIDTH-1:0] InB_Re;
input [`DATA_WIDTH-1:0] InB_Im;
input [4:0] OpSel;
input mode;	//0 - simple math | 1 - complex math

output [`DATA_WIDTH-1:0] Res_Re;
output [`DATA_WIDTH-1:0] Res_Im;
output OF_Re;
output OF_Im;

wire [1:0] TempOF;
wire [`DATA_WIDTH-1:0] ArithmResult [1:0];

//for ShiftAmounts use only 4 low bits of InB
au au_0(InA_Re, InA_Im, InB_Re, InB_Im, OpSel, ArithmResult[`Re], ArithmResult[`Im], TempOF[`Re], TempOF[`Im], mode);

wire [`DATA_WIDTH-1:0] CoResult [1:0];
muldiv muldiv_0(InA_Re, InA_Im, InB_Re, InB_Im, CoResult[`Re], CoResult[`Im], OpSel, mode);

assign OF_Re = (OpSel[1:0] == 2'b00) ? TempOF[`Re] : 0;
assign OF_Im = (OpSel[1:0] == 2'b00) ? TempOF[`Im] : 0;

assign Res_Re = OpSel[1] ? CoResult[`Re] : ArithmResult[`Re];
assign Res_Im = OpSel[1] ? CoResult[`Im] : ArithmResult[`Im];

endmodule
