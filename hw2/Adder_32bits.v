//32位加法器，4位一组，组内使用超前进位，组间使用行波进位
module Adder_32bits(
	//input
	a_in,
	b_in,
	c_in,
	//output
	sum_o,
	c_o
	);
	
	input [31:0] a_in;
	input [31:0] b_in;
	input 		 c_in;
	
	output [31:0] sum_o;
	output 			c_o;
	
	wire [7:0] cout;
	
	CLA_4bits #(4) adder0(
						.a   (a_in[3:0]), 
						.b   (b_in[3:0]), 
						.cin (c_in), 
						.s	 (sum_o[3:0]), 
						.cout(cout[0])
						);
	CLA_4bits #(4) adder1(
						.a	 (a_in[7:4]), 
						.b	 (b_in[7:4]), 
						.cin (cout[0]), 
						.s	 (sum_o[7:4]), 
						.cout(cout[1])
						);
	CLA_4bits #(4) adder2(
						.a   (a_in[11:8]), 
						.b   (b_in[11:8]), 
						.cin (cout[1]), 
						.s	 (sum_o[11:8]), 
						.cout(cout[2])
						);
	CLA_4bits #(4) adder3(
						.a	 (a_in[15:12]), 
						.b	 (b_in[15:12]), 
						.cin (cout[2]), 
						.s	 (sum_o[15:12]), 
						.cout(cout[3])
						);
	CLA_4bits #(4) adder4(
						.a	 (a_in[19:16]), 
						.b	 (b_in[19:16]), 
						.cin (cout[3]), 
						.s	 (sum_o[19:16]), 
						.cout(cout[4])
						);		
	CLA_4bits #(4) adder5(
						.a	 (a_in[23:20]), 
						.b	 (b_in[23:20]), 
						.cin (cout[4]), 
						.s	 (sum_o[23:20]), 
						.cout(cout[5])
						);
	CLA_4bits #(4) adder6(
						.a	 (a_in[27:24]), 
						.b	 (b_in[27:24]), 
						.cin (cout[5]), 
						.s	 (sum_o[27:24]), 
						.cout(cout[6])
						);
	CLA_4bits #(4) adder7(
						.a	 (a_in[31:28]), 
						.b	 (b_in[31:28]), 
						.cin (cout[6]), 
						.s	 (sum_o[31:28]), 
						.cout(cout[7])
						);	

	assign c_o = cout[7];

endmodule	