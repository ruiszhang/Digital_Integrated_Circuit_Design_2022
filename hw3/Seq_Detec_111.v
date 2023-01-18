//序列检测电路：111（可重叠检测，但要在时钟上升沿探测到信号）
module Seq_Detec_111(
	//input
		clk,
		rst,  //同步复位
		x,
	//output
		out,
		state
	);
	
	input clk;
	input rst;
	input x;
	
	output reg out;
	output [1:0] state;
	
	parameter S = 0, S1 = 1, S11 = 2, S111 = 3; //4个状态编码
	
	reg [1:0] current_sate;
	reg [1:0] next_state;
	
	always @(posedge clk) //同步复位
	begin
		if(rst) current_sate = S; 
		else current_sate = next_state;
	end
	
	always @(posedge clk) //只在时钟上升沿探测信号
	begin 
		case(current_sate)
			S:    if(x) begin next_state = S1;   out = 0; end
				  else  begin next_state = S;    out = 0; end
			S1:   if(x) begin next_state = S11;  out = 0; end
				  else  begin next_state = S;    out = 0; end
			S11:  if(x) begin next_state = S111; out = 0; end
				  else  begin next_state = S;    out = 0; end
			S111: if(x) begin next_state = S111; out = 1; end
				  else  begin next_state = S;    out = 1; end
		endcase
	end
	
	assign state = current_sate;
	
endmodule
				
				