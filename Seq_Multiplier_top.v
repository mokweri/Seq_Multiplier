
module Seq_Multiplier_top(clk,resetn,start,A,B,LED,SSEG,EN);
	input wire clk,resetn,start;
	input wire [3:0] A,B; //connect to switches
	output wire [7:0] SSEG;
	output wire [7:0] LED;
	output wire [3:0] EN;
	
	
	//Internal signals
	wire [7:0] product;
	wire [9:0] p_bcd;
	
	assign LED = {~A,~B}; //display A and B on LEDS
	
	
	//Instatiate the Multiplier
	Seq_Multiplier multiplier(.clk(clk), .resetn(resetn), .start(start), .a(A), .b(B), .p(product));
	
	//convert binary product to bcd
	bin2bcd #(.W(8))binconverter (.bin(product), .bcd(p_bcd));
	
	//Instantiate the Seven segment display
	Seg_bcd_4digit display(.clk(clk), .clr(resetn),.EN(EN),.bcd(p_bcd), .SEG(SSEG) );
	
	
endmodule
	
	