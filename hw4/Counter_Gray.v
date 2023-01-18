//4位格雷码计数器：利用状态转换
//其他方法：先用自然二进制码计数，再二进制码转格雷码，即gray_cnt = binary_cnt^(binary_cnt>>1)
module Counter_Gray(
	//input 
	clk,
	clr_n,
	//output
	gray_cnt
	);
	
	input clk;
	input clr_n;
	output reg [3:0] gray_cnt;
	reg [3:0] cnt;
	
	initial gray_cnt = 4'b0;
	
	always @(posedge clk)
	begin 
		if(clr_n == 0) gray_cnt = 0;
		else 
			begin
				case(gray_cnt)
				4'b0000: gray_cnt = 4'b0001;
				4'b0001: gray_cnt = 4'b0011;
				4'b0011: gray_cnt = 4'b0010;
				4'b0010: gray_cnt = 4'b0110;
				4'b0110: gray_cnt = 4'b0111;
				4'b0111: gray_cnt = 4'b0101;
				4'b0101: gray_cnt = 4'b0100;
				4'b0100: gray_cnt = 4'b1100;
				4'b1100: gray_cnt = 4'b1101;
				4'b1101: gray_cnt = 4'b1111;
				4'b1111: gray_cnt = 4'b1110;
				4'b1110: gray_cnt = 4'b1010;
				4'b1010: gray_cnt = 4'b1011;
				4'b1011: gray_cnt = 4'b1001;
				4'b1001: gray_cnt = 4'b0000;
				endcase
			end
	end
endmodule
	