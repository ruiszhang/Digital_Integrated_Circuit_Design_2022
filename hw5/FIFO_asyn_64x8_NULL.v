//异步FIFO，未考虑时钟同步，用NULL处理
module FIFO_asyn_64x8_NULL #(
	//param
		parameter DEPTH = 6, 				//数据深度（2^6）
		parameter WIDTH = 8,				//每个数据的宽度（8位）
		parameter MAX_COUNT = (1 << DEPTH), //存储器中的数据个数（2^6）
		parameter NULL = 8'b0
	)(
	//input
		input wr_clk,  					//写时钟
		input rd_clk,  					//读时钟
		input wr_rstn, 					//写复位（低电平有效）
		input rd_rstn, 					//读复位（低电平有效）
		input wr_en,   					//写使能
		input rd_en,   					//读使能
		input [WIDTH-1:0] wr_data, 		//写入的数据

	//output
		output reg wr_overflow,			//FIFO将满，75%（影响写入，在写时钟端判断）
		output reg rd_underflow,		//FIFO将空，25%（影响读出，在读时钟端判断）
		output reg [WIDTH-1:0] rd_data,  //读出的数据
	//output_for_test
		output reg [DEPTH-1:0] wr_ptr,  //写指针，指向下一个要写的位置
		output reg [DEPTH-1:0] rd_ptr,	//读指针，指向下一个要读的位置
		output reg [DEPTH-1:0] count    //计数FIFO中的数据个数
	);
	
	/*
	//定义读写指针
	reg [DEPTH-1:0] wr_ptr; //写指针，指向下一个要写的位置
	reg [DEPTH-1:0] rd_ptr; //读指针，指向下一个要读的位置
	*/
	
	//定义FIFO存储器
	reg [WIDTH-1:0] fifo_mem[MAX_COUNT-1:0]; //共有64个8bits数据的存储器
	
	//写
	always @(posedge wr_clk or negedge wr_rstn)  //写控制端异步复位
	begin 
		if(!wr_rstn) wr_ptr <= 0;
		else if(wr_en && !wr_overflow) //写使能有效且FIFO未满时可写
		begin
			fifo_mem[wr_ptr] <= wr_data;
			wr_ptr <= wr_ptr + 1'b1;
		end
		else if(wr_en && wr_overflow) //当overflow时找出输入数据中的NULL进行丢弃，直到overflow消失
		begin
			if(wr_data == NULL)
			begin 
				wr_ptr <= wr_ptr;
			end
			else
			begin
				fifo_mem[wr_ptr] <= wr_data;
				wr_ptr <= wr_ptr + 1'b1;
			end
		end
		else wr_ptr <= wr_ptr;
	end
	 
	//读
	always @(posedge rd_clk or negedge rd_rstn)  //读控制端异步复位
	begin
		if(!rd_rstn) rd_ptr <= 0;
		else if(rd_en && !rd_underflow) //读使能有效且FIFO未空时可读
		begin
			rd_data <= fifo_mem[rd_ptr];
			rd_ptr  <= rd_ptr + 1'b1;
		end
		else if(rd_en && rd_underflow) //当underflow时停止读数据，直接送出NULL，直到underflow消失
		begin
			rd_data <= NULL;
			rd_ptr  <= rd_ptr;
		end
		else rd_ptr <= rd_ptr;
	end
	
	//数据个数计数
	always @(*) 
	begin
		if(!wr_rstn | !rd_rstn) count = 0;
		else 
			count = wr_ptr - rd_ptr;
	end
	
	//更新标志位overflow和underflow
	always @(*)
	begin
		wr_overflow  = count[(DEPTH-1)-:2] == 2'b11; //count高两位是11时，说明数据个数>=48（75%）
		rd_underflow = count[(DEPTH-1)-:2] == 2'b00; //count高两位是11时，说明数据个数<16（25%）
	end
	
endmodule