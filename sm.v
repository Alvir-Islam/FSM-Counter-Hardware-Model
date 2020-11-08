`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2020 08:31:55 PM
// Design Name: 
// Module Name: sm
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


module sm(ovflw,cnt,clk,act, h_l,rst);
input clk,act,h_l,rst;
output cnt, ovflw;
reg [3:0] cnt;
reg ovflw;
reg [1:0] state, nxt_st;
 localparam Sleep= 2'b00;
 localparam Cntup= 2'b01;
 localparam Cntdn= 2'b10;
 localparam Ovf= 2'b11;

always @ *
  case(state)
     Sleep:begin
        if(act)
           if (h_l)
             nxt_st=Cntup;
           else
             nxt_st=Cntdn;
         else 
            nxt_st=Sleep;
      end
      Cntup:begin
          if(act)
            if(h_l)
               if (cnt==4'b1110)
                    nxt_st=Ovf;
               else 
                   nxt_st=Cntup;
             else  
                 if(cnt==4'b0001) 
                    nxt_st=Ovf;
                 else   
                    nxt_st=Cntdn;
           else 
                nxt_st=Sleep;
       end
       Cntdn:begin
                if(act)
                  if(~h_l)
                     if (cnt==4'b0001)
                        nxt_st=Ovf;
                     else 
                         nxt_st=Cntdn;
                   else  
                        if(cnt==4'b1110) 
                            nxt_st=Ovf;
                        else   
                            nxt_st=Cntup;
                 else 
                      nxt_st=Sleep;
        end
        Ovf:begin
            
           nxt_st=Ovf;
                      
        end  
        default:begin 
            nxt_st='bx;
        end
    endcase
always@ (posedge clk or negedge rst)
        if(~rst)
            state<=Sleep;
         else
            state<=nxt_st;
   
 always@ (posedge clk or negedge rst)
        if (rst)
           if(state==Cntup)
               cnt=cnt+1'b1;
           else if (state==Cntdn)
               cnt=cnt-1'b1;
           else if (state==Ovf)
               cnt<=cnt;    
        else
            cnt='b0;
 
 always@ (posedge clk)
     if (state==Ovf)
         ovflw=1'b1;
     else
         ovflw=1'b0;
endmodule
