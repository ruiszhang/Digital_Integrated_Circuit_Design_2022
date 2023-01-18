//4位超前进位加法器
module CLA_4bits(
	//input 		
		cin,
		a,
		b,
	//output
		s,
		cout
	);
	
	parameter N = 4;
	
	input 		   cin;
	input [N-1:0]    a;
	input [N-1:0]    b;
	
	output 		 cout;
	output [N-1:0] 	s;
	
	wire [N-1:0]  p;
	wire [N-1:0]  g;
	wire [N:0] 	 co;
	
		assign g = a & b;
		assign p = a ^ b;

	
	begin assign co[0] = cin; end
	begin assign co[1] = ( co[0] && p[0] ) || g[0]; end
	begin assign co[2] = ( co[0] && p[0] && p[1]) || ( p[1] && g[0] ) || g[1]; end
	begin assign co[3] = ( co[0] && p[0] && p[1] && p[2]) || ( p[2] && p[1] && g[0] ) ||( p[2] && g[1] ) || g[2]; end
	begin assign co[4] = ( co[0] && p[0] && p[1] && p[2] && p[3]) || ( p[3] && p[2] && p[1] && g[0] ) ||( p[3] && p[2] && g[1] ) || ( p[3] && g[2] ) || g[3]; end
	begin assign cout = co[4]; end
	
	begin assign s[0] = co[0] ^ p[0]; end
	begin assign s[1] = co[1] ^ p[1]; end
	begin assign s[2] = co[2] ^ p[2]; end
	begin assign s[3] = co[3] ^ p[3]; end
	
endmodule
	
	
	
	
	
	