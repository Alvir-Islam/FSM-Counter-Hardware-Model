`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2020 01:01:58 PM
// Design Name: 
// Module Name: sm_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sm_tb;
reg clk;
reg rst;
reg act;
reg h_l;
wire ovflw;
wire [3:0] cnt;
sm M(.clk(clk), .rst(rst), .act(act), .h_l(h_l), .ovflw(ovflw), .cnt(cnt));
initial begin
 clk=1'b0;
 rst=1'b0;
 act=1'b0;
 h_l=1'b0;
end
always 
 #1 clk=~clk;     
initial begin

#1    act=1'b1;
      h_l=1'b1;
      rst=1'b1;   
#50   rst=1'b0;    
#10   rst=1'b1;
#5    h_l=1'b0;            
end
endmodule
