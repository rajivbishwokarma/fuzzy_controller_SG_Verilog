`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////////////////
// Author: Rajiv Bishwokarma
// Create Date: 06/08/2019 1:02:03 AM
// Design Name: Rule Base
// Module Name: rulebase.v
// Project Name: Frequency Regulation of Synchronous Generator using Fuzzy Logic Controller
// Target Devices: Xilinx Zybo Z7-10
// Tool Versions: Vivado 2018.3
// Revision:
// Revision 0.01 - File Created
////////////////////////////////////////////////////////////////////////////////////////////

module rulebase(
    input        clk,
    input  [7:0] input_fuzzy_set_id, 
    output [7:0] output_fuzzy_set_id
    );
    
    /* Local parameters to represent the numbers for readability */
    localparam zero_ebit =     8'b00000000;
    localparam one_ebit =      8'b00000001;
    localparam two_ebit =      8'b00000010;
    localparam three_ebit =    8'b00000011;
    localparam four_ebit =     8'b00000100;
    localparam five_ebit =     8'b00000101;
    localparam six_ebit =      8'b00000110;
    localparam seven_ebit =    8'b00000111;
    localparam eight_ebit =    8'b00001000;
    localparam nine_ebit =     8'b00001001;
    localparam ten_ebit =      8'b00001010;
    localparam eleven_ebit =   8'b00001011;
    
    /* Internal registers to handle the input and ouput fuzzy sets ids */
    reg [7:0] int_input_id;
    reg [7:0] int_output_id;
    
    always@ (posedge clk) begin
        int_input_id = input_fuzzy_set_id;
        
        if (int_input_id == one_ebit) begin
        
            int_output_id = eleven_ebit;
        
        end else if (int_input_id == two_ebit) begin
        
            int_output_id = ten_ebit;
        
        end else if (int_input_id == three_ebit) begin
        
            int_output_id = nine_ebit;
        
        end else if (int_input_id == four_ebit) begin
        
            int_output_id = eight_ebit;
        
        end else if (int_input_id == five_ebit) begin
        
            int_output_id = seven_ebit;
        
        end else if (int_input_id == six_ebit) begin
        
            int_output_id = six_ebit;
        
        end else if (int_input_id == seven_ebit) begin
        
            int_output_id = five_ebit;
        
        end else if (int_input_id == eight_ebit) begin
        
            int_output_id = four_ebit;
        
        end else if (int_input_id == nine_ebit) begin
        
            int_output_id = three_ebit;
        
        end else if (int_input_id == ten_ebit) begin
        
            int_output_id = two_ebit;
        
        end else if (int_input_id == eleven_ebit) begin
        
            int_output_id = one_ebit;
            
        end else begin
        
            int_output_id = zero_ebit;
        
        end
    end /* always end */
    
    /* Assigning the value of the internal register to the output */
    assign output_fuzzy_set_id = int_output_id;
    
endmodule

