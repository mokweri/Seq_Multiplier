
module shift_reg
	#(parameter N=4)
	(
		input wire clk, clr,
		input wire load,
		input wire si,
		output wire so,
		input wire shiftr,
		input wire [N-1:0] D,
		output wire [N-1:0] Q
	);
	
	//signal declaration
	reg [N-1:0] r_reg, r_next;
	wire [1:0] ctrl;
	
	assign ctrl = {load,shiftr};
	
	//register
	always @(posedge clk, posedge clr)
		if (clr)
			r_reg <=0;
		else
			r_reg <= r_next;
	
	//next-state logic
	always @*
		case(ctrl)
			2'b10: r_next = D; //load
			2'b01: r_next = {si, r_reg[N-1:1]}; //shift right 
			default: r_next = r_reg; //no op
		endcase
	
	//output logic
	assign Q = r_reg;
	assign so = r_reg[0];
	
endmodule