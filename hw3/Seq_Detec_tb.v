//序列检测电路测试程序（不重叠检测）
//检测内容：110100111011011100011100100
`timescale 1ns/1ns
module Seq_Detec_tb;
	reg clk;
	reg clr; //低电平有效

	reg A;
	reg B;
	
	wire Z;
	wire [2:0] state;
	
	Seq_Detec Seq_Detec_test(
	//Input
		.clk(clk),
		.clr(clr), 
		.A(A),
		.B(B),
	//Output
		.Z(Z),
		.state(state)
	);
	
	always #5 clk = ~clk;
	
	initial begin 
		 A = 1; B = 1; clr = 0; clk = 0;
	#11   A = 0; B = 1; clr = 1;
	#10  A = 0; B = 0; clr = 1;
	#10  A = 1; B = 1; clr = 1;
	#10  A = 1; B = 0; clr = 1;
	#10  A = 1; B = 1; clr = 1;
	#10  A = 0; B = 1; clr = 1;
	#10  A = 1; B = 1; clr = 1;
	#10  A = 1; B = 1; clr = 0;
	#10  A = 0; B = 0; clr = 1;
	#10  A = 0; B = 1; clr = 1;
	#10  A = 1; B = 1; clr = 1;
	#10  A = 0; B = 0; clr = 1;	
	#10  A = 1; B = 0; clr = 1;
	#10 $finish;
	end
	
	initial begin
		$monitor($time,,"Z = %d", Z);
		$dumpfile("Seq_Detec.vcd");
		$dumpvars;
	end
	
endmodule
	
	
	
	
	