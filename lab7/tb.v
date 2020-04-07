`timescale 1 ns/10 ps

`include "defines.v"

module tb();

reg [`DATA_WIDTH-1:0] InA_Re;
reg [`DATA_WIDTH-1:0] InA_Im;
reg [`DATA_WIDTH-1:0] InB_Re;
reg [`DATA_WIDTH-1:0] InB_Im;
reg [4:0] OpSel;
reg mode;


wire [`DATA_WIDTH-1:0] Res_Re;
wire [`DATA_WIDTH-1:0] Res_Im;
wire OF_Re;
wire OF_Im;

complex_num cn_0(InA_Re, InA_Im, InB_Re, InB_Im, OpSel, Res_Re, Res_Im, OF_Re, OF_Im, mode);

initial begin
///////////////////////////// COMPLEX MATH /////////////////////////////

	mode = 1;

	InA_Re = 32767;
	InA_Im = $random%32767;

	InB_Re = 1;
	InB_Im = $random%32767;

	OpSel = `ADD;
	#10;
	OpSel = `SUB;
	#10;

	InA_Re = $random%32767;
	InA_Im = 32767;

	InB_Re = $random%32767;
	InB_Im = 3;

	OpSel = `ADD;
	#10;
	OpSel = `SUB;
	#10;

	InA_Re = $random%32767;
	InA_Im = $random%32767;

	InB_Re = $random%32767;
	InB_Im = $random%32767;

	OpSel = `ADD;
	#10;
	OpSel = `SUB;
	#10;

	InA_Re = $random%32767;
	InA_Im = $random%32767;

	InB_Re = $random%32767;
	InB_Im = $random%32767;

	OpSel = `ADD;
	#10;
	OpSel = `SUB;
	#10;

	InA_Re = $random%32767;
	InA_Im = $random%32767;

	InB_Re = $random%32767;
	InB_Im = $random%32767;

	OpSel = `ADD;
	#10;
	OpSel = `SUB;
	#10;

	InA_Re = $random%32767;
	InA_Im = $random%32767;

	InB_Re = $random%32767;
	InB_Im = $random%32767;

	OpSel = `ADD;
	#10;
	OpSel = `SUB;
	#10;
