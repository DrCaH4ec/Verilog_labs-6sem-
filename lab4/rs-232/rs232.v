`timescale 1 ns / 10 ps

`define WAIT_FOR_START_BIT 0
`define RECEIVING_DATA 1
`define STOP 2

module rs232(ParityCheck, err, en, busy, d_in, d_out, ARstN, clk);

input ParityCheck;
input en;
input ARstN;
input clk;
input d_in;

output reg [7:0] d_out;
output reg busy;
output reg err; //it will change, only if ParityCheck is set, else it will clear

reg [8:0] buff;
reg [7:0] count;
reg [7:0] state;

always @(posedge clk or negedge ARstN) begin
	if(!ARstN) begin
		buff = 0;
		count = 0;
		busy = 0;
		err = 0;
		state = 0;
		d_out = 0;
	end
	else begin
		casez(state)
			`WAIT_FOR_START_BIT: begin
				if(!d_in && !busy && en) begin
					busy = 1;
					state = `RECEIVING_DATA;
				end
			end

			`RECEIVING_DATA: begin
				buff[count] = d_in;
				count = count + 1;
				if(count == 8 && !ParityCheck)
					state = `STOP;
				if(count == 9)
					state = `STOP;
			end

			`STOP: begin
				if(d_in) begin
					if(ParityCheck)
						err = ^buff;
					else
						err = 0;

					d_out = buff[7:0];
					busy = 0;
					count = 0;
					state = `WAIT_FOR_START_BIT;				
				end
			end
		endcase
	end
end

endmodule
