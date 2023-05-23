/*
	4 bit Ripple adder
*/
module Adder_4bit(a,b,cin,s,co);
	input [3:0] a,b;
	input cin;
	output [3:0] s;
	output co;
	
	//Internal signals
	wire [2:0] c;
	
	//Instantiate Full Adders
	full_adder F1(.a(a[0]),.b(b[0]),.cin(cin),.s(s[0]),.co(c[0]));
	full_adder F2(.a(a[1]),.b(b[1]),.cin(c[0]),.s(s[1]),.co(c[1]));
	full_adder F3(.a(a[2]),.b(b[2]),.cin(c[1]),.s(s[2]),.co(c[2]));
	full_adder F4(.a(a[3]),.b(b[3]),.cin(c[2]),.s(s[3]),.co(co));
	
endmodule

/********************************************
	Full Adder module
*/
module full_adder(a,b,cin,s,co);
	input a,b; //input bits
	input cin; //Carry in
	output s;	//Sum
	output co;	//Carry output
	
	assign s = ((a ^ b) ^ cin);
	assign co = ((a^b) == 1'b1) ? cin : b ;

endmodule