/////////////////////////////

	InB_Re = 0;
	InB_Im = 0;

	InA_Re = $random%32767;
	InA_Im = $random%32767;
	InB_Re[3:0] = 8;

	OpSel = `SLL;
	#10;
	OpSel = `SRL;
	#10;
	OpSel = `ROR;
	#10;
	OpSel = `SRA;
	#10;
	OpSel = `ROL;
	#10;

	InA_Re = $random%32767;
	InA_Im = $random%32767;
	InB_Re[3:0] = 4;

	OpSel = `SLL;
	#10;
	OpSel = `SRL;
	#10;
	OpSel = `ROR;
	#10;
	OpSel = `SRA;
	#10;
	OpSel = `ROL;
	#10;

	InA_Re = $random%32767;
	InA_Im = $random%32767;
	InB_Re[3:0] = 0;

	OpSel = `SLL;
	#10;
	OpSel = `SRL;
	#10;
	OpSel = `ROR;
	#10;
	OpSel = `SRA;
	#10;
	OpSel = `ROL;
	#10;

/////////////////////////////
	
	InA_Re = 18233;
	InA_Im = 0;

	InB_Re = -27589;
	InB_Im = 0;

	OpSel = `DIV;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;

	InA_Re = -22354;
	InA_Im = -31404;

	InB_Re = 31222;
	InB_Im = 27452;

	OpSel = `DIV;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;

	InA_Re = -21416;
	InA_Im = -9399;

	InB_Re = 28356;
	InB_Im = 24244;

	OpSel = `DIV;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;

	InA_Re = 11418;
	InA_Im = 30362;

	InB_Re = 22929;
	InB_Im = 15802;

	OpSel = `DIV;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;

	InA_Re = 13;
	InA_Im = 1;

	InB_Re = 7;
	InB_Im = -6;

	OpSel = `DIV;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;

	InA_Re = 13;
	InA_Im = 1;

	InB_Re = 1;
	InB_Im = -6;

	OpSel = `DIV;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;

	InA_Re = 25;
	InA_Im = 51;

	InB_Re = 1;
	InB_Im = -6;

	OpSel = `DIV;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;

	InA_Re = 6315;
	InA_Im = 30000;

	InB_Re = 100;
	InB_Im = -321;

	OpSel = `DIV;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;

	InA_Re = -6315;
	InA_Im = 30000;

	InB_Re = 100;
	InB_Im = -321;

	OpSel = `DIV;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;

	InA_Re = -6315;
	InA_Im = 30000;

	InB_Re = 0;
	InB_Im = 0;

	OpSel = `DIV;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;

	InA_Re = 0;
	InA_Im = 30000;

	InB_Re = 0;
	InB_Im = -412;

	OpSel = `DIV;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;

	InA_Re = 0;
	InA_Im = 0;

	InB_Re = 22313;
	InB_Im = -412;

	OpSel = `DIV;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;

	InA_Re = 32000;
	InA_Im = 32000;

	InB_Re = 1;
	InB_Im = 2;

	OpSel = `DIV;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;

	InA_Re = 32000;
	InA_Im = 32000;

	InB_Re = 21;
	InB_Im = 12;

	OpSel = `DIV;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;


	InA_Re = -32767;
	InA_Im = -32767;

	InB_Re = 0;
	InB_Im = 1;

	OpSel = `DIV;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;

 
	InA_Re = 32767;
	InA_Im = 32767;

	InB_Re = 32767;
	InB_Im = 32767;

	OpSel = `DIV;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;


	InA_Re = 32767;
	InA_Im = -32767;

	InB_Re = 32767;
	InB_Im = 32767;

	OpSel = `DIV;
	#10;
	OpSel = `REM;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;


	InA_Re = 32767;
	InA_Im = 32767;

	InB_Re = -1;
	InB_Im = -1;

	OpSel = `DIV;
	#10;
	OpSel = `REM;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;
///////////////////////////// SIMPLE MATH /////////////////////////////
	mode = 0;

	InA_Re = 32767;
	InA_Im = 32567;
	InB_Re = 2;
	InB_Im = 1000;

	OpSel = `ADD;
	#10;
	OpSel = `SUB;
	#10;

	InA_Re = $random%32767;
	InA_Im = $random%32767;
	InB_Re = $random%32767;
	InB_Im = $random%32767;

	OpSel = `ADD;
	#10;
	OpSel = `SUB;
	#10;

	InA_Re = $random%32767;
	InA_Im = $random%32767;
	InB_Re = $random%32767;
	InB_Im = $random%32767;

	OpSel = `ADD;
	#10;
	OpSel = `SUB;
	#10;

/////////////////////////////

	InB_Re = 0;
	InB_Im = 0;

	InA_Re = $random%32767;
	InA_Im = $random%32767;
	InB_Re[3:0] = 8;
	InB_Im[3:0] = 4;

	OpSel = `SLL;
	#10;
	OpSel = `SRL;
	#10;
	OpSel = `ROR;
	#10;
	OpSel = `SRA;
	#10;
	OpSel = `ROL;
	#10;

	InA_Re = $random%32767;
	InA_Im = $random%32767;
	InB_Re[3:0] = 12;
	InB_Im[3:0] = 0;

	OpSel = `SLL;
	#10;
	OpSel = `SRL;
	#10;
	OpSel = `ROR;
	#10;
	OpSel = `SRA;
	#10;
	OpSel = `ROL;
	#10;

	InA_Re = $random%32767;
	InA_Im = $random%32767;
	InB_Re[3:0] = 0;
	InB_Im[3:0] = 8;

	OpSel = `SLL;
	#10;
	OpSel = `SRL;
	#10;
	OpSel = `ROR;
	#10;
	OpSel = `SRA;
	#10;
	OpSel = `ROL;
	#10;

	InA_Re = $random%32767;
	InA_Im = $random%32767;
	InB_Re[3:0] = 0;
	InB_Im[3:0] = 0;

	OpSel = `SLL;
	#10;
	OpSel = `SRL;
	#10;
	OpSel = `ROR;
	#10;
	OpSel = `SRA;
	#10;
	OpSel = `ROL;
	#10;

// /////////////////////////////

	InA_Re = $random%32767;
	InA_Im = $random%32767;
	InB_Re = $random%32767;
	InB_Im = $random%32767;

	OpSel = `DIV;
	#10;
	OpSel = `REM;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;

	InA_Re = $random%32767;
	InA_Im = $random%32767;
	InB_Re = $random%32767;
	InB_Im = $random%32767;

	OpSel = `DIV;
	#10;
	OpSel = `REM;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;

	InA_Re = $random%32767;
	InA_Im = $random%32767;
	InB_Re = $random%32767;
	InB_Im = $random%32767;

	OpSel = `DIV;
	#10;
	OpSel = `REM;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;

	InA_Re = $random%32767;
	InA_Im = $random%32767;
	InB_Re = $random%32767;
	InB_Im = $random%32767;

	OpSel = `DIV;
	#10;
	OpSel = `REM;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;

	InA_Re = 15;
	InA_Im = 81;
	InB_Re = -3;
	InB_Im = 9;

	OpSel = `DIV;
	#10;
	OpSel = `REM;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;

	InA_Re = 15;
	InA_Im = 0;
	InB_Re = 0;
	InB_Im = 9;

	OpSel = `DIV;
	#10;
	OpSel = `REM;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;

	InA_Re = 32767;
	InA_Im = 32767;

	InB_Re = 32767;
	InB_Im = 32767;

	OpSel = `DIV;
	#10;
	OpSel = `REM;
	#10;
	OpSel = `MUL_H;
	#10;
	OpSel = `MUL_L;
	#10;

	$stop();
end

endmodule
