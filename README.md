# Digital_Integrated_Circuit_Design_2022
数字集成电路设计课程作业，2022，北京大学

**仅限于交流分享，禁止抄袭！！！（代码存在错误和不足之处，请注意鉴别，欢迎友好批评指正）**


————————————————————————————————————————————————————————————
## homework1
显示d_trireg的信号强度



## homework2
4位超前进位加法器（CLA）

32位加法器（4位一组，组内超前进位，组间行波进位）

32位ALU



## homework3
序列检测电路（111，可重叠检测）

序列检测电路（01110，不重叠检测）



## homework4
参数化译码器

参数化优先编码器

格雷码计数器

**参数化优先编码器使用了break语句，属于systemverilog的语法**



## homework5
异步FIFO（未进行时钟同步，而是利用NULL：若发现overflow，则找出data_i序列中的null数据（0x00），若发现null则丢弃，不写入FIFO，
          直到overflow消失；若发现underflow，则停止读操作，向data_o送出null数据，直到underflow消失。）
          
异步接口SRAM建模（利用notifier进行时序检查，理解为对测试代码的约束）



## homework6（大作业）
MCDF


