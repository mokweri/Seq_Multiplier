
`timescale 1 ns/10 ps
// The `timescale directive specifies that 
// the simulation time unit is 1 ns and
// the simulation timestep is 10 ps

module shift_reg_tb();
	// signal and parameter declaration
	localparam T = 20; //clock period
	reg clk, resetn;
	
	reg [3:0] D;
	reg Clr_RG,LD_RG,Shft_Rt;
	wire [3:0] Q;
	wire so_REG;
	reg E;
	
	// uut instantiation
	shift_reg register(.clk(clk),.clr(Clr_RG),.load(LD_RG),.shiftr(Shft_Rt),.si(E),.so(so_REG),.D(D),.Q(Q));

	 
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
		LD_RG = 1'b0;
		Shft_Rt = 1'b0;
		resetn = 1'b0;
		#(T/2);
		resetn = 1'b1;
	end
	
	//other stimulus
	initial
	begin
		// ==== initial input =====
		Clr_RG = 1'b1;
		#(T);
		Clr_RG = 1'b0;
		E = 1'b1;
		#(T);

		// ==== absolute delay ====
		D = 4'b1010;
		LD_RG = 1'b1;
		#(1*T); // wait for 80 ns
		LD_RG = 1'b0;
		#(2*T); // wait for 80 ns
		Shft_Rt = 1'b1;
		#(1*T);
		Shft_Rt = 1'b0;
		#(3*T);
		

		// ==== stop simulation ====
		$stop; // return to interactive simulation mode
		end
	endmodule