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
module game_objects( vid_on, pixl_x, pixl_y,
						  rgb);
						  
		input vid_on;
		input [9:0] pixl_x, pixl_y;
		
		output reg [11:0] rgb;
	
//****** CODE FOR THE WALL ***********
	
	// paramerter for the wall
	parameter 	leftwall = 32,
					rightwall = 35; 
	
	wire wall_on;
	wire [11:0] wall_rgb;
	
	
//****** CODE FOR THE PADDLE **********
	parameter 	leftpaddle = 600,
					rightpaddle = 603,
					top_pad = 204,
					bot_pad = 276;
	
	wire 			pad_on;
	wire[11:0] 	pad_rgb;	 
	
	
//****** CODE FOR THE BALL **********

	//paramerter for the ball
	parameter 	left_ball = 580,
					right_ball = 588,
					top_ball = 238,
					bot_ball = 246;
	
	wire 			ball_on;
	wire [11:0] ball_rgb;
	
/////////////////////////////////////////////////////////

	//turning on the wall 
	assign wall_on = (leftwall <= pixl_x) && (pixl_x <= rightwall);
	assign wall_rgb = 12'h00F; //RED
	
	//turning on the paddle
	assign pad_on = (leftpaddle <= pixl_x) && (pixl_x <= rightpaddle) &&
						 (top_pad <= pixl_y) && (pixl_y <= bot_pad);
	assign pad_rgb = 12'h0F0; //GREEN
	
	// turning on the ball
	assign ball_on = (left_ball <= pixl_x) && (pixl_x <= right_ball) &&
						  (top_ball <= pixl_y) && (pixl_y <= bot_ball);
	assign ball_rgb = 12'hF00; // BLUE
	
	// rgb multiplexer circuit
	always @(*)
		if (~vid_on) rgb = 12'hFFF; //black
		else if (wall_on) rgb = wall_rgb;
		else if (pad_on) rgb = pad_rgb;
		else if (ball_on) rgb = ball_rgb;
		else rgb = 12'h000 ;

endmodule
