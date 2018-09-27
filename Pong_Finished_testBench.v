`timescale 1ns / 1ps

//========================================================================
// 	File name: <pong_finished_testBench.v>															//				
//																								//	
// 	Created by Steven Phan on 2/14/18											//
//		Copyright 2018 Steven Phan. All rights reserved.						//
//																								//
//																								//
//		In submitting this file for class work at CSULB							//	
//		I am confirming that this is my work and the work						//	
// 	of no one else. In subinmitting this code I acknowledge that		//
//		plagiarism in student project work is subject to dismissal 			//
// 	from the class.																	//
//========================================================================

module Pong_Finished_testBench;

	// Inputs
	reg clk;
	reg reset;
	reg [1:0] button;

	// Outputs
	wire hsync;
	wire vsync;
	wire [11:0] RGB;
	
	// wires
	wire [9:0] pix_x, pix_y;
	wire	on_vid; 
	reg  [11:0] ps_rgb;
   wire [11:0]	ns_rgb;

// instantests the two modules to be examined	
	vga_sync uut1(.clk(clk), .reset(reset),
						.hsync(hsync), .vsync(vsync),
						.pixel_x(pix_x), .pixel_y(pix_y), 
						.video_on(on_vid) );

   pong_animated uut2 (.clk(clk),  .reset(reset), 
							  .sw(button),.video_on(on_vid), 
							  .pixl_x(pix_x), .pixl_y(pix_y),
							  .RGB(ns_rgb)
							  );					 

	always @(posedge clk, posedge reset)
		if (reset) ps_rgb <= 12'hFFF;
		else ps_rgb <= ns_rgb;

	 assign RGB = ps_rgb;
	 
////////////////////////////////////////

always #5 clk = ~clk; 
	initial begin
		// Initialize Inputs
		clk = 0;
		reset= 1; #100; 
		reset = 0; #100; 
		button[0] = 1;
		button[1] = 0; 

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

