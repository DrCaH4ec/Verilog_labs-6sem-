`timescale 1 ns / 10 ps

`define Y0 0
`define Y1 1
`define Y2 2
`define Y3 3
`define Y4 4
`define Y5 5
`define Y6 6
`define Y7 7
`define Y8 8
`define Yk 9


module microprog(clk, x, y, ARstN);

input clk;
input [3:1] x;
input ARstN;

output reg [15:0] y;

reg [3:0] state;


always @(posedge clk or negedge ARstN) begin

	//reset just set an initial value of state
	if (!ARstN) begin
		state = `Y0;
	end
	else begin
		
		//case for transitions between states
		casez(state)

			`Y0: state = `Y1;

			`Y1: state = `Y2;

			`Y2: begin
				
				if(x[2]) begin
					if(x[1])
						state = `Y5;
					else
						state = `Y3;
				end
				else if(x[3])
					state = `Y8;
			end

			`Y3: state = `Y4;

			`Y4: state = `Y7;

			`Y5: state = `Y6;

			`Y6: state = `Y7;

			`Y7: state = `Y8;

			`Y8: state = `Yk;

			`Yk: state = `Yk; //waiting for rst

			default state = `Y0;

		endcase

		//case for setting output values
		casez(state)
			`Y0: y = "Y0";
			`Y1: y = "Y1";
			`Y2: y = "Y2";
			`Y3: y = "Y3";
			`Y4: y = "Y4";
			`Y5: y = "Y5";
			`Y6: y = "Y6";
			`Y7: y = "Y7";
			`Y8: y = "Y8";
			`Yk: y = "Yk";
		endcase
	end
end

endmodule
