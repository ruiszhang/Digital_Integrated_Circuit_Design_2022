//参数化译码器（位数可指定）
module Decoder_Para(
	//input
	clk,
	clr_n, 
	in,
	//output
	out
	);
	
	parameter n, m = 1 << n;
	input clk;
	input clr_n;
	input [n-1:0] in;
	
	output reg [m-1:0] out;
	
	always @(posedge clk) //同步清零
	begin
		if(clr_n == 1) out <= 1 << in;
	    //             out <= 2**in;
		else 		   out <= 0;
	end
	
endmodule