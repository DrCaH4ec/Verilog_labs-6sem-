`timescale 1 ns / 10 ps

`define FIRST 0
`define SECOND 1
`define THIRD 2
`define FOURTH 3
`define FIFTH 4
`define SIXTH 5
`define STOP 6

module tb();

reg ParityCheck;
reg en;
reg ARstN;
reg clk_r; //clock signal for reciever
reg d_in;

wire [7:0] d_out;
wire busy;
wire err;

rs232 rs232_0(ParityCheck, err, en, busy, d_in, d_out, ARstN, clk_r);

reg clk_t;	//clock signal for transmitter
reg [7:0] data [1:0];
reg [8:0] data_p [3:0];
reg [7:0] count;
reg [2:0] state;

wire [9:0] recieve [1:0];	//for tests without parity checking
wire [10:0] recieve_p [3:0];	//for tests with parity checking

assign recieve[0] = {1'b1, data[0], 1'b0};
assign recieve[1] = {1'b1, data[1], 1'b0};

assign recieve_p[0] = {1'b1, data_p[0], 1'b0};
assign recieve_p[1] = {1'b1, data_p[1], 1'b0};
assign recieve_p[2] = {1'b1, data_p[2], 1'b0};
assign recieve_p[3] = {1'b1, data_p[3], 1'b0};

initial begin
	clk_t = 0;
	forever #5 clk_t = ~clk_t;
end

initial begin
	clk_r = 0;
	#5;	//clk_t and clk_r must be phase shifted by half of the period
	forever #5 clk_r = ~clk_r;
end

initial begin
	
	state = 0;
	ParityCheck = 0;
	en = 0;

	count = 0;

	ARstN = 0;
	#5 ARstN = 1;

	data[0] = $random();

	data[1] = $random();
	data[1][4] = 1'bz;
	data[1][1] = 1'bx;

	data_p[0] = 9'b100000001;
	data_p[1] = 9'b001010001;
	data_p[2] = 9'b0010X0Z01;
	data_p[3] = 9'b001010101;

	en = 1;
end

always @(posedge clk_t) begin

	if(en) begin
		casez(state)
			`FIRST: begin 	//simple test without parity checking
				d_in = recieve[0][count];
				count = count + 1;
				
				if(count == 10) begin
					count = 0;
					state = `SECOND;
				end
			end

			`SECOND: begin 	//test without parity checking but with Z- and X- states
				d_in = recieve[1][count];
				count = count + 1;
				
				if(count == 10) begin
					count = 0;
					state = `THIRD;
				end	
			end

			`THIRD: begin 	//simple test with parity checking, where haven't to be an error
				ParityCheck = 1;
				d_in = recieve_p[0][count];
				count = count + 1;

				if(count == 11) begin
					count = 0;
					state = `FOURTH;
				end
			end

			`FOURTH: begin 	//simple test with parity checking, where have to be an error
				d_in = recieve_p[1][count];
				count = count + 1;

				if(count == 11) begin
					count = 0;
					state = `FIFTH;
				end
			end

			`FIFTH: begin 	//simple test with parity checking and with Z- and X- states 
				d_in = recieve_p[2][count];	//to know which state of err we will give
				count = count + 1;
				
				if(count == 11) begin
					count = 0;
					state = `SIXTH;
				end			
			end

			`SIXTH: begin 	//simple test with parity checking, where haven't to be an error
				d_in = recieve_p[3][count];
				count = count + 1;
				
				if(count == 11) begin
					count = 0;
					state = `STOP;
				end
			end

			`STOP: $stop();

		endcase
	end
end

endmodule
