//CLA_4bits_testbench
`timescale 1ns/1ns
module CLA_4bits_tb;

	reg [3:0] a;
	reg [3:0] b;
	reg 	cin;
	
	wire [3:0] sum;
	wire 	  cout;
	
	CLA_4bits CLA_4bits_test(
			.a(a)      ,
			.b(b)      ,
			.cin(cin)  ,
			.cout(cout),
			.s(sum)
	);
	
	initial begin
			a = 4'd0; b = 4'd0; cin = 1'd0;	
	#10		a = 4'd1; b = 4'd2; cin = 1'd1;	
	#10		a = 4'd5; b = 4'd10; cin = 1'd1;		
	#10		a = 4'd15; b = 4'd0; cin = 1'd0;	
	#10		a = 4'd15; b = 4'd0; cin = 1'd1;	
	#10		a = 4'd15; b = 4'd15; cin = 1'd0;	
	#10		a = 4'd0; b = 4'd15; cin = 1'd0;	
	#10		a = 4'd0; b = 4'd15; cin = 1'd1;	
	#10		a = 4'd15; b = 4'd15; cin = 1'd1;	
	#10 $finish;
	end
	
	initial begin
		$monitor("%d+%d+%d: %b %b", a, b, cin, cout, sum);
		$dumpfile("CLA_4bits.vcd");
		$dumpvars;
	end
	
endmodule
	