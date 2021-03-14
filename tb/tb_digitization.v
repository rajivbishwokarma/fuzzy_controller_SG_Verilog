`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 06/02/2019 04:19:28 PM
//////////////////////////////////////////////////////////////////////////////////

module tb_digitization;
    reg clk;
    reg [7:0] input_bit;
    wire [7:0] freq;
    
    digitization UUT(
        .clk (clk), 
        .input_bit (input_bit),
        .freq (freq)
        );
    
    initial begin
        $display("******************************************************");
        $display("BEGIN TESTBENCH");
        $display("******************************************************");
    end
    
    initial begin
        clk = 0;
        forever begin
            clk = #5 ~clk;
        end
    end
    
    initial begin
        // 0
        input_bit[7:4] = 4'b0000;
        input_bit[3:0] = 4'b0000;
        
        #1000;
        // 25
        input_bit[7:4] = 4'b0010;
        input_bit[3:0] = 4'b0101;
                
        #1000;
        //37        
        input_bit[7:4] = 4'b0011;
        input_bit[3:0] = 4'b0111;
        
        #1000;
        // 50
        input_bit[7:4] = 4'b0101;
        input_bit[3:0] = 4'b0000;
        
        #1000;
        // 55
        input_bit[7:4] = 4'b0101;
        input_bit[3:0] = 4'b0101;
        
        #1000;
        // 99
        input_bit[7:4] = 4'b1001;
        input_bit[3:0] = 4'b1001;
                
        #1000;
        $finish;
        
    end
endmodule
