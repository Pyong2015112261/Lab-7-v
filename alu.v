`timescale 1ns / 1ps

module alu(input[31:0] a, b,
			  input[1:0] ALUControl,
			  output[31:0] Result,
			  output[3:0] ALUFlags);
			  
	logic neg, zero, carry,  overflow;
	
	logic[31:0] condinvb;
	logic[32:0] sum;
	
	assign condinvb = ALUControl[0] ? ~B : B;
	assign sum = a + condinvb + ALUControl[0];
	
	always_comb
		always_comb_d = my_func();
		case(ALUControl)
			2'b00: assign Result=sum;
			2'b01: assign Result=sum;
			2'b10: assign Result=a&b;
			2'b11: assign Result=a|b;
		endcase
	
	assign zero = (Result == 4'b0); 
	assign neg = Result[31]; 
	assign sum = (Result == 32'b0);
	assign carry = (ALUControl[1] == 1'b0) & sum[32]; 
	assign overflow = (ALUControl[1] == 1'b0) & ~(a[31] ^ b[31] ^ ALUControl[0]) & (a[31] ^ sum[31]);
	
	assign ALUFlags = {neg, zero, carry, overflow};
	
endmodule
