//FIFO_asyn_64x8_NULL testbench
`timescale 1ns/1ns
module FIFO_asyn_64x8_NULL_tb;
	reg wr_clk;
	reg rd_clk;
	reg wr_rstn;
	reg rd_rstn;
	reg wr_en;
	reg rd_en;
	reg [7:0] wr_data;
	
	wire wr_overflow;
	wire rd_underflow;
	wire [7:0] rd_data;
	
	wire [5:0] wr_ptr;
	wire [5:0] rd_ptr;
	wire [5:0] count;
	
	
	FIFO_asyn_64x8_NULL FIFO_asyn_64x8_NULL_test(
	//input
		.wr_clk(wr_clk),  					//写时钟
		.rd_clk(rd_clk),  					//读时钟
		.wr_rstn(wr_rstn), 					//写复位（低电平有效）
		.rd_rstn(rd_rstn), 					//读复位（低电平有效）
		.wr_en(wr_en),   					//写使能
		.rd_en(rd_en),   					//读使能
		.wr_data(wr_data), 					//写入的数据

	//output
		.wr_overflow(wr_overflow),			//FIFO将满，75%（影响写入，在写时钟端判断）
		.rd_underflow(rd_underflow),		//FIFO将空，25%（影响读出，在读时钟端判断）
		.rd_data(rd_data), 					//读出的数据
	//output_for_test
		.wr_ptr(wr_ptr),  //写指针，指向下一个要写的位置
		.rd_ptr(rd_ptr),  //读指针，指向下一个要读的位置
		.count(count)     //计数FIFO中的数据个数
	);
	
	always #25 wr_clk = ~wr_clk;
	always #20 rd_clk = ~rd_clk;
	
	initial begin
		wr_en = 0; rd_en = 0; wr_rstn = 1; rd_rstn = 1; wr_data = 8'b0; wr_clk = 0; rd_clk = 0;
	#10	wr_rstn = 0; rd_rstn = 0;
	#20	wr_rstn = 1; rd_rstn = 1;
	
	@ (negedge wr_clk);
	wr_data = 10;
	wr_en = 1;
	
	@ (negedge wr_clk);
	wr_data = 20;
	@ (negedge wr_clk);
	wr_data = 30;
	@ (negedge wr_clk);
	wr_data = 40;
	@ (negedge wr_clk);
	wr_data = 50;
	@ (negedge wr_clk);
	wr_data = 60;
	@ (negedge wr_clk);
	wr_data = 70;
	@ (negedge wr_clk);
	wr_data = 80;
	@ (negedge wr_clk);
	wr_data = 90;
	@ (negedge wr_clk);
	wr_data = 100;
	@ (negedge wr_clk);
	wr_data = 110;
	
	@ (negedge wr_clk);
	wr_en = 0;
	
	@ (negedge rd_clk);
	rd_en = 1;
	#80
	@ (negedge rd_clk);
	rd_en = 0;
	
	@(negedge wr_clk);
	wr_data = 120;
	wr_en = 1;
	@(negedge wr_clk);
	wr_data = 130;
	@(negedge wr_clk);
	wr_data = 140;
	@(negedge wr_clk);
	wr_data = 150;
	@(negedge wr_clk);
	wr_data = 160;
	@(negedge wr_clk);
	wr_data = 170;
	@(negedge wr_clk);
	wr_data = 180;
	@(negedge wr_clk);
	wr_data = 190;
	@(negedge wr_clk);
	wr_data = 200;
	@(negedge wr_clk);
	wr_data = 201;
	@(negedge wr_clk);
	wr_data = 202;
	@(negedge wr_clk);
	wr_data = 203;
	
	@ (negedge rd_clk);
	rd_en = 1;
	#40
	@ (negedge rd_clk);
	rd_en = 0;
	
	@(negedge wr_clk);
	wr_data = 204;
	@(negedge wr_clk);
	wr_data = 205;
	@(negedge wr_clk);
	wr_data = 206;
	@(negedge wr_clk);
	wr_data = 207;
	@(negedge wr_clk);
	wr_data = 208;
	@(negedge wr_clk);
	wr_data = 209;
	@(negedge wr_clk);
	wr_data = 210;
	@(negedge wr_clk);
	wr_data = 211;
	@(negedge wr_clk);
	wr_data = 212;
	@(negedge wr_clk);
	wr_data = 213;
	@(negedge wr_clk);
	wr_data = 214;
	@(negedge wr_clk);
	wr_data = 215;
	
	@(negedge wr_clk);
	wr_data = 0;
	@(negedge wr_clk);
	wr_data = 0;
	
	@(negedge wr_clk);
	wr_data = 216;
	@(negedge wr_clk);
	wr_data = 217;
	@(negedge wr_clk);
	wr_data = 218;
	@(negedge wr_clk);
	wr_data = 219;
	@(negedge wr_clk);
	wr_data = 220;
	@(negedge wr_clk);
	wr_data = 221;
	@(negedge wr_clk);
	wr_data = 222;
	@(negedge wr_clk);
	wr_data = 223;
	@(negedge wr_clk);
	wr_data = 224;
	@(negedge wr_clk);
	wr_data = 225;
	@(negedge wr_clk);
	wr_data = 226;
	
	@(negedge wr_clk);
	wr_data = 0;
	@(negedge wr_clk);
	wr_data = 0;
	
	@(negedge wr_clk);
	wr_data = 227;
	@(negedge wr_clk);
	wr_data = 228;
	@(negedge wr_clk);
	wr_data = 229;
	@(negedge wr_clk);
	wr_data = 230;
	@(negedge wr_clk);
	wr_data = 231;
	@(negedge wr_clk);
	wr_data = 232;
	@(negedge wr_clk);
	wr_data = 233;
	@(negedge wr_clk);
	wr_data = 234;
	@(negedge wr_clk);
	wr_data = 235;
	
	@(negedge wr_clk);
	wr_data = 0;
	
	@(negedge rd_clk);
	rd_en = 1;
	#600;
	
	@(negedge rd_clk);
	rd_en = 0;
	
		
	@ (negedge wr_clk);
	wr_en = 0;
	
	@(negedge wr_clk);
	wr_data = 236;

	
	@ (negedge rd_clk);
	rd_en = 1;
	#1920
	@ (negedge rd_clk);
	rd_en = 0;
	
	
	#50 $finish;
	end
	
endmodule
