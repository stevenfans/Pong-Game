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
module pong_animated(clk, reset, sw, video_on, pixl_x, pixl_y, RGB);

	input  clk, reset, video_on;
	input [1:0] sw; 
	input [9:0] pixl_x, pixl_y;
	output[11:0] RGB; 
	reg   [11:0] RGB;
	
	parameter velocityP = 10'd4;
	wire restart; 
	// 60 Hz 
	// one tick every time screenm finishes
	wire tick_60Hz; 
	
	assign tick_60Hz = (pixl_x == 0 ) && (pixl_y == 481);
	
//***********************************************************
	parameter top_boundary    = 1,
				 bottom_boundary = 480, 
				 right_boundary  = 640;
//**********PADDLE UPDATES AND TURN ON HUEHUE*****************
	
	parameter 	leftpaddle = 600,
					rightpaddle = 603;
	
	wire pad_on; 
	wire [11:0] pad_rgb;
	
	//register for the top of the paddle
	reg [9:0] paddle_top_reg, n_paddle_top_reg;
	wire [9:0] top_pad, bot_pad; 
	
	assign top_pad = paddle_top_reg; 
	assign bot_pad = top_pad + 10'd71;

	//turning on the paddle
	assign pad_on = (leftpaddle <= pixl_x) && (pixl_x <= rightpaddle) &&
						 (top_pad <= pixl_y)    && (pixl_y <= bot_pad);
	assign pad_rgb = 12'h0F0; //GREEN
	
	// upadating the y-axis of the paddle
	always @ (*)
	begin
		n_paddle_top_reg = paddle_top_reg;// paddles doesnt move
		
		if(tick_60Hz)
			if (sw[1] & (bot_pad < 480))//(480 - 1 - velocityP))) // down 
				n_paddle_top_reg = paddle_top_reg + velocityP;
			else if (sw[0] & (top_pad > 1 ))//velocityP))			// up
				n_paddle_top_reg = paddle_top_reg - velocityP;
	end
//**************************************************************
//************BALL UPDATES AND TURNS ON BALL *******************

	//paramerter for the ball
	parameter 	ball_size =  10'd8,
					pos_speed =  1,
					neg_speed = -1; 
	
	wire 			ball_on;
	wire [11:0] ball_rgb;
	
	// registers for the boundries
	wire [9:0] top_ball, bot_ball;
	wire [9:0] left_ball, right_ball;
	
	// registers to track
	reg  [9:0]  ball_x_reg, ball_y_reg;
	wire [9:0]  n_ball_x_reg, n_ball_y_reg;
	// registers for speed change
	reg [9:0] delta_x,  delta_y; 
	reg [9:0] n_delta_x, n_delta_y; 
	
	// SET THE BOUNDRIES
	assign top_ball = ball_y_reg; 
	assign bot_ball = top_ball + ball_size - 10'd1;
	assign left_ball = ball_x_reg;
	assign right_ball = left_ball + ball_size - 10'd1; 
	
	// turn the ball on 
	assign ball_on = (top_ball <= pixl_y)  && (pixl_y <= bot_ball) &&
						  (left_ball <= pixl_x) && (pixl_x <= right_ball); 
	assign ball_rgb = 12'hF00; // BLUE	
	
	// assign the new positions to the registers
	assign n_ball_x_reg = (tick_60Hz) ? (ball_x_reg + delta_x) : ball_x_reg; 
	assign n_ball_y_reg = (tick_60Hz) ? (ball_y_reg + delta_y) : ball_y_reg; 
	
	// changing the velocity
	always @ (*)  
		begin
			n_delta_x = delta_x; // no chance
			n_delta_y = delta_y; 
			
			if (top_ball <= 1 ) //when the ball hits the top
				n_delta_y = pos_speed; // positive y
				
			else if (bot_ball >= 479) // when the ball hits the bottom
				n_delta_y = neg_speed; //negative y
				
			else if (left_ball <= 35) // ball hitting the left wall
				n_delta_x = pos_speed;
				
			else if ((600 <= right_ball)  && (right_ball <= 603) &&
						(top_pad <= bot_ball) && (top_ball <= bot_pad))
				n_delta_x = neg_speed; 					
		end
	
	assign restart = (right_ball==639) ? 1'd1 : 1'd0; 
//***************************************************************************
	// paramerter for the wall
	parameter 	leftwall = 32,
					rightwall = 35; 
	 
	wire wall_on;
	wire [11:0] wall_rgb;
	
		//turning on the wall 
	assign wall_on = (leftwall <= pixl_x) && (pixl_x <= rightwall);
	assign wall_rgb = 12'h00F; //RED
	
// FLIPITPY FLOP FLOP
	always @ ( posedge clk, posedge reset)
		if(reset)
			begin
				paddle_top_reg <= 220;
				ball_x_reg 		<= 36;
				ball_y_reg 		<= 0;
				delta_x 			<= 1;
				delta_y 			<= 1;			
			end 	
	else if (restart)
		 begin
				paddle_top_reg <= n_paddle_top_reg;
				ball_x_reg 		<= 36;
				ball_y_reg 		<= 0;
				delta_x 			<= 1;
				delta_y 			<= 1;			
			end
			
		else 
			begin
				paddle_top_reg <= n_paddle_top_reg;
				ball_x_reg 		<= n_ball_x_reg;
				ball_y_reg 		<= n_ball_y_reg;
				delta_x 		   <= n_delta_x;
				delta_y    		<= n_delta_y; 
			end 
			


//****************************************************************************
//**********************MULTIPLEXER CIRCUIT***********************************
//****************************************************************************
	always @(*)
	if (~video_on)
		RGB = 12'h000; //blank wall
	else 
		if (wall_on)
			RGB = wall_rgb; 
		else if (pad_on)
			RGB = pad_rgb;
		else if (ball_on)
			RGB = ball_rgb; 
		else 
			RGB = 12'h000; 
	
endmodule
