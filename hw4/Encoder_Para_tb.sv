//Encoder_Para testbench
`timescale 1ns/1ns
module Encoder_Para_tb;
	reg clk;
	reg clr_n;
	
	//8线-3线编码器
	reg [7:0] in8;
	wire [2:0] out3;
	
	//16线-4线编码器
	reg [15:0] in16;
	wire [3:0] out4;
	
	Encoder_Para #(3)
	Encoder_Para_test0(
		//input
		.clk(clk),
		.clr_n(clr_n),
		.in(in8),
		//output
		.out(out3)
		);
		
	Encoder_Para #(4)
	Encoder_Para_test1(
		//input
		.clk(clk),
		.clr_n(clr_n),
		.in(in16),
		//output
		.out(out4)
		);
		
	always #5 clk = ~clk;
	
	initial begin
		  clr_n = 1; in8 = 8'h00; in16 = 16'h0000; clk = 1;
	#10	  clr_n = 1; in8 = 8'h01; in16 = 16'h0001; 
	#10	  clr_n = 1; in8 = 8'h02; in16 = 16'h0002; 
	#10	  clr_n = 1; in8 = 8'h03; in16 = 16'h0003; 
	#10	  clr_n = 1; in8 = 8'h04; in16 = 16'h0004; 
	#10	  clr_n = 1; in8 = 8'h06; in16 = 16'h0007; 
	#10	  clr_n = 1; in8 = 8'h08; in16 = 16'h0008; 
	#10	  clr_n = 1; in8 = 8'h10; in16 = 16'h0009; 
	#10	  clr_n = 0; in8 = 8'h10; in16 = 16'h0009; 
	#10	  clr_n = 1; in8 = 8'h21; in16 = 16'h0010; 
	#10	  clr_n = 1; in8 = 8'h42; in16 = 16'h002F; 
	#10	  clr_n = 1; in8 = 8'h8F; in16 = 16'h003E; 
	#10	  clr_n = 1; in8 = 8'h00; in16 = 16'h0048; 
	#10	  clr_n = 1; in8 = 8'h00; in16 = 16'h0088; 
	#10	  clr_n = 1; in8 = 8'h00; in16 = 16'h0105; 
	#10	  clr_n = 1; in8 = 8'h00; in16 = 16'h02FF; 
	#10	  clr_n = 1; in8 = 8'h00; in16 = 16'h04CD; 
	#10	  clr_n = 1; in8 = 8'h00; in16 = 16'h08DE; 
	#10	  clr_n = 1; in8 = 8'h00; in16 = 16'h1FFF; 
	#10	  clr_n = 1; in8 = 8'h00; in16 = 16'h2020; 
	#10	  clr_n = 1; in8 = 8'h00; in16 = 16'h40A0; 
	#10	  clr_n = 1; in8 = 8'h00; in16 = 16'h900F; 
	#10 $finish;
	end
	
endmodule
	
		
		
		