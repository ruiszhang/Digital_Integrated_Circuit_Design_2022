//异步接口SRAM建模，时序检查
`timescale 1ns/1ns
module SRAMSP_1Kx8 #(
	parameter width = 8,
	parameter addr = 10,
	parameter depth = (1 << addr)
)(
	inout wire [width-1:0] data,
	input wire [addr-1:0] address,
	input wire cs,
	input wire rd,
	input wire wr,
	
	output reg se_c2a
	//output reg se_w2c
	//output reg se_r2c
	//output reg se_w2d
	//output reg sk_a2c
	//output reg sk_c2w
	//output reg sk_c2r
	//output reg wid_data
	//output reg sk_w2d
	
);
	reg [width-1:0] mem[depth-1:0];
	assign data = (!cs && !rd)? mem[address] : 'bz;
	reg [width-1:0] data_reg;
	
	always @(negedge wr)
		if(!cs) mem[address] <= data;
		
	specify
		$setup( posedge cs, negedge address, 2, se_c2a);
		//$setup(posedge wr, posedge cs, 1, se_w2c);
		//$setup(posedge rd, posedge cs, 1, se_r2c);
		//$setup(posedge wr, negedge data, 1, se_w2d);
		//$skew(posedge address, negedge cs, 2, sk_a2c);
		//$skew(negedge cs, negedge wr, 1, sk_c2w);
		//$skew(negedge cs, negedge rd, 1, sk_c2r);
		//$width(posedge data1, 4, 0, wid_data);
		//$skew(negedge rd, posedge data, 5, sk_w2d);
	endspecify
	
	always @(se_c2a)
	data_reg = 8'bx;
	
	assign data = data_reg;	
	
endmodule
