`timescale 1ns/1ns
`include"SRAMSP_1Kx8.v"
module SRAMSP_1Kx8_tb;
	wire [7:0] data;
	reg [9:0] address;
	reg cs;
	reg rd;
	reg wr;
	
	wire se_c2a;
	//wire se_w2c;
	//wire se_w2d;
	//wire sk_a2c;
	//wire sk_c2w;
	//wire wid_data;
	//wire sk_w2d;
	//wire se_r2c;
	//wire sk_c2r;
	
	wire clk;
	reg en;
	reg data0;

SRAMSP_1Kx8 SRAMSP_1Kx8_test(
	.data(data),
	.address(address),
	.cs(cs),
	.rd(rd),
	.wr(wr),
	.se_c2a(se_c2a)
	//.se_w2c(se_w2c),
	//.se_w2d(se_w2d),
	//.sk_a2c(sk_a2c)
	//.sk_c2w(sk_c2w),
	//.wid_data(wid_data)
	//.sk_w2d(sk_w2d),
	//.se_r2c(se_r2c),
	//.sk_c2r(sk_c2r)
	);
	
	assign data = !wr? data0 : 4'bz;
	
	and #(0.8, 0.2) (clk, en, !clk);
	
	initial begin
		data0 = 0; en = 0; address = 0; cs = 1; rd = 1; wr = 1;
	#5  data0 = 1; en = 0; address = 5; cs = 1; rd = 1; wr = 0;
	#1  data0 = 1; en = 0; address = 5; cs = 0; rd = 0; wr = 1;
	#2  data0 = 0; en = 1; address = 0; cs = 1; rd = 1; wr = 0;
	#1  data0 = 1; en = 1; address = 5; cs = 1; rd = 1; wr = 0;
	#2  data0 = 0; en = 0; address = 0; cs = 0; rd = 0; wr = 1;
	#4  data0 = 1; en = 1; address = 5; cs = 1; rd = 1; wr = 0;
	#1  data0 = 1; en = 0; address = 0; cs = 0; rd = 0; wr = 1;
	#4  data0 = 1; en = 0; address = 0; cs = 1; rd = 0; wr = 1;
	#20 $finish;
	end
	
endmodule
	
	
		
		
		
		
		
		
		
		
		
		
		
		
		
	