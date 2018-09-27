`timescale 1ns / 1ps
//========================================================================
// 	File name: <pong_finished.v>															//				
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
module Pong_Finished(clk, reset_a, button, hsync, vsync, RGB);
	input 		  clk, reset_a; 
	input  [1:0]  button; 
	output 		  hsync, vsync; 
	output [11:0] RGB;
	
	// wires and registers
	wire [9:0] pix_x, pix_y;
	wire on_vid, reset_s;
	reg [11:0] ps_rgb;
   wire [11:0]	ns_rgb;
	
	AISO reset(.clk(clk), .reset(reset_a), .reset_s(reset_s));
	
	vga_sync syncrhonization(.clk(clk), .reset(reset_s),
									 .hsync(hsync), .vsync(vsync),
									 .pixel_x(pix_x), .pixel_y(pix_y), 
									 .video_on(on_vid)
									 );

   pong_animated animate_me (.clk(clk),  .reset(reset_s), 
									  .sw(button),.video_on(on_vid), 
									  .pixl_x(pix_x), .pixl_y(pix_y),
									  .RGB(ns_rgb)
									  );					 

	//rgb buffer registers
	always @(posedge clk, posedge reset_s)
		if (reset_s) ps_rgb <= 12'hFFF;
		else ps_rgb <= ns_rgb;

	 assign RGB = ps_rgb;
	 
endmodule
