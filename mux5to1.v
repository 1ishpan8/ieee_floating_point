`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.05.2026 16:59:36
// Design Name: 
// Module Name: mux5to1
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


module mux5to1(
      input [63:0] in0,
      input [63:0] in1,
      input [63:0] in2,
      input [63:0] in3,
      input [63:0] in4,
      input [2:0] sel,
      output reg [63:0] out

    );
    
    always @ (*) 
               begin 
                    case (sel) 
                             3'd0: out = in0;
                             3'd1: out = in1;
                             3'd2: out = in2;
                             3'd3: out = in3;
                             3'd4: out = in4;
                             default: out = 64'b0;
                     endcase 
                     end 
    
endmodule
