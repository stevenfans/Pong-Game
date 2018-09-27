`timescale 1ns / 1ps
//========================================================================
// 	File name: <vga_sync.v>															//				
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
module static_game(clock ,reset, hsync, vsync, rgb);
	
	input clock, reset;
	output hsync, vsync;
	output [11:0] rgb;
	
	// wires and registers
	wire [9:0] pix_x, pix_y;
	wire on_vid;
	reg [11:0] ps_rgb;
   wire [11:0]	ns_rgb;
	
	// instantiation of full game
	vga_sync SYNC (.clk(clock), .reset(reset),
						.hsync(hsync), .vsync(vsync),
						.pixel_x(pix_x), .pixel_y(pix_y),
						.video_on(on_vid));
						
	game_objects OBJECTS(.vid_on(on_vid), 
								.pixl_x(pix_x), .pixl_y(pix_y),
								.rgb(ns_rgb));
						  
	//rgb buffer registers
	always @(posedge clock, posedge reset)
		if (reset) ps_rgb <= 12'hFFF;
		else ps_rgb <= ns_rgb;

	 assign rgb = ps_rgb;
 
endmodule
