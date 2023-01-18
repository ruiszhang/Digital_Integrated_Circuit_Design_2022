//ALU_core_testbench
`timescale 1ns/1ns
module ALU_core_tb;
	reg [31:0] opA;
	reg [31:0] opB;
	reg [3:0] 	 S;
	reg 		 M;
	reg 	   Cin;
	
	wire [31:0] DO;
	wire 		 C;
	wire 		 V;
	wire 		 N;
	wire 		 Z;
	
	ALU_core ALU_core_test(
	//input
			.opA(opA),	//操作数A
			.opB(opB),	//操作数B
			.S(S),		//工作模式选择信号
			.M(M),		//逻辑操作控制信号
			.Cin(Cin),	//进位输入信号
	//output
			.DO(DO),		//数据输出
			.C(C),		//进位输出
			.V(V),		//溢出指示输出信号
			.N(N),		//DO符号位输出信号
			.Z(Z)		//DO为全0指示信号
			);
			
	initial begin
			opA = 32'h0; opB = 32'h0; S = 4'b0; Cin = 1; M = 0; //000010: DO_ex = 0;
		#10 opA = 32'h00000003; opB = 32'h00000002; S = 4'd1; Cin = 1; M = 0; //000110: DO_ex = (!opA_ex)&(!opB_ex);
		#10 opA = 32'hF0000030; opB = 32'hF0000020; S = 4'd2; Cin = 1; M = 0; //001010: DO_ex = (!opA_ex)&opB_ex;
		#10 opA = 32'hF0000000; opB = 32'h0FF0C0E1; S = 4'd3; Cin = 1; M = 0; //001110: DO_ex = !opA_ex;
		#10 opA = 32'hFFFFFFFF; opB = 32'h0FF0C0E1; S = 4'd3; Cin = 1; M = 0; 
		#10 opA = 32'hF0000000; opB = 32'hF0DF30FF; S = 4'd4; Cin = 1; M = 0; //010010: DO_ex = opA_ex&(!opB_ex);
		#10 opA = 32'hFF0C0E10; opB = 32'hFF0C0E10; S = 4'd5; Cin = 1; M = 0; //010110: DO_ex = !opB_ex;
		#10 opA = 32'hFF0C0E10; opB = 32'hFFFFFFFF; S = 4'd5; Cin = 1; M = 0; 
		#10 opA = 32'h000F0000; opB = 32'h00DF000F; S = 4'd6; Cin = 1; M = 0; //011010: DO_ex = (opA_ex&(!opB_ex))|((!opA_ex)&opB_ex);
		#10 opA = 32'h000F0000; opB = 32'h00DF000F; S = 4'd7; Cin = 1; M = 0; //011110: DO_ex = (!opA_ex)|(!opB_ex);
		#10 opA = 32'h000C0010; opB = 32'h1000300F; S = 4'd8; Cin = 1; M = 0; //100010: DO_ex = opA_ex&opB_ex;
		#10 opA = 32'h000F0000; opB = 32'h00001000; S = 4'd9; Cin = 1; M = 0; //100110: DO_ex = (opA_ex&opB_ex)|((!opA_ex)&(!opB_ex));
		#10 opA = 32'hFFFFE0FF; opB = 32'h70F0C0E0; S = 4'd10; Cin = 1; M = 0; //101010: DO_ex = opB_ex;
		#10 opA = 32'h000F0000; opB = 32'h0000C000; S = 4'd11; Cin = 1; M = 0; //101110: DO_ex = (opA_ex&opB_ex)|((!opA_ex)&opB_ex)|((!opA_ex)&(!opB_ex));
		#10 opA = 32'hFFFFE0FF; opB = 32'h70F0C0E0; S = 4'd12; Cin = 1; M = 0; //110010: DO_ex = opA_ex;
		#10 opA = 32'h000F0000; opB = 32'h00D00000; S = 4'd13; Cin = 1; M = 0; //110110: DO_ex = (opA_ex&opB_ex)|(opA_ex&(!opB_ex))|((!opA_ex)&(!opB_ex));
		#10 opA = 32'h000F0000; opB = 32'h0000000F; S = 4'd14; Cin = 1; M = 0; //111010: DO_ex = (opA_ex&opB_ex)|((!opA_ex)&opB_ex)|(opA_ex&(!opB_ex));
		#10 opA = 32'h000F0000; opB = 32'hFFFFE0FF; S = 4'd15; Cin = 1; M = 0; //111110: DO_ex = {33{1}};
		#10 opA = 32'h000000F0; opB = 32'h00000F00; S = 4'd9; Cin = 0; M = 1; //100101: DO_ex = opA_ex + opB_ex + Cin;
		#10 opA = 32'h80000000; opB = 32'h80000000; S = 4'd9; Cin = 0; M = 1; 
		#10 opA = 32'h00000011; opB = 32'h00000001; S = 4'd6; Cin = 1; M = 1; //011011: DO_ex = opA_ex - opB_ex - Cin;
		#10 opA = 32'h00000001; opB = 32'h00000011; S = 4'd6; Cin = 1; M = 1; 
		
		#10 $finish;
	end
		
	initial begin
		$monitor("%b %b %b %b %b : %b %b %b %b %b", opA, opB, S, Cin, M, DO, C, V, N, Z);
		$dumpfile("ALU_core.vcd");
		$dumpvars;
	end
	
endmodule