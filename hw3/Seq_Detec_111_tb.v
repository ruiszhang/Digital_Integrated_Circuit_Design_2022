//序列检测电路111测试程序（可重叠）
//检测内容：0110 1110 1011 1011 1011 1101 0010
`timescale 1ns/1ns
module Seq_Detec_111_tb;
	reg clk;
	reg rst;
	reg x;
	
	wire [1:0] state;
	wire out;
	
	Seq_Detec_111 Seq_Detec_111_test(
		//input
		.clk(clk),
		.rst(rst),  //同步复位
		.x(x),
		//output
		.out(out),
		.state(state)
	);
	
	always #5 clk = ~clk;
	
	initial begin 
		rst = 1; x = 0; clk = 0; 
	#6	rst = 0; x = 1;
	#5	rst = 0; x = 1;
	#10	rst = 0; x = 0;
	#10	rst = 0; x = 1;
	#10	rst = 0; x = 1;
	#10	rst = 0; x = 1;
	#10	rst = 0; x = 0;	
	#10	rst = 0; x = 1;
	#10	rst = 0; x = 0;
	#10	rst = 0; x = 1;
	#10	rst = 0; x = 1;
	#10	rst = 1; x = 1;
	#10	rst = 0; x = 0;
	#10	rst = 0; x = 1;
	#10	rst = 0; x = 1;
	#10	rst = 0; x = 1;
	#10	rst = 0; x = 0;
	#10	rst = 0; x = 1;		
	#10	rst = 0; x = 1;
	#10	rst = 0; x = 1;
	#10	rst = 0; x = 1;
	#10	rst = 0; x = 0;		
	#10	rst = 0; x = 1;
	#10	rst = 0; x = 0;
	#10	rst = 0; x = 0;
	#10	rst = 0; x = 1;
	#10	rst = 0; x = 0;
	#10 $finish;
	end
	
	initial begin
	  $monitor($time,," out = %d ", out);
	  $dumpfile("Seq_Detec_111.vcd");
	  $dumpvars;
	end
	
endmodule
	