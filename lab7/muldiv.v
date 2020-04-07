`timescale 1 ns / 10 ps

`include "defines.v"

module muldiv(InA_Re, InA_Im, InB_Re, InB_Im, Res_Re, Res_Im, OpSel, mode);

input [`DATA_WIDTH-1:0] InA_Re;
input [`DATA_WIDTH-1:0] InA_Im;
input [`DATA_WIDTH-1:0] InB_Re;
input [`DATA_WIDTH-1:0] InB_Im;
input [4:0] OpSel;
input mode;	//0 - simple math | 1 - complex math

output reg [`DATA_WIDTH-1:0] Res_Re;
output reg [`DATA_WIDTH-1:0] Res_Im;


//common calculations
//result of multiplying uses in next sums for "multiplying" and "dividing"
wire [`DATA_WIDTH*2-1:0] MulInA_ReInB_Re;
wire [`DATA_WIDTH*2-1:0] MulInA_ImInB_Im;

wire [`DATA_WIDTH*2-1:0] MulInA_ImInB_Re;
wire [`DATA_WIDTH*2-1:0] MulInA_ReInB_Im;

multiplier m_0(InA_Re, InB_Re, MulInA_ReInB_Re);
multiplier m_1(InA_Im, InB_Im, MulInA_ImInB_Im);
multiplier m_2(InA_Im, InB_Re, MulInA_ImInB_Re);
multiplier m_3(InA_Re, InB_Im, MulInA_ReInB_Im);


//calculations for dividing
wire [`DATA_WIDTH*2-1:0] SqrInB_Re;
multiplier m_4(InB_Re, InB_Re, SqrInB_Re);

wire [`DATA_WIDTH*2-1:0] SqrInB_Im;
multiplier m_5(InB_Im, InB_Im, SqrInB_Im);

wire [`DATA_WIDTH*2:0] SumOfSqr = SqrInB_Re + SqrInB_Im;

//convertation for substraction with using adder
//if number in additional code it will convert to direct code
//else it will convert from direct code to additional code
wire [`DATA_WIDTH*2-1:0] Temp1 = MulInA_ReInB_Im[`DATA_WIDTH*2-1] ? ~(MulInA_ReInB_Im - 1) : (~MulInA_ReInB_Im) + 1;

wire [`DATA_WIDTH*2:0] SumDiv_Re = $signed(MulInA_ReInB_Re) + $signed(MulInA_ImInB_Im);
wire [`DATA_WIDTH*2:0] SumDiv_Im = $signed(MulInA_ImInB_Re) + $signed(Temp1);

//final dividing for divider in "simple math" mode
wire [`DATA_WIDTH-1:0] SimpleDiv_Re = InB_Re ? $signed(InA_Re) / $signed(InB_Re) : 0;	//if divider is zero
wire [`DATA_WIDTH-1:0] SimpleDiv_Im = InB_Im ? $signed(InA_Im) / $signed(InB_Im) : 0;	//result will be zero(instead of inf)

//final dividing for divider in "complex math" mode
wire [`DATA_WIDTH-1:0] ComplexDiv_Re = SumOfSqr ? ($signed(SumDiv_Re) / $signed(SumOfSqr)) : 0;	//if divider is zero
wire [`DATA_WIDTH-1:0] ComplexDiv_Im = SumOfSqr ? ($signed(SumDiv_Im) / $signed(SumOfSqr)) : 0;	//result will be zero(instead of inf)

//if mode is "simple math" then result is 2 simple numbers, else result is 1 complex number
wire [`DATA_WIDTH-1:0] Div_Re = mode ? ComplexDiv_Re : SimpleDiv_Re;
wire [`DATA_WIDTH-1:0] Div_Im = mode ? ComplexDiv_Im : SimpleDiv_Im;


//calculations for multiplying
wire [`DATA_WIDTH*2-1:0] Mul_Re;
wire [`DATA_WIDTH*2-1:0] Mul_Im;

wire [`DATA_WIDTH*2-1:0] Temp2 = MulInA_ImInB_Im[`DATA_WIDTH*2-1] ? ~(MulInA_ImInB_Im - 1) : (~MulInA_ImInB_Im) + 1;

assign Mul_Re = mode ? $signed(MulInA_ReInB_Re) + $signed(Temp2) : MulInA_ReInB_Re;
assign Mul_Im = mode ? $signed(MulInA_ImInB_Re) + $signed(MulInA_ReInB_Im) : MulInA_ImInB_Im;

//calculation for reminder(simple math only)
wire [`DATA_WIDTH-1:0] Rem_Re = mode ? 0 : InB_Re ? $signed(InA_Re) % $signed(InB_Re) : 0;
wire [`DATA_WIDTH-1:0] Rem_Im = mode ? 0 : InB_Im ? $signed(InA_Im) % $signed(InB_Im) : 0;


always @* begin
	casez(OpSel)
		`DIV: begin
			Res_Re = Div_Re;
			Res_Im = Div_Im;
		end

		`REM: begin
			Res_Re = Rem_Re;
			Res_Im = Rem_Im;
		end

		`MUL_H: begin
			Res_Re = Mul_Re[`DATA_WIDTH*2-1:`DATA_WIDTH];
			Res_Im = Mul_Im[`DATA_WIDTH*2-1:`DATA_WIDTH];
		end

		`MUL_L: begin
			Res_Re = Mul_Re[`DATA_WIDTH-1:0];
			Res_Im = Mul_Im[`DATA_WIDTH-1:0];
		end

		default: begin
			Res_Re = 0;
			Res_Im = 0;			
		end

	endcase
end

endmodule

//multiplier for signed numbers
module multiplier(OpA, OpB, Result);

input [`DATA_WIDTH-1:0] OpA;
input [`DATA_WIDTH-1:0] OpB;

output [`DATA_WIDTH*2-1:0] Result;

wire [`DATA_WIDTH-1:0] TempA = OpA[`DATA_WIDTH-1] ? (~OpA) + 1 : OpA;
wire [`DATA_WIDTH-1:0] TempB = OpB[`DATA_WIDTH-1] ? (~OpB) + 1 : OpB;

wire [`DATA_WIDTH*2-1:0] TempRes = TempA * TempB;

assign Result = (OpA[`DATA_WIDTH-1] ^ OpB[`DATA_WIDTH-1]) ? (~TempRes) + 1 : TempRes;

endmodule
