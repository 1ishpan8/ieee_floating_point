`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.05.2026 23:06:36
// Design Name: 
// Module Name: top_module
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


module top_module(
       input [63:0] a, 
       input [63:0] b,
       output [63:0] result);
       
    wire [11:0]  E_temp;
    wire [105:0] M_product;
    wire         SF;
    wire [11:0]  EF_temp;
    wire [51:0]  MF;
    wire [2:0]   sel;
    
    wire [52:0] mantissa_a = (a[62:52] == 11'd0) ? 53'd0 : {1'b1, a[51:0]};
    wire [52:0] mantissa_b = (b[62:52] == 11'd0) ? 53'd0 : {1'b1, b[51:0]};

    IN0 u_IN0 (
        .E1(a[62:52]),
        .E2(b[62:52]),
        .E_temp(E_temp)
    );

    IN1 u_IN1 (
        .a(mantissa_a),
        .b(mantissa_b),
        .product(M_product)
    );

    IN2 u_IN2 (
        .S1(a[63]),
        .S2(b[63]),
        .E_temp(E_temp),
        .product(M_product),
        .SF(SF),
        .EF(EF_temp),
        .MF(MF)
    );

    IN3 u_IN3 (
        .a(a),
        .b(b),
        .E_final_temp(EF_temp),
        .sel(sel)
    );

    IN4 u_IN4 (
        .SF(SF),
        .EF(EF_temp),
        .MF(MF),
        .sel(sel),
        .Final_prod(result)
    );

endmodule
       