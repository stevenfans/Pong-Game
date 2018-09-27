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

module static_game_tb;

	// Inputs
	reg clock;
	reg reset;

	// Outputs
	wire hsync;
	wire vsync;
	wire [11:0] rgb;
	
	integer i, j, k;

	// Instantiate the Unit Under Test (UUT)
	static_game uut (
		.clock(clock), 
		.reset(reset), 
		.hsync(hsync), 
		.vsync(vsync), 
		.rgb(rgb)
	);	

	always #5 clock = ~clock;
	
	
//********************CODE FOR THE WALL**************************************		

always @(posedge clock) begin
if (32 <= uut.pix_x && uut.pix_x < 35 && uut.ns_rgb == 12'h00F)begin
		#100;$display ( "The Wall display is on @%t and when pixel_x is @%d"
		  ,$time, uut.pix_x); end
if (32 < uut.pix_x && uut.pix_x < 35 && uut.ns_rgb == 12'h000) begin
		#5; $display ( "ERROR: blank wall when pix_x is %d @%t", 
							 uut.pix_x, $time); end				
		  end
			  
//********************CODE FOR THE PADDLE*********************************		
always @(posedge clock) begin		  
if ( 600 <= uut.pix_x && uut.pix_x <  603 &&
	  204 <= uut.pix_y && uut.pix_y <= 276 && uut.ns_rgb == 12'h0F0) begin
	  #1; $display ("Paddle display is on @%t when pixel_x is %d & pixel_y is %d",
			$time, uut.pix_x, uut.pix_y); end
if ( 600 <= uut.pix_x && uut.pix_x <= 603 &&
	  204 <= uut.pix_y && uut.pix_y <= 276 && uut.ns_rgb == 12'h000) begin
	  #1; $display ("ERROR: paddle is blank when pixel x is %d & pixel y is %d", 
						uut.pix_x, uut.pix_y); end
			end

//********************CODE FOR THE BALL********************************************
always @ (posedge clock) begin
if ( 580 <= uut.pix_x && uut.pix_x <  588 &&
	  238 <= uut.pix_y && uut.pix_y <= 246 && uut.ns_rgb == 12'hF00)begin
	  #1; $display ("Ball display is on @%t when pixel_y is %d & pixel x is %d ",
			$time, uut.pix_y, uut.pix_x); end
if ( 580 <= uut.pix_x && uut.pix_x <  588 &&
	  238 <= uut.pix_y && uut.pix_y <= 246 && uut.ns_rgb == 12'h000)begin
	  #1; $display ("ERROR: Ballis blank when pixel_y is %d and pixel x is %d ",
						  uut.pix_y, uut.pix_x); end	
		end
//*********************************************************************************	
	
	initial begin
	
		//initialize the time format
		$timeformat(-9, 2, "ns", 10);
		
		// Initialize Inputs
		clock = 0;
		reset = 1; #10;
		reset = 0; #10;	
		
	 @(posedge clock) begin
		if (32 <= uut.pix_x && uut.pix_x < 35 && uut.ns_rgb == 12'h00F)begin
		#100;$display ( "The Wall is RED"); end
		end
	
	end
endmodule 

