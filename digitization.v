`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Original Creation Date: 05/28/2019 01:18:21 PM
//////////////////////////////////////////////////////////////////////////////////


module digitization(
    input clk,
    input [7:0] input_bit,
    output [7:0] freq
    );
    
    reg BIT_ONE = 1'b1;
    reg BIT_ZER = 1'b0;
    
    /* BCD representations */
    reg [3:0] ONE = 4'b0001;
    reg [3:0] TWO = 4'b0010;
    reg [3:0] THR = 4'b0011;
    reg [3:0] FOR = 4'b0100;
    reg [3:0] FIV = 4'b0101; 
    reg [3:0] SIX = 4'b0110; 
    reg [3:0] SEV = 4'b0111; 
    reg [3:0] EIG = 4'b1000;
    reg [3:0] NIN = 4'b1001; 
    reg [3:0] ZER = 4'b0000;
    
    reg [7:0] FORSIX;// = 8'b01000110;         //46
    reg [7:0] FOREIG;// = 8'b01001000;         //48             
    reg [7:0] FORFOR;// = 8'b01000100;         //44
    reg [7:0] FORTWO;// = 8'b01000010;         //42
    reg [7:0] FIVTWO;// = 8'b01010010;         //52
    reg [7:0] FIVFOR;// = 8'b01010100;         //54             
    reg [7:0] FIVSIX;// = 8'b01010110;         //56             
    reg [7:0] FIVEIG;// = 8'b01011000;         //58
    reg [7:0] SIXZER;// = 8'b01100000;         //60
    reg [7:0] NINNIN;// = 8'b10011001;         //99 
    
    
    reg [7:0] ONEZER;// = 8'b00010000;         //10
    reg [7:0] FIVZER;// = 8'b01010000;         //50
    
    
    reg [3:0] LSB_DIG;
    reg [3:0] MSB_DIG;
    
    reg [7:0] internal_freq;
    
    
    
    /* This 'always' block only converts the data bits received in the PMOD Ports of the Zybo Z7-10 to binary digit values. */
    always @(posedge clk) begin
    
        /*  Aassigning appropriate values to the BCD LSB */
        if ((input_bit[3] == BIT_ZER) && (input_bit[2] == BIT_ZER) && (input_bit[1] == BIT_ZER) && (input_bit[0] == BIT_ZER)) begin
            LSB_DIG = ZER;
        end else if ((input_bit[3] == BIT_ZER) && (input_bit[2] == BIT_ZER) && (input_bit[1] == BIT_ZER) && (input_bit[0] == BIT_ONE)) begin
            LSB_DIG = ONE;
        end else if ((input_bit[3] == BIT_ZER) && (input_bit[2] == BIT_ZER) && (input_bit[1] == BIT_ONE) && (input_bit[0] == BIT_ZER)) begin
            LSB_DIG = TWO;
        end else if ((input_bit[3] == BIT_ZER) && (input_bit[2] == BIT_ZER) && (input_bit[1] == BIT_ONE) && (input_bit[0] == BIT_ONE)) begin
            LSB_DIG = THR;
        end else if ((input_bit[3] == BIT_ZER) && (input_bit[2] == BIT_ONE) && (input_bit[1] == BIT_ZER) && (input_bit[0] == BIT_ZER)) begin
            LSB_DIG = FOR;
        end else if ((input_bit[3] == BIT_ZER) && (input_bit[2] == BIT_ONE) && (input_bit[1] == BIT_ZER) && (input_bit[0] == BIT_ONE)) begin
            LSB_DIG = FIV;
        end else if ((input_bit[3] == BIT_ZER) && (input_bit[2] == BIT_ONE) && (input_bit[1] == BIT_ONE) && (input_bit[0] == BIT_ZER)) begin
            LSB_DIG = SIX;
        end else if ((input_bit[3] == BIT_ZER) && (input_bit[2] == BIT_ONE) && (input_bit[1] == BIT_ONE) && (input_bit[0] == BIT_ONE)) begin
            LSB_DIG = SEV;    
        end else if ((input_bit[3] == BIT_ONE) && (input_bit[2] == BIT_ZER) && (input_bit[1] == BIT_ZER) && (input_bit[0] == BIT_ZER)) begin
            LSB_DIG = EIG;
        end else if ((input_bit[3] == BIT_ONE) && (input_bit[2] == BIT_ZER) && (input_bit[1] == BIT_ZER) && (input_bit[0] == BIT_ONE)) begin
            LSB_DIG = NIN;
        end
        
        /*  Aassigning appropriate values to the BCD MSB */
        if ((input_bit[7] == BIT_ZER) && (input_bit[6] == BIT_ZER) && (input_bit[5] == BIT_ZER) && (input_bit[4] == BIT_ZER)) begin
            MSB_DIG = ZER;
        end else if ((input_bit[7] == BIT_ZER) && (input_bit[6] == BIT_ZER) && (input_bit[5] == BIT_ZER) && (input_bit[4] == BIT_ONE)) begin
            MSB_DIG = ONE;
        end else if ((input_bit[7] == BIT_ZER) && (input_bit[6] == BIT_ZER) && (input_bit[5] == BIT_ONE) && (input_bit[4] == BIT_ZER)) begin
            MSB_DIG = TWO;
        end else if ((input_bit[7] == BIT_ZER) && (input_bit[6] == BIT_ZER) && (input_bit[5] == BIT_ONE) && (input_bit[4] == BIT_ONE)) begin
            MSB_DIG = THR;
        end else if ((input_bit[7] == BIT_ZER) && (input_bit[6] == BIT_ONE) && (input_bit[5] == BIT_ZER) && (input_bit[4] == BIT_ZER)) begin
            MSB_DIG = FOR;
        end else if ((input_bit[7] == BIT_ZER) && (input_bit[6] == BIT_ONE) && (input_bit[5] == BIT_ZER) && (input_bit[4] == BIT_ONE)) begin
            MSB_DIG = FIV;
        end else if ((input_bit[7] == BIT_ZER) && (input_bit[6] == BIT_ONE) && (input_bit[5] == BIT_ONE) && (input_bit[4] == BIT_ZER)) begin
            MSB_DIG = SIX;
        end else if ((input_bit[7] == BIT_ZER) && (input_bit[6] == BIT_ONE) && (input_bit[5] == BIT_ONE) && (input_bit[4] == BIT_ONE)) begin
            MSB_DIG = SEV;
        end else if ((input_bit[7] == BIT_ONE) && (input_bit[6] == BIT_ZER) && (input_bit[5] == BIT_ZER) && (input_bit[4] == BIT_ZER)) begin
            MSB_DIG = EIG;
        end else if ((input_bit[7] == BIT_ONE) && (input_bit[6] == BIT_ZER) && (input_bit[5] == BIT_ZER) && (input_bit[4] == BIT_ONE)) begin
            MSB_DIG = NIN;
        end
    end
    
    
    always @* begin
       internal_freq = (MSB_DIG * 4'b1010) + {3'b0, LSB_DIG};
    end
    
    assign freq = internal_freq;
    
endmodule
