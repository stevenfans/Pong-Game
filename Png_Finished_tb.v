`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:35:27 04/30/2018
// Design Name:   Pong_Finished
// Module Name:   D:/CECS 360 labs/lab_4/Png_Finished_tb.v
// Project Name:  lab_4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Pong_Finished
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Png_Finished_tb;

	// Inputs
	reg clk;
	reg reset;
	reg [1:0] button;

	// Outputs
	wire hsync;
	wire vsync;
	wire [11:0] RGB;

	// Instantiate the Unit Under Test (UUT)
	Pong_Finished uut (
		.clk(clk), 
		.reset(reset), 
		.button(button), 
		.hsync(hsync), 
		.vsync(vsync), 
		.RGB(RGB)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		button = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

