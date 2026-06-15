`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.05.2026 16:07:57
// Design Name: 
// Module Name: IN4
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

module IN4 (
    input             SF,
    input      [10:0] EF,
    input      [51:0] MF,
    input      [2:0]  sel,
    output     [63:0] Final_prod
);

    // Create local parameters for clarity
    localparam [63:0] POS_INF = 64'h7FF0_0000_0000_0000;
    localparam [63:0] NEG_INF = 64'hFFF0_0000_0000_0000;
    localparam [63:0] Q_NAN   = 64'h7FF8_0000_0000_0000;

    // Instantiate your mux blueprint inside IN4
    mux5to1 final_mux (
        .in0({SF, EF [10:0], MF}), 
        .in1(64'd0), 
        .in2(POS_INF),
        .in3(NEG_INF),
        .in4(Q_NAN),
        .sel(sel),
        .out(Final_prod) // Maps structural mux output out to port Final_prod
    );

endmodule