`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////////////////
// Author: Rajiv Bishwokarma
// Create Date: 06/08/2019 01:14:36 PM
// Design Name: Rule Base Testbench
// Module Name: tb_rulebase.v
// Project Name: Frequency Regulation of Synchronous Generator using Fuzzy Logic Controller
// Target Devices: Xilinx Zybo Z7-10
// Tool Versions: Vivado 2018.3
// Revision:
// Revision 0.01 - File Created
////////////////////////////////////////////////////////////////////////////////////////////

module tb_rulebase;
    reg     clk;
    reg     [7:0] input_fuzzy_set_id;
    wire    [7:0] output_fuzzy_set_id;

    rulebase UUT(
        .clk(clk),
        .input_fuzzy_set_id(input_fuzzy_set_id),
        .output_fuzzy_set_id(output_fuzzy_set_id)
    );
    
    initial begin
        clk = 0;
        forever begin
            clk = #5 ~clk;
        end /* forever end */
    end /* initial end */
    
    initial begin
        
        //0
        input_fuzzy_set_id = 8'b00000000;
        #1000;
        //1
        input_fuzzy_set_id = 8'b00000001;
        #1000;
        //2
        input_fuzzy_set_id = 8'b00000010;
        #1000;
        //3
        input_fuzzy_set_id = 8'b00000011;
        #1000;
        //4
        input_fuzzy_set_id = 8'b00000100;
        #1000;
        //5
        input_fuzzy_set_id = 8'b00000101;
        #1000;
        //6
        input_fuzzy_set_id = 8'b00000110;
        #1000;
        //7
        input_fuzzy_set_id = 8'b00000111;
        #1000;
        //8
        input_fuzzy_set_id = 8'b00001000;
        #1000;
        //9
        input_fuzzy_set_id = 8'b00001001;
        #1000;
        //10
        input_fuzzy_set_id = 8'b00001010;
        #1000;
        //11
        input_fuzzy_set_id = 8'b00001011;
        #1000;
        
        $finish;
    end /* initial end */
    

endmodule
