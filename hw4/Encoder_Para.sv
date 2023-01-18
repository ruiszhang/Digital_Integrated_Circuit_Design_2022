//参数化优先编码器（可指定位数）
//关键问题：break在systemverilog中才有，因此文件要保存成.sv，否则仿真时无法加载。但break是不可综合的。
module Encoder_Para(
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
	input [m-1:0] in;
	
	output reg [n-1:0] out;
	
	integer i;
	always @(posedge clk)
	begin
		if(clr_n == 0) out <= 0; //同步清零
		else 
			begin 
				for(i = m-1; i > 0; i = i - 1) //从最高位开始遍历，结合break，可以保证优先级
				begin: u
					if(in[i] == 1) begin out <= i; break; end 
					//break在systemverilog中才有，因此文件要保存成.sv
					else out <= 0;
				end
			end
	end
	
endmodule