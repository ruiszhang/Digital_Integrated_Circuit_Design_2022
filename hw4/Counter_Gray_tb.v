//Counter_Gray testbench
`timescale 1ns/1ns
module Counter_Gray_tb;
	reg clk;
	reg clr_n;
	wire [3:0] gray_cnt;
	
	Counter_Gray Counter_Gray_test(
		//input 
		.clk(clk),
		.clr_n(clr_n),
		//output
		.gray_cnt(gray_cnt)
	);
	
	always #5 clk = ~clk;
	
	initial begin
		 clr_n = 1; clk = 1; 
	#51  clr_n = 0;
	#10  clr_n = 1;
	#230 $finish;
	end
	
endmodule