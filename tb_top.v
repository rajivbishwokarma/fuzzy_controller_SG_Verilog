`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 08/02/2019 09:28:11 AM
//////////////////////////////////////////////////////////////////////////////////

module top_tb;
    reg clk;
    reg [7:0] bcd;
    wire [7:0] duty;
    
    top UUT(
        .clk(clk),
        .bcd(bcd),
        .duty(duty)
    );
    
    initial begin
        clk = 0;
        forever begin
            clk = #5 ~clk;
        end
    end
    
    initial begin
        
    bcd =  8'b00000000;      #1000; // 0
    bcd =  8'b00000001;      #1000; // 1
    bcd =  8'b00000010;      #1000; // 2
    bcd =  8'b00000011;      #1000; // 3
    bcd =  8'b00000100;      #1000; // 4
    bcd =  8'b00000101;      #1000; // 5
    bcd =  8'b00000110;      #1000; // 6
    bcd =  8'b00000111;      #1000; // 7
    bcd =  8'b00001000;      #1000; // 8
    bcd =  8'b00001001;      #1000; // 9
    bcd  = 8'b00010000;      #1000; // 10
    bcd  = 8'b00010001;      #1000; // 11
    bcd  = 8'b00010010;      #1000; // 12
    bcd  = 8'b00010011;      #1000; // 13
    bcd  = 8'b00010100;      #1000; // 14
    bcd  = 8'b00010101;      #1000; // 15
    bcd  = 8'b00010110;      #1000; // 16
    bcd  = 8'b00010111;      #1000; // 17
    bcd  = 8'b00011000;      #1000; // 18
    bcd  = 8'b00011001;      #1000; // 19
    bcd  = 8'b00011010;      #1000; // 20
    bcd  = 8'b00011011;      #1000; // 21
    
    $finish;
    end  
endmodule
