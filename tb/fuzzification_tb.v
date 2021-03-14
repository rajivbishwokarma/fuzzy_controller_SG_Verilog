`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Rajiv Bishwokarma
// Create Date: 06/12/2019 07:19:24 PM
// Design Name: Fuzzification Testbench
// Module Name: Fuzzification_tb.v
// Project Name: Frequency Regulation of Synchronous Generator using Fuzzy Logic Controller
// Target Devices: Xilinx Zybo Z7-10
// Tool Versions: Vivado 2018.3
// Revision:
// Revision 0.01 - File Created
// Revision 0.02 - Changed localparam into parameters
////////////////////////////////////////////////////////////////////////////////////////////


module tb_fuzzification;
    reg clk;
    reg [7:0] freq_crisp; 
    wire [7:0] ptr_freq_fuzzy; 
    wire [7:0] ptr_input_fuzzy_set_id; 
    wire [7:0] ptr_negGigantic; 
    wire [7:0] ptr_negHuge; 
    wire [7:0] ptr_negBig; 
    wire [7:0] ptr_negMedium; 
    wire [7:0] ptr_negSmall; 
	wire [7:0] ptr_zero; 
	wire [7:0] ptr_posSmall; 
	wire [7:0] ptr_posMedium; 
	wire [7:0] ptr_posBig; 
	wire [7:0] ptr_posHuge; 
	wire [7:0] ptr_posGigantic;
	
	fuzzification UUT(
	   .clk(clk),
       .freq_crisp(freq_crisp),
	   .ptr_freq_fuzzy(ptr_freq_fuzzy),
	   .ptr_input_fuzzy_set_id(ptr_input_fuzzy_set_id),
	   .ptr_negGigantic(ptr_negGigantic),
	   .ptr_negHuge(ptr_negHuge),
	   .ptr_negBig(ptr_negBig),
	   .ptr_negMedium(ptr_negMedium),
	   .ptr_negSmall(ptr_negSmall),
	   .ptr_zero(ptr_zero),
	   .ptr_posSmall(ptr_posSmall),
	   .ptr_posMedium(ptr_posMedium),
	   .ptr_posBig(ptr_posBig),
	   .ptr_posHuge(ptr_posHuge),
	   .ptr_posGigantic(ptr_posGigantic)
	);
	
	initial begin
	   clk = 0;
	   forever begin
	       clk = #5 ~clk;
	   end
    end
    
    initial begin
    freq_crisp =  8'b00000000;      #1000; // 0
    freq_crisp =  8'b00000001;      #1000; // 1
    freq_crisp =  8'b00000010;      #1000; // 2
    freq_crisp =  8'b00000011;      #1000; // 3
    freq_crisp =  8'b00000100;      #1000; // 4
    freq_crisp =  8'b00000101;      #1000; // 5
    freq_crisp =  8'b00000110;      #1000; // 6
    freq_crisp =  8'b00000111;      #1000; // 7
    freq_crisp =  8'b00001000;      #1000; // 8
    freq_crisp =  8'b00001001;      #1000; // 1
    freq_crisp  = 8'b00001010;      #1000; // 10
    freq_crisp  = 8'b00001011;      #1000; // 11
    freq_crisp  = 8'b00001100;      #1000; // 12
    freq_crisp  = 8'b00001101;      #1000; // 13
    freq_crisp  = 8'b00001110;      #1000; // 14
    freq_crisp  = 8'b00001111;      #1000; // 15
    freq_crisp  = 8'b00010000;      #1000; // 16
    freq_crisp  = 8'b00010001;      #1000; // 17
    freq_crisp  = 8'b00010010;      #1000; // 18
    freq_crisp  = 8'b00010011;      #1000; // 19
    freq_crisp  = 8'b00010100;      #1000; // 20
    
    
//    freq_crisp  = 8'b00011110;      #1000; // 30
//    freq_crisp  = 8'b00101000;      #1000; // 40
//    freq_crisp  = 8'b00101001;      #1000; // 41
//    freq_crisp  = 8'b00101101;      #1000; // 45
//    freq_crisp  = 8'b00110000;      #1000; // 48
//    freq_crisp  = 8'b00110010;      #1000; // 50
//    freq_crisp  = 8'b00111100;      #1000; // 60  
    $finish;    
    end /* initial end */
	 
endmodule
