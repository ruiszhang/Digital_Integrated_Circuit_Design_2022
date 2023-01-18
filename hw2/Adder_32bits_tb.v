//Adder_32bits_testbench
`timescale 1ns/1ns
module Adder_32bits_tb;
	reg [31:0] a;
	reg [31:0] b;
	reg cin;
	
	wire [31:0] sum;
	wire cout;
	
	Adder_32bits Adder_32bits_test(
						.a_in	(a),
						.b_in	(b),
						.c_in (cin),
						.sum_o(sum),
						.c_o (cout)
						);
	
	initial begin
		 a = 32'd0; 	   b = 32'd0; 		cin = 0;
	#10	 a = 32'h57b451c7; b = 32'h9712093b;cin = 0;
	#10  a = 32'ha0000575; b = 32'h00004ab4;cin = 0;
	#10  a = 32'h4bbc3b1e; b = 32'h5aa64395;cin = 0;
	#10  a = 32'h0145b475; b = 32'h67845c86;cin = 1;
	#10  a = 32'hf00041c7; b = 32'h9677693b;cin = 1;
	#10  a = 32'h451bcd75; b = 32'h30981ab4;cin = 1;
	#10  a = 32'h00002b1e; b = 32'hd3950000;cin = 1;
	#10  a = 32'h0;        b = 32'h0;   	cin = 0;
	#10  a = 32'hfffffff0; b = 32'hf;   	cin = 1;
	#10  $finish;
	end
	
	initial begin
		$monitor("%d + %d + %d: %d %d", a, b, cin, cout, sum);
		$dumpfile("Adder_32bits.vcd");
		$dumpvars;
	end
	
endmodule