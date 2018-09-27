`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:40:36 05/02/2018
// Design Name:   pong_animated
// Module Name:   D:/CECS 360 labs/lab_4/pong_animated_testBench.v
// Project Name:  lab_4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pong_animated
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pong_animated_testBench;

	// Inputs
	reg clk;
	reg reset;
	reg [1:0] sw;
	reg video_on;
	reg [9:0] pixl_x;
	reg [9:0] pixl_y;

	// Outputs
	wire [11:0] RGB;

	// Instantiate the Unit Under Test (UUT)
	pong_animated uut (
		.clk(clk), 
		.reset(reset), 
		.sw(sw), 
		.video_on(video_on), 
		.pixl_x(pixl_x), 
		.pixl_y(pixl_y), 
		.RGB(RGB)
	);

always #5 clk = ~clk; 

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1; #100; 
		reset = 0; #100; 
		sw = 0;
		video_on = 0;
		pixl_x = 0;
		pixl_y = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

