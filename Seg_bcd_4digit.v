
module Seg_bcd_4digit(clk,clr,EN,bcd, SEG );
	input clk,clr;
	output reg [3:0] EN;
	input [9:0] bcd;
	output reg [7:0] SEG;
	
	
	//  constant declaration 
	//  refreshing rate around  800 Hz (50 MH.z/2^16) 
	localparam  N = 20 ;
	
	//  internal signal declaration   
	wire [N-1:0] count;
	wire [7:0] seg1, seg2, seg3, seg4;
	
	//Instantaite 18-bit counter
	N_bit_counter #(.N(N))
	cont18(.clk(clk), .resetn(clr), .q(count));
	
	seven_segment sseg1(.SEG(seg1),.C(4'b0000));
	seven_segment sseg2(.SEG(seg2),.C(bcd[9:8]));
	seven_segment sseg3(.SEG(seg3),.C(bcd[7:4]));
	seven_segment sseg4(.SEG(seg4),.C( bcd[3:0]));
	
	// MSB of count to control 4-to-1 multiplexing and generate active low enable signal for EN
	always@*
		case(count[N-1:N-2])
			2'b00: begin
						EN <= 4'b1000;
						SEG <= seg1;
					end
			2'b01: begin
						EN <= 4'b0100;
						SEG <= seg2 ;
					end
			2'b10: begin
						EN <= 4'b0010;
						SEG <= seg3;
					end
			default: begin
						EN <= 4'b0001;
						SEG <= seg4;
					end
		endcase
		
endmodule

module N_bit_counter #(parameter N = 18 )(
	input wire clk, resetn,
	output wire [N-1:0] q	
);
	//signal declaration
	reg [N-1:0] r_reg;
	wire [N-1:0] r_next;
	
	//register
	always @(posedge clk, negedge resetn)
		if(!resetn)
			r_reg <= 0;
		else
			r_reg <= r_next;
	
	//next-state logic
	assign r_next = r_reg + 1;
	//output logic
	assign q = r_reg;
endmodule

//****************************************************************************
// BCD to seven_segment (Digits 0-9)
module seven_segment (SEG,C);	
	input [3:0] C;
	output [7:0] SEG;
	
	// Using simple logic expressions	
	assign SEG[0] = (~C[3]&~C[2]&~C[1]&C[0])|(~C[3]&C[2]&~C[1]&~C[0]);	  //SEG off, digits(1,4) //0001 OR 0100																								
	assign SEG[1] = (~C[3]&C[2]&~C[1]&C[0])|(~C[3]&C[2]&C[1]&~C[0]);	  //SEG off, digits(5,6) //0101 OR 0110	
	assign SEG[2] = (~C[3]&~C[2]&C[1]&~C[0]);	                          //SEG off, digits(2) //0010						
	assign SEG[3] = (~C[3]&~C[2]&~C[1]&C[0])|(~C[3]&C[2]&~C[1]&~C[0])|	  //SEG off, digits(1,4,7,9)
						 (~C[3]&C[2]&C[1]&C[0])|(C[3]&~C[2]&~C[1]&C[0]);  //0001 OR 0100 OR 0111 OR 1001	
	assign SEG[4] = (~C[3]&~C[2]&~C[1]&C[0])|(~C[3]&~C[2]&C[1]&C[0])|	  //SEG off, digits(1,3,4,5,7,9)
						 (~C[3]&C[2]&~C[1]&~C[0])|(~C[3]&C[2]&~C[1]&C[0])|	//0001 OR 0011 OR 0100 OR 0101 OR 0111 OR 1001 
						 (~C[3]&C[2]&C[1]&C[0])|(C[3]&~C[2]&~C[1]&C[0]);		
	assign SEG[5] = (~C[3]&~C[2]&~C[1]&C[0])|(~C[3]&~C[2]&C[1]&~C[0])|	   //SEG off, digits(1,2,3,7)
						 (~C[3]&~C[2]&C[1]&C[0])|(~C[3]&C[2]&C[1]&C[0]);   //0001 OR 0010 OR 0011 OR 0111 
	assign SEG[6] = (~C[3]&~C[2]&~C[1]&~C[0])|(~C[3]&~C[2]&~C[1]&C[0])|	  //SEG off, digits(0,1,7)
						 (~C[3]&C[2]&C[1]&C[0]);						  //0000 OR 0001 OR 0111
	assign SEG[7] = 1'b1;
endmodule
