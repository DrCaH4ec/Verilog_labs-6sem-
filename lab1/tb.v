`timescale 1 ns/10 ps

module tb();

reg [7:0] ina;
reg [7:0] inb;
reg clk;
reg clr;

wire [15:0] out;

mult_acc mult_acc_0(out, ina, inb, clk, clr);

initial begin
	clk = 1;
	forever begin
		#90 clk = 0;
		#180 clk = 1;
	end
end

initial begin
	clr = 0;
	#850 clr = 1;
	#100 clr = 0;
end

initial begin
	
	ina = 0;

	while(1) begin
		#320 ina = ina + 4;
	end

end

initial begin
	
	inb = 255;

	while(1) begin
		#540 inb = inb - 2;
	end

end

initial begin
	#3820 $stop();
end


endmodule

/*
	такт период: 270нс
	33%

	сброс: подать на 850нс

	Ina: арифм прогрессия с шагом 4 период 320нс
	Inb: шаг -2 период 540нс
	стоп: на 3820нс
 */
