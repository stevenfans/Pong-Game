`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:55:49 04/16/2018
// Design Name:   vga_sync
// Module Name:   D:/CECS 360 labs/Lab_3/vga_sync_tb.v
// Project Name:  Lab_3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vga_sync
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module vga_sync_tb;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire hsync;
	wire vsync;
	wire [9:0] pixel_x;
	wire [9:0] pixel_y;
	wire video_on;

	// Instantiate the Unit Under Test (UUT)
	vga_sync uut (
		.clk(clk), 
		.reset(reset), 
		.hsync(hsync), 
		.vsync(vsync), 
		.pixel_x(pixel_x), 
		.pixel_y(pixel_y), 
		.video_on(video_on)
	);

//****number 1
	always @ ( posedge clk) begin 
		if (reset == 1 && hsync ==1 && vsync ==1 && 
			 pixel_x == 12'b0 && pixel_y == 12'b0 && video_on ==1 )begin
			#1; $display( "reset sets all the counts to 0 and syncs to 1");
			end
		end
//****number 4	
	always @ (posedge clk) begin
		if(0 <= pixel_x && pixel_x <= 799) begin 
			#1; $display ("Horizontal count is %d", pixel_x);
			end
		end
//****number 5
	always @ (posedge clk) begin
		if(hsync == 0 && 656 <= pixel_x && pixel_x <= 751 ) begin 
			#1; $display ("Hsync is low active when pixel x is %d", pixel_x);
			end
		end
//****number 6
	always @ (posedge clk) begin
		if(uut.h_scan_on == 1 && 0 <= pixel_x && pixel_x <= 639 ) begin 
			#1; $display ("Horizontal is HA is when pixel x is %d",  pixel_x);
			end
		end
//****number 7
//****number 8
	always @ (posedge clk) begin
		if(0 <= pixel_y && pixel_y <= 524) begin 
			#1; $display ("Vertical count is %d", pixel_y);
			end
		end
//****number 9
	always @ (posedge clk) begin
		if(vsync == 0 && 490 <= pixel_y && pixel_y <= 491 ) begin 
			#1; $display ("Vsync is low active when pixel x is %d", pixel_y);
			end
		end
//****number 10
	always @ (posedge clk) begin
		if(uut.v_scan_on == 1 && 0 <= pixel_y && pixel_x <= 479 ) begin 
			#1; $display ("Vertical on is HA when pixel y is %d", pixel_y);
			end
		end
//****number 11
	always @ (posedge clk) begin
		if(video_on == 1 && uut.h_scan_on == 1 && uut.v_scan_on == 1) begin 
			#1; $display ("Hsync is low active when pixel x is %d", pixel_x);
			end
		end
		
//****number 12



always #5 clk = ~clk;

	initial begin
		clk = 0;
		
		// Initialize Inputs

		reset = 1; #10; 
		reset = 0; #10;
		//RGBs

	end
endmodule

