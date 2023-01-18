//homework1
`timescale 1ns/1ns
module net;
	supply1 	vdd;
	supply0 	gnd;
	wor 		d_wor;
	wand 		d_wand;
	trireg 		d_trireg;
	tri1 		d_tri1;
	tri0		d_tri0;
	
	reg 		in0;
	
	initial begin
			in0 = 1'bz;
		#10 in0 = 1;
		#10 in0 = 1'bz;
		#10 in0 = 0;
		#10 in0 = 1'bz;
		#10 in0 = 1'bx;
		#100 $finish;
	end
	
	assign d_wor = in0;
	assign d_wand = in0;
	assign d_trireg = in0;
	assign d_tri1 = in0;
	assign d_tri0 = in0;
	assign vdd = in0;
	assign gnd = in0;
	
	initial $monitor($time,,"d_tri1 strength is %v",d_tri1);
	
endmodule