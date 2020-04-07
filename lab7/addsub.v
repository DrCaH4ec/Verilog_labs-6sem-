`timescale 1 ns / 10 ps

`include "defines.v"

module addsub(InA_Re, InA_Im, InB_Re, InB_Im, OpSel, Res_Re, Res_Im, OF_Re, OF_Im);

input [`DATA_WIDTH-1:0] InA_Re;
input [`DATA_WIDTH-1:0] InA_Im;
input [`DATA_WIDTH-1:0] InB_Re;
input [`DATA_WIDTH-1:0] InB_Im;
input OpSel; //0 - ADD; 1 - SUB

output [`DATA_WIDTH-1:0] Res_Re;
output [`DATA_WIDTH-1:0] Res_Im;
output OF_Re;
output OF_Im;

wire [`DATA_WIDTH-1:0] temp [1:0];
wire [`DATA_WIDTH-1:0] temp2 [1:0];
wire [1:0] Carry1;
wire [1:0] Carry2;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////|
//				|	Type of converting		|	There operand B is converting to 		|	There operand B is converting to	|
//				|	developes on sign		|	positive for case -> (+-a)-(-b)			|	negative fot case -> (+-a)-b 		|
//				|	of operand B(only for	|	because it can be changed to (+-a)+b	|	because it can be changed to		|
//				|	substraction)			|	 										|	(+-a)+(-b) 							|	
assign temp[`Re] = 	InB_Re[`DATA_WIDTH-1]	? (InB_Re-OpSel) ^ {`DATA_WIDTH{OpSel}}		: (InB_Re ^ {`DATA_WIDTH{OpSel}}) + OpSel;
assign temp[`Im] = 	InB_Im[`DATA_WIDTH-1] 	? (InB_Im-OpSel) ^ {`DATA_WIDTH{OpSel}} 	: (InB_Im ^ {`DATA_WIDTH{OpSel}}) + OpSel; 


//This "strange things" were done because of overflow flag(OF).
//	OF = (Carry out of (N-1) adder) XOR (Carry out of N adder)
//So this actions were done because I need 2 carry outs

//calculations for real part
assign {Carry1[`Re], temp2[`Re][`DATA_WIDTH-2:0]}  = InA_Re[`DATA_WIDTH-2:0] + temp[`Re][`DATA_WIDTH-2:0];
assign {Carry2[`Re], temp2[`Re][`DATA_WIDTH-1]} = InA_Re[`DATA_WIDTH-1] + temp[`Re][`DATA_WIDTH-1] + Carry1[`Re];

assign OF_Re = Carry1[`Re] ^ Carry2[`Re];


//calculations of imagine part
assign {Carry1[`Im], temp2[`Im][`DATA_WIDTH-2:0]}  = InA_Im[`DATA_WIDTH-2:0] + temp[`Im][`DATA_WIDTH-2:0];
assign {Carry2[`Im], temp2[`Im][`DATA_WIDTH-1]} = InA_Im[`DATA_WIDTH-1] + temp[`Im][`DATA_WIDTH-1] + Carry1[`Im];

assign OF_Im = Carry1[`Im] ^ Carry2[`Im];


//ready result
assign Res_Re = temp2[`Re][`DATA_WIDTH-1:0];
assign Res_Im = temp2[`Im][`DATA_WIDTH-1:0];

endmodule
