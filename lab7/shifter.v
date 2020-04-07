`timescale 1 ns / 10 ps

`include "defines.v"

`define SHIFT_AMOUNT_WIDTH $clog2(`DATA_WIDTH)

module shifter(InA_Re, InA_Im, ShiftAmount_Re, ShiftAmount_Im, OpSel, Res_Re, Res_Im, mode);

input [`DATA_WIDTH-1:0] InA_Re;
input [`DATA_WIDTH-1:0] InA_Im;
input [`SHIFT_AMOUNT_WIDTH-1:0] ShiftAmount_Re;
input [`SHIFT_AMOUNT_WIDTH-1:0] ShiftAmount_Im;
input [4:0] OpSel;
input mode;	//0 - simple math | 1 - complex math

output reg [`DATA_WIDTH-1:0] Res_Re;
output reg [`DATA_WIDTH-1:0] Res_Im;

wire [`DATA_WIDTH*2-1:0] TempL [1:0];
wire [`DATA_WIDTH*2:0] TempR [1:0];

wire [1:0] arithm;
wire IsArithmShift;

//in "complex math" mode 2 input operands will have the same ShiftAmount
//else they will have 2 different operands
wire [`SHIFT_AMOUNT_WIDTH-1:0] ShiftAmount = mode ? ShiftAmount_Re : ShiftAmount_Im;

//this "strange things" is using for economy of shift muxes
assign IsArithmShift = (OpSel == `SRA);
assign arithm[`Re] = InA_Re[`DATA_WIDTH-1] & IsArithmShift;
assign arithm[`Im] = InA_Im[`DATA_WIDTH-1] & IsArithmShift;
assign TempL[`Re] = {InA_Re, InA_Re} << ShiftAmount_Re;
assign TempL[`Im] = {InA_Im, InA_Im} << ShiftAmount;

//if right shift is logical arithm = 0 and high part will fill up by "0"
//else it will fill up by value of sign bit of operand
assign TempR[`Re] = $signed({arithm[`Re], InA_Re, InA_Re}) >>> ShiftAmount_Re;
assign TempR[`Im] = $signed({arithm[`Im], InA_Im, InA_Im}) >>> ShiftAmount;


//after only 4 shifts(2 per operand) we just take a necessary parts of TempL and TempR
always @* begin
	casez(OpSel)
		`SLL: Res_Re = TempL[`Re][`DATA_WIDTH-1:0];
		`SRL: Res_Re = TempR[`Re][`DATA_WIDTH*2-1:`DATA_WIDTH];
		`ROR: Res_Re = TempR[`Re][`DATA_WIDTH-1:0];
		`ROL: Res_Re = TempL[`Re][`DATA_WIDTH*2-1:`DATA_WIDTH];
		`SRA: Res_Re = TempR[`Re][`DATA_WIDTH*2-1:`DATA_WIDTH];
		default: Res_Re = 0;
	endcase

	casez(OpSel)
		`SLL: Res_Im = TempL[`Im][`DATA_WIDTH-1:0];
		`SRL: Res_Im = TempR[`Im][`DATA_WIDTH*2-1:`DATA_WIDTH];
		`ROR: Res_Im = TempR[`Im][`DATA_WIDTH-1:0];
		`ROL: Res_Im = TempL[`Im][`DATA_WIDTH*2-1:`DATA_WIDTH];
		`SRA: Res_Im = TempR[`Im][`DATA_WIDTH*2-1:`DATA_WIDTH];
		default: Res_Im = 0;
	endcase
end


endmodule
