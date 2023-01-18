//序列检测电路（不重叠检测）
//检测内容：01110
module Seq_Detec(
	//Input
		clk,
		clr, 
		A,
		B,
	//Output
		Z,
		state
	);
	parameter S = 0, S0 = 1, S01 = 2, S011 = 3, S0111 = 4, S1 = 5;//状态机的6个状态编码，S1为输出为1的状态
	
	input clk;
	input clr; //低电平有效的异步复位信号
	input 	A;
	input 	B;
	
	output reg Z;
	output [2:0] state;
	
	reg [2:0] current_state;
	reg [2:0] 	 next_state;
	reg flag; //状态指示
	
	//二段式状态机描述
	always @(posedge clk or negedge clr) //异步复位
	begin
		if(!clr) current_state = S; 
		else 	 current_state = next_state;
	end
	
	always @(*) //随时探测输入信号
	begin 
		case(current_state)
			S: 		if	   (A==0&&B==0)  begin next_state = S0;    Z = 0; flag = 0; end 
					else if(A==1&&B==0)  begin next_state = S0;    Z = 0; flag = 0; end 
					else if(A==0&&B==1)  begin next_state = S01;   Z = 0; flag = 0; end 
					else 				 begin next_state = S; 	   Z = 0; flag = 0; end
					
			S0:		if	   (A==0&&B==0)  begin next_state = S0;    Z = 0||flag; flag = 0; end 
					else if(A==1&&B==0)  begin next_state = S; 	   Z = 0||flag; flag = 0; end 
					else if(A==0&&B==1)  begin next_state = S01;   Z = 0||flag; flag = 0; end 
					else 				 begin next_state = S011;  Z = 0||flag; flag = 0; end
					
			S01:	if	   (A==0&&B==0)  begin next_state = S0;    Z = 0; flag = 0; end 
					else if(A==1&&B==0)  begin next_state = S0;    Z = 0; flag = 0; end 
					else if(A==0&&B==1)  begin next_state = S; 	   Z = 0; flag = 0; end 
					else 				 begin next_state = S0111; Z = 0; flag = 0; end
					
			S011:   if	   (A==0&&B==0)  begin next_state = S0;    Z = 0; flag = 0; end 
					else if(A==1&&B==0)  begin next_state = S1;    Z = 0; flag = 0; end //回到S是因为相邻数据位不重叠（不进行重叠检测）
					else if(A==0&&B==1)  begin next_state = S01;   Z = 0; flag = 0; end 
					else 				 begin next_state = S;     Z = 0; flag = 0; end
					
			S0111:  if	   (A==0&&B==0)  begin next_state = S1;    Z = 0; flag = 1; end 
					else if(A==1&&B==0)  begin next_state = S0;    Z = 0; flag = 0; end 
					else if(A==0&&B==1)  begin next_state = S1;    Z = 0; flag = 0; end 
					else 				 begin next_state = S;     Z = 0; flag = 0; end
					
			S1:  	if	   (A==0&&B==0)  begin next_state = S0;    Z = 1; flag = 0; end 
					else if(A==1&&B==0)  begin next_state = S0;    Z = 1; flag = 0; end 
					else if(A==0&&B==1)  begin next_state = S01;   Z = 1; flag = 0; end 
					else 				 begin next_state = S; 	   Z = 1; flag = 0; end
		endcase
	end
	
	assign state = current_state;
	
endmodule
	