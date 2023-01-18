//Decoder_Para testbench
`timescale 1ns/1ns
module Decoder_Para_tb;
	reg clk;
	reg clr_n;
	
	//3线-8线译码器测试
	reg [2:0] in3;
	wire [7:0] out8;
	
	//4线-16线译码器测试
	reg [3:0] in4;
	wire [15:0] out16;
	
	Decoder_Para #(3)
		Decoder_Para_test0(
		//input
		.clk(clk),
		.clr_n(clr_n), 
		.in(in3),
		//output
		.out(out8)
		);
		
	Decoder_Para #(4) 
		Decoder_Para_test1(
		//input
		.clk(clk),
		.clr_n(clr_n), 
		.in(in4),
		//output
		.out(out16)
		);
		
	always #5 clk = ~clk;
	
	initial begin
				clr_n = 1; in3 = 0;    in4 = 0;    clk = 1; 
		#10	 	clr_n = 1; in3 = 3'd1; in4 = 4'd1;
		#10	 	clr_n = 1; in3 = 3'd2; in4 = 4'd2;
		#10	 	clr_n = 1; in3 = 3'd3; in4 = 4'd3;
		#10	 	clr_n = 1; in3 = 3'd4; in4 = 4'd4;
		#10	 	clr_n = 1; in3 = 3'd5; in4 = 4'd5;
		#10	 	clr_n = 1; in3 = 3'd6; in4 = 4'd6;
		#10	 	clr_n = 0; in3 = 3'd6; in4 = 4'd6;
		#10	 	clr_n = 1; in3 = 3'd7; in4 = 4'd7;
		#10 	clr_n = 1; in3 = 3'd0; in4 = 4'd8;
		#10 	clr_n = 1; in3 = 3'd0; in4 = 4'd9;
		#10 	clr_n = 1; in3 = 3'd0; in4 = 4'd10;
		#10 	clr_n = 1; in3 = 3'd0; in4 = 4'd11;
		#10 	clr_n = 1; in3 = 3'd0; in4 = 4'd12;
		#10 	clr_n = 1; in3 = 3'd0; in4 = 4'd13;
		#10 	clr_n = 1; in3 = 3'd0; in4 = 4'd14;
		#10	 	clr_n = 1; in3 = 3'd6; in4 = 4'd15;
		#10 $finish;
	end
	
	initial begin 
		$monitor(" in3 = %d, out8 = %b; in4 = %d, out16 = %b ", in3, out8, in4, out16);
		$dumpfile("Decoder_Para.vcd");
		$dumpvars;
	end
	
endmodule
	
	
	
	
	
	
	