//32位ALU，不采用ALU_Code的方法，从电路角度设计
module ALU_core#(
	parameter n = 32
	)(
	//input
		opA,	//操作数A
		opB,	//操作数B
		S,		//工作模式选择信号
		M,		//逻辑操作控制信号
		Cin,	//进位输入信号
	//output
		DO,		//数据输出
		C,		//进位输出
		V,		//溢出指示输出信号
		N,		//DO符号位输出信号
		Z,		//DO为全0指示信号
	);
	
	input [n-1:0] opA;
	input [n-1:0] opB;
	input [3:0] 	S;
	input 			M;
	input 		  Cin;
	
	output [n-1:0] DO;
	output 			C;
	output 			V;
	output 			N;
	output 			Z;
	
	//将ALU扩展为33位计算，因为33位和32位不同时可判断为溢出
	wire [n:0] opA_ex;
	wire [n:0] opB_ex;
	wire [n:0] 	DO_ex;
	wire [n:0] 		g;
	wire [n:0] 		p;
	wire [n:0] 	   Ci;
	
	wire [n:0] S3_joint;
	wire [n:0] S2_joint;
	wire [n:0] S1_joint;
	wire [n:0] S0_joint;
	wire [n:0] M_joint;
	
	assign S3_joint = {33{S[3]}};
	assign S2_joint = {33{S[2]}};
	assign S1_joint = {33{S[1]}};
	assign S0_joint = {33{S[0]}};
	assign M_joint = {33{M}};
	
	assign opA_ex = {1'b0, opA};
	assign opB_ex = {1'b0, opB};	
	
	
	assign g =   (S3_joint & opA_ex & opB_ex)|(S2_joint & opA_ex & (~opB_ex))|(~M_joint);
	assign p = ~((S3_joint & opA_ex & opB_ex)|(S2_joint & opA_ex & (~opB_ex))|(S1_joint & opB_ex & (~opA_ex))|(S0_joint & (~opA_ex) & (~opB_ex)));
	
	assign Ci[0] = Cin;
	 
	genvar i;
	generate
		for(i=1;i<=32;i=i+1)
			begin: gen_Ci
			assign Ci[i] = ( Ci[i-1] & p[i-1] ) | g[i-1];
			end
	endgenerate

	assign DO_ex = p ^ Ci;
	
	//C、V、N在逻辑运算时无效
	assign DO = DO_ex[31:0];
	assign 	C = (M)?DO_ex[32]:0;
	assign 	V = (M)?(DO_ex[32] ^ DO_ex[31]):0;
	assign 	N = (M)?DO_ex[31]:0;
	assign 	Z = (DO == 0);

	  
endmodule
	
/*	
	always@*
		begin
			case({S,Cin,M})
				000010: DO_ex = 0;
				000110: DO_ex = (!opA_ex)&(!opB_ex);
				001010:	DO_ex = (!opA_ex)&opB_ex;
				001110: DO_ex = !opA_ex;
				010010: DO_ex = opA_ex&(!opB_ex);
				010110: DO_ex = !opB_ex;
				011010: DO_ex = (opA_ex&(!opB_ex))|((!opA_ex)&opB_ex);
				011110: DO_ex = (!opA_ex)|(!opB_ex);
				100010: DO_ex = opA_ex&opB_ex;
				100110: DO_ex = (opA_ex&opB_ex)|((!opA_ex)&(!opB_ex));
				101010: DO_ex = opB_ex;
				101110: DO_ex = (opA_ex&opB_ex)|((!opA_ex)&opB_ex)|((!opA_ex)&(!opB_ex));
				110010: DO_ex = opA_ex;
				110110: DO_ex = (opA_ex&opB_ex)|(opA_ex&(!opB_ex))|((!opA_ex)&(!opB_ex));
				111010: DO_ex = (opA_ex&opB_ex)|((!opA_ex)&opB_ex)|(opA_ex&(!opB_ex));
				111110: DO_ex = {33{1}};
				100101: DO_ex = opA_ex + opB_ex + Cin;
				011011: DO_ex = opA_ex - opB_ex - Cin;
*/				
			
	