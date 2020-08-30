`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////////////////
// Author: Rajiv Bishwokarma
// Create Date: 06/25/2019 04:07:54 PM
// Design Name: Defuzzification
// Module Name: defuzzification.v
// Project Name: Frequency Regulation of Synchronous Generator using Fuzzy Logic Controller
// Target Devices: Xilinx Zybo Z7-10
// Tool Versions: Vivado 2018.3
// Revision:
// Revision 0.01 - File Created
// Revision 0.02 - Changed localparam into parameters
////////////////////////////////////////////////////////////////////////////////////////////


module tb_defuzzification;
    reg clk;
    reg [7:0] output_fuzzy_set_id;
    wire [7:0] pwm_duty;
    
    defuzzification UUT(
        .clk(clk),
        .output_fuzzy_set_id(output_fuzzy_set_id),
        .pwm_duty(pwm_duty)
    );
    
    initial begin
        clk = 0;
        forever begin
            clk = #5 ~clk;
        end
    end
    
    initial begin
        output_fuzzy_set_id = 8'b00000001;  #1000;    // 1
        output_fuzzy_set_id = 8'b00000010;  #1000;    // 2
        output_fuzzy_set_id = 8'b00000011;  #1000;    // 3
        output_fuzzy_set_id = 8'b00000100;  #1000;    // 4
        output_fuzzy_set_id = 8'b00000101;  #1000;    // 5
        output_fuzzy_set_id = 8'b00000110;  #1000;    // 6
        output_fuzzy_set_id = 8'b00000111;  #1000;    // 7
        output_fuzzy_set_id = 8'b00001000;  #1000;    // 8
        output_fuzzy_set_id = 8'b00001001;  #1000;    // 9
        output_fuzzy_set_id = 8'b00001010;  #1000;    // 10
        output_fuzzy_set_id = 8'b00001011;  #1000;    // 11
        
        $finish;
    end
    
endmodule
