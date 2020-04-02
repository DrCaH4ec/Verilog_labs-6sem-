`timescale 1 ns / 10 ps

`define A "A"
`define B "B"
`define C "C"
`define D "D"
`define E "E"
`define F "F"
`define G "G"
`define H "H"


module fsm(clk, x, y, z, ARstN);

input clk;
input x;
input y;
input ARstN;

output reg [1:2] z;

reg [7:0] state;


always @(posedge clk or negedge ARstN) begin

	//reset just set an initial value of state
	if (!ARstN) begin
		state = `A;
	end
	else begin
		
		//case for transitions between states
		casez(state)

			`A: begin

				if(x)
					state = `B;
				else if(!x && y)
					state = `E;
			end

			`B: begin

				if(x)
					state = `D;
			end

			`C: begin
				
				if(x)
					state = `A;
				else if(!x && y)
					state = `G;
			end

			`D: begin
				
				if(x)
					state = `C;
			end

			`E: begin
				state = `F;
			end

			`F: begin
				state = `B;
			end

			`G: begin
				state = `H;
			end

			`H: begin
				state = `D;
			end

			default state = `A;

		endcase

		//case for setting output values
		casez(state)
			`A: z = 2'b10;
			`B: z = 2'b10;
			`C: z = 2'b10;
			`D: z = 2'b00;
			`E: z = 2'b11;
			`F: z = 2'b10;
			`G: z = 2'b11;
			`H: z = 2'b11;
		endcase
	end
end

endmodule
