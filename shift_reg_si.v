module shift_reg_si
	#(parameter N=1)
	(
		input wire clk, clr,
		input wire load,
		input wire shiftr,
		input wire [N-1:0] D,
		output wire [N-1:0] Q
	);
	
	//signal declaration
	reg [N-1:0] r_reg, r_next;
	
	initial begin r_reg=0; end
	//register
	always @(posedge clk, posedge clr)
		if (clr)
			r_reg <=0;
		else
			r_reg <= r_next;
	
	//next-state logic
	always @*
		case({load,shiftr})
			2'b10: r_next = D; //load
			2'b01: r_next = 1'b0; //shift right 
			default: r_next = r_reg; //no op
		endcase
	
	//output logic
	assign Q = r_reg;
	
endmodule