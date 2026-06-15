`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.05.2026 16:07:57
// Design Name: 
// Module Name: IN3
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


module IN3 (
    input [63:0] a,             // Raw 64-bit Input A
    input [63:0] b,             // Raw 64-bit Input B
    input [11:0] E_final_temp,  // 12-bit exponent after IN2 normalization mux
    output reg [2:0] sel        // 3-bit selection lines sent directly to IN4
);

    // Unpack fields for internal decoding
    wire S1 = a[63];
    wire [10:0] e1 = a[62:52];
    wire [51:0] m1 = a[51:0];

    wire S2 = b[63];
    wire [10:0] e2 = b[62:52];
    wire [51:0] m2 = b[51:0];

    // Combinatorial classification flags
    wire a_is_zero = (e1 == 11'd0) && (m1 == 52'd0);
    wire b_is_zero = (e2 == 11'd0) && (m2 == 52'd0);
    
    wire a_is_inf  = (e1 == 11'h7FF) && (m1 == 52'd0); // a is infinity 
    wire b_is_inf  = (e2 == 11'h7FF) && (m2 == 52'd0); // b is infinity 
    
    wire a_is_nan  = (e1 == 11'h7FF) && (m1 != 52'd0); // a is not a number
    wire b_is_nan  = (e2 == 11'h7FF) && (m2 != 52'd0); // b is not a number

    // Calculate final sign early to distinguish between +Inf and -Inf
    wire final_sign = S1 ^ S2;

    always @(*) begin
        // 1. Highest Priority: If either input is NaN, output is Quiet NaN
        if (a_is_nan || b_is_nan) begin
            sel = 3'd4; // Select NaN channel
        end
        
        // 2. Second Priority: Invalid operation (0 multiplied by Infinity)
        else if ((a_is_zero && b_is_inf) || (b_is_zero && a_is_inf)) begin
            sel = 3'd4; // 0 * Inf is mathematically undefined, returns NaN
        end
        
        // 3. Third Priority: Pure Infinity Propagation
        else if (a_is_inf || b_is_inf) begin
            if (final_sign == 1'b0)
                sel = 3'd2; // Select +Infinity channel
            else
                sel = 3'd3; // Select -Infinity channel
        end
        
        // 4. Fourth Priority: Underflow or Normal Multiplications resulting in 0
        else if (a_is_zero || b_is_zero || ($signed(E_final_temp) <= 12'sd0)) begin
            sel = 3'd1; // Select 64'd0 channel
        end
        
        // 5. Fifth Priority: Hardware Calculation Overflow 
        else if (E_final_temp >= 12'd2047) begin
            if (final_sign == 1'b0)
                sel = 3'd2; // Overflows to +Infinity
            else
                sel = 3'd3; // Overflows to -Infinity
            end
        // 6. Default Fallback: Everything is within limits, use the normal product path
        else 
        begin
            sel = 3'd0; // Select valid calculated {SF, EF, MF} packet
        end
        end

endmodule
