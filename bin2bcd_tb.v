
`timescale 1 ns/10 ps
// The `timescale directive specifies that 
// the simulation time unit is 1 ns and
// the simulation timestep is 10 ps

module bin2bcd_tb();
	// signal and parameter declaration
	localparam T = 20; //clock period
	
	reg [7:0] bin;
	wire [9:0] bcd;
	
	

	
	// uut instantiation
	bin2bcd #(.W(8))binconverter (.bin(bin), .bcd(bcd));

	
	//other stimulus
	initial
	begin
		// ==== initial input =====
		bin = 8'd0;
		#(3*T);
		bin = 8'd1;
		#(3*T);
		bin = 8'd12;
		#(3*T);
		bin = 8'd25;
		#(3*T);
		bin = 8'd98;
		#(3*T);
		bin = 8'd129;
		#(3*T);
		bin = 8'd200;
		#(3*T);
		bin = 8'd255;
		#(3*T);

		

		// ==== stop simulation ====
		$stop; // return to interactive simulation mode
		end
	endmodule