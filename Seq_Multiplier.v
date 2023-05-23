
module Seq_Multiplier(clk, resetn,start, a, b, p);
	input clk, resetn, start;
	input [3:0] a,b;
	output[7:0] p;
	
	wire [3:0] regB_, mult_B;
	wire [7:0] temp_P; //temporary product
	wire E;
	wire start_r; //start
	wire c; //carry
	wire [3:0]sum;
	wire so_PH; //serial out of PH
	wire so_PL; //serial out of PL
		
	//control signals
	wire Clr_PH, LD_PH,Shft_Rt, LD_PL,Dec_cnt,EN_Cnt,zero;
	wire [1:0] count;
	
	DFF_clrn Start_reg(.clk(clk),.clrn(resetn),.D(~start),.Q(start_r));
	
	Register_4bit regB(.clk(clk), .ld(LD_B), .a(b), .y(regB_)); //Multiplicand
	
	//And the LSB of shifted multiplier(PL) with multiplicand 
	assign mult_B[0] = regB_[0] & temp_P[0];
	assign mult_B[1] = regB_[1] & temp_P[0];
	assign mult_B[2] = regB_[2] & temp_P[0];
	assign mult_B[3] = regB_[3] & temp_P[0];
	
	
	Adder_4bit Adder(.a(temp_P[7:4]),.b(mult_B),.cin(1'b0),.s(sum),.co(c));
	
	//Register bank for multiplier and output of adder - shift registers
	shift_reg PH(.clk(clk),.clr(Clr_PH),.load(LD_PH),.shiftr(Shft_Rt),.si(E),.so(so_PH),.D(sum),.Q(temp_P[7:4]));
	shift_reg PL(.clk(clk), .clr(~resetn),.load(LD_PL),.shiftr(Shft_Rt),.si(so_PH),.so(so_PL),.D(a),.Q(temp_P[3:0])); 
	
	//Parallel load to allow loading of the multiplier (A).	
	shift_reg_si #(.N(1)) E_reg(.clk(clk),.clr(),.load(LD_E),.shiftr(Shft_Rt),.D(c),.Q(E));
	
	//Counter 
	counter  #(.N(2)) counterr(.clk(clk), .resetn(resetn),.syn_clr(1'b0), .load(LD_Cnt), .en(EN_Cnt),
	.up(Dec_Cnt),.d(2'd3),.max_tick(), .min_tick(zero),.q(count));
	
	//Multiplier controller - FSM 
	localparam [1:0] S0 = 2'b00,
						  S1 = 2'b01,
						  S2 = 2'b10;
							  
	// signal declaration
	reg [1:0] state_reg, state_next;
	
	//state register
	always@(posedge clk, negedge resetn)
		if(!resetn)
			state_reg <= S0;
		else
			state_reg <= state_next;
	
	// next-state logic
	always@*
		case(state_reg)
			S0: begin
					if(start_r)
						state_next <= S1;
					else
						state_next <= S0;
				end
			S1: begin
					if(start_r)
						state_next <= S1;
					else
						state_next <= S2;
			end
			S2: begin
				if(~zero)
					state_next <= S1;
				else
					state_next <= S0;
			end
			default: state_next <= S0;
		endcase
	
	//Generating Data Path Control Signals
	assign LD_PL = (state_reg==S0 & start_r)? 1'b1:1'b0;
	assign Clr_PH = (state_reg==S0 & start_r)? 1'b1:1'b0;
	assign LD_B = (state_reg==S0 & start_r)? 1'b1:1'b0;
	assign LD_Cnt = (state_reg==S0 & start_r)? 1'b1:1'b0;	
	assign LD_PH = (state_reg==S1 & ~start_r)? 1'b1:1'b0;
	assign LD_E = (state_reg==S1 & ~start_r)? 1'b1:1'b0;	
	assign Shft_Rt = (state_reg == S2)? 1'b1:1'b0;
	assign EN_Cnt = (state_reg == S2)? 1'b1:1'b0;
	assign Dec_Cnt = (state_reg == S2)? 1'b0:1'b1;	
	assign p = temp_P;	
endmodule

/*****************************************
	2 bit Counter
	counts from max to 0 on tick signals
	sets zero at 0
*/
module counter 
	#(parameter N=2)
	(
		input wire clk, resetn,
		input wire syn_clr, load, en, up,
		input wire [N-1:0] d,
		output wire max_tick, min_tick,
		output wire [N-1:0] q
	);
	
	//signal declaration
	reg [N-1:0] r_reg, r_next;
	
	//register
	always @(posedge clk, negedge resetn)
		if(~resetn)
			r_reg <= 0;
		else
			r_reg <= r_next;
			
	//next-state logic
	always @*
		if(syn_clr)
			r_next = 0;
		else if (load)
			r_next = d;
		else if (en & up)
			r_next = r_reg + 1;
		else if (en & ~up)
			r_next = r_reg - 1;
		else
			r_next = r_reg;
			
	 // output logic
	 assign q = r_reg;
	 assign max_tick = (r_reg==2**N-1) ? 1'b1 : 1'b0;
	 assign min_tick = (r_reg ==0) ? 1'b1 : 1'b0;
	 
endmodule

module DFF_clrn(
		input wire clk, clrn,
		input wire D,
		output reg Q
	);
	
	
	initial begin Q=0; end
	//register
	always @(posedge clk, negedge clrn)
		if (~clrn)
			Q <=0;
		else
			Q <= D;
	
endmodule
	
