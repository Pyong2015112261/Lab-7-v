`timescale 1ns / 1ps


module alu_tb;

	
	reg [31:0] a;
	reg [31:0] b;
	reg [1:0] ALUControl;

	
	wire [31:0] Result;
	wire [3:0] ALUFlags;

	
	alu uut (
		.a(a), 
		.b(b), 
		.ALUControl(ALUControl), 
		.Result(Result), 
		.ALUFlags(ALUFlags)
	);
	
	logic[31:0] expectedResult;
	logic[3:0] expectedFlags;
	
	logic[101:0] testvectors[100];
	logic[31:0] i, passed, failed;
	reg clk;
	
	always
	begin
		clk <= 1;
		#10;
		clk <= 0;
		#10;
	end
	
	
	initial begin
		$readmemb("alu.tv", testvectors); 
		i = 0;		
		passed = 0; 
		failed = 0; 
	end

	always @(posedge clk)
	begin
		#10
		{a,b,ALUControl,expectedResult,expectedFlags} = testvectors[i];
	end
	
	always @(negedge clk)
	begin
		if(ALUFlags !== expectedFlags)
		begin
			failed = failed + 1;
		end
		if(Result === expectedResult & ALUFlags === expectedFlags)
		begin
			passed = passed + 1;
		end
		
		i = i + 1;
	end
      
endmodule

