
`timescale 1 ns/10 ps
// The `timescale directive specifies that 
// the simulation time unit is 1 ns and
// the simulation timestep is 10 ps

module Seq_Multiplier_tb();
	// signal and parameter declaration
	localparam T = 20; //clock period
	reg clk, resetn;
	reg start;
	reg [3:0] a,b;
	wire [7:0] p;
	
	// uut instantiation
	Seq_Multiplier uut(.clk(clk), .resetn(resetn),.start(start), .a(a), .b(b), .p(p));

	 
	//Clock Generation
	//20 ns clock running forever
	always
	begin
		clk = 1'b1;
		#(T/2);
		clk = 1'b0;
		#(T/2);
	end
	
	//reset for first half cycle
	initial
	begin
		start = 1'b0;
		resetn = 1'b0;
		#(T/2);
		resetn = 1'b1;
		
	end
	
	//other stimulus
	initial
	begin
		// ==== initial input =====
		a = 4'd14;
		b = 4'd9;
		#(2*T);

		// ==== absolute delay ====

		start = 1'b1;
		#(T); // wait for 80 ns
		start = 1'b0;
		#(9*T); // wait for 80 ns
		
		a = 4'd12;
		b = 4'd2;
		#(T);
		start = 1'b1;
		#(T);
		start = 1'b0;
		#(9*T); // wait for 80 ns
		
		a = 4'd6;
		b = 4'd11;
		#(T);
		start = 1'b1;
		#(T);
		start = 1'b0;
		#(9*T); // wait for 80 ns
		
		a = 4'd15;
		b = 4'd15;
		#(T);
		start = 1'b1;
		#(T);
		start = 1'b0;
		#(9*T); // wait for 80 ns
		// ==== stop simulation ====
		$stop; // return to interactive simulation mode
		end
	endmodule