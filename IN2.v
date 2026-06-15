`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.05.2026 16:07:57
// Design Name: 
// Module Name: IN2
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


module IN2( input S1 , S2 , [11:0] E_temp , [105:0] product , output SF , [11:0] EF , [51:0] MF);
assign SF = S1 ^ S2;
assign EF = product [105] ? (E_temp + 12'd1) : E_temp; 
assign MF = product [105] ? product [104:53] : product [103:52];
endmodule
