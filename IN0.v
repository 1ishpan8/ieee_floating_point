`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.05.2026 16:07:57
// Design Name: 
// Module Name: IN0
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

module IN0 (
    input [10:0] E1, // 11-bit input from Packet A (bits 62:52)
    input [10:0] E2, // 11-bit input from Packet B (bits 62:52)
    output [11:0] E_temp // 12-bit output to handle the intermediate overflow
);

    // Zero-extend the 11-bit inputs to 12-bit wires before doing math
    wire [11:0] E1_ext = {1'b0, E1};
    wire [11:0] E2_ext = {1'b0, E2};

    // Now execute the math safely in 12-bit space
    assign E_temp = $signed(E1_ext) + $signed(E2_ext) - 12'd1023;

endmodule