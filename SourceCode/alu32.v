module alu32(alu_out, a, b , zout,sout,oout,alu_control);
output reg [31:0] alu_out;
input [31:0] a,b;
input [3:0] alu_control;

reg [31:0] less;
output zout,sout,oout;
reg zout,sout,oout;  

always @(a or b or alu_control)
begin
	/*
	there are 5 type of instructions which are 
	2) sum = a + b
	6) sum = a - b
	7) 
	*/
	case(alu_control)
	4'b0010: alu_out = a+b; 
	4'b0110: alu_out = a+1+(~b);
	4'b0111: begin less = a+1+(~b);
			if (less[31]) alu_out=1;
			else alu_out=0;
		end
	/*
	0) a AND b
	1) a OR b
	*/
	4'b0000: alu_out = a & b;
	4'b0001: alu_out = a | b;
	4'b0011: alu_out = a ^ b; //bitwise XOR
	4'b1100: alu_out = ~(a|b); //NOR
	
	default: alu_out=31'bx;
	endcase

zout =~(|alu_out);


if(alu_out[31] == 1'b1)  // if the last bit is 1, then it is negative and i set sout to 1.  I will use this sout in processor to update cpsr
	assign sout = 1'b1;
if(((a  & b ) & ~alu_out) | ((~a & ~b ) & alu_out))	// if a and b are positive and result is negative
      	assign oout = 1'b1;				// or a and b are negative and result is posive, i set oout to 1
							// I will use this oout in processor to update cpsr




end
endmodule
