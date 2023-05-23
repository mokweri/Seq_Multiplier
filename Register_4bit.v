
/***************************************************
  4 bit Register with parallel load
****************************************************/
module Register_4bit(clk, ld, a, y);
	input clk,ld;
	input [3:0] a;
	output [3:0] y;
	
	DFF_en d1(.clk(clk),.en(ld),.d(a[0]),.q(y[0]));
	DFF_en d2(.clk(clk),.en(ld),.d(a[1]),.q(y[1]));
	DFF_en d3(.clk(clk),.en(ld),.d(a[2]),.q(y[2]));
	DFF_en d4(.clk(clk),.en(ld),.d(a[3]),.q(y[3]));
	
endmodule

/*
	D Flip flip with synchronous enable
*/
module DFF_en(clk,en,d,q);
	input clk, en;
	input d;
	output reg q;

	initial begin q=0; end
	always@(posedge clk)
	begin
		if(en)
			q <= d;
		else
			q <= q;		
	end
endmodule