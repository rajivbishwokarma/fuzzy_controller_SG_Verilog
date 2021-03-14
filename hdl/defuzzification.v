`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 07/28/2019 10:26:36 PM
//////////////////////////////////////////////////////////////////////////////////

module defuzzification(
    input clk,
    input [7:0] output_fuzzy_set_id,
    output [7:0] pwm_duty
    );
    
    /* Local parameters to represent the numbers for readability */
    parameter LEN_FOUR = 3;
    parameter LEN_EIGHT = 7;
    
    parameter zero_ebit =     8'b00000000;
    parameter one_ebit =      8'b00000001;
    parameter two_ebit =      8'b00000010;
    parameter three_ebit =    8'b00000011;
    parameter four_ebit =     8'b00000100;
    parameter five_ebit =     8'b00000101;
    parameter six_ebit =      8'b00000110;
    parameter seven_ebit =    8'b00000111;
    parameter eight_ebit =    8'b00001000;
    parameter nine_ebit =     8'b00001001;
    parameter ten_ebit =      8'b00001010;
    parameter eleven_ebit =   8'b00001011;
    
    parameter twenty_ebit =   8'b00010100;
    parameter thirty_ebit =   8'b00011110;
    parameter fourty_ebit =   8'b00101000;
    parameter fifty_ebit =    8'b00110010;
    parameter sixty_ebit =    8'b00111100;
    parameter seventy_ebit =  8'b01000110;
    parameter eighty_ebit =   8'b01010000;
    parameter ninety_ebit =   8'b01011010;
    parameter hundred_ebit =  8'b01100100;
    
    reg [LEN_EIGHT:0] memo_negGigantic;
    reg [LEN_EIGHT:0] memo_negHuge;
    reg [LEN_EIGHT:0] memo_negBig;
    reg [LEN_EIGHT:0] memo_negMedium;
    reg [LEN_EIGHT:0] memo_negSmall;
	reg [LEN_EIGHT:0] memo_zero;
	reg [LEN_EIGHT:0] memo_posSmall;
	reg [LEN_EIGHT:0] memo_posMedium;
	reg [LEN_EIGHT:0] memo_posBig;
	reg [LEN_EIGHT:0] memo_posHuge;
	reg [LEN_EIGHT:0] memo_posGigantic;
    
    reg [7:0] degree_mem;
    reg [7:0] duty_cycle;
    
    
    
    always@ (posedge clk) begin
        degree_mem = output_fuzzy_set_id;
        
        case (output_fuzzy_set_id) 
            zero_ebit:  begin
                            /* TODO: When the output fuzzy set id is zero */
                        end
            one_ebit:   begin
                            /* Division by 10 causes a floating point value, however, the result would still be the same without it.
                             * Division by 10 is removed; See 'defuzzification.v' for where the division should be placed.  */
                            memo_negGigantic = -(degree_mem) + ten_ebit;         /* -(1/10) + 10 = 9.9 : -(1) + 10 = 9=> NOT SELECTED */
		                    memo_negHuge = degree_mem;                           /* (1 / 10) = 0.1     : 1 = 1        => SELECTED    */
		                    
		                    
		                    
		                    /* Selecting the lower of the two values */
		                    if (memo_negGigantic >= memo_negHuge)
                                duty_cycle = memo_negHuge;
                            else 
                                duty_cycle = memo_negGigantic;
		                    
                        end
            two_ebit:   begin
                            memo_negHuge = -(degree_mem) + twenty_ebit;  /* (-2 / 10) + 20 = 19.8    :  -2 + 20 = 18 */
		                    memo_negBig = (degree_mem) + ten_ebit;       /* (2 / 10) + 10  = 10.2    :   2 + 10 = 12 => SELECTED*/
		                    
		                    /* Selecting the lower of the two values */
		                    if (memo_negHuge >= memo_negBig)
                                duty_cycle = memo_negBig;
                            else 
                                duty_cycle = memo_negHuge;
		                    
                        end
            three_ebit: begin
                            memo_negBig = -(degree_mem) + thirty_ebit;
                            memo_negMedium = (degree_mem) + twenty_ebit;
                            
                            /* Selecting the lower of the two values */
		                    if (memo_negMedium >= memo_negBig)
                                duty_cycle = memo_negBig;
                            else 
                                duty_cycle = memo_negMedium; 
                            
                        end
            four_ebit: begin
                            memo_negMedium = -(degree_mem) + fourty_ebit;
                            memo_negSmall = (degree_mem) + thirty_ebit;
                            
                            /* Selecting the lower of the two values */
		                    if (memo_negMedium >= memo_negSmall)
                                duty_cycle = memo_negSmall;
                            else 
                                duty_cycle = memo_negMedium;
                             
                        end
            five_ebit: begin
                            memo_negSmall = -(degree_mem) + fifty_ebit;
                            memo_zero = (degree_mem) + fourty_ebit;
                            
                            /* Selecting the lower of the two values */
		                    if (memo_zero >= memo_negSmall)
                                duty_cycle = memo_negSmall;
                            else 
                                duty_cycle = memo_zero;
                            
                        end
            six_ebit: begin
                            /* For the singleton function at the middle, only one value exists */
                           memo_zero = fifty_ebit; 
                           duty_cycle = memo_zero;
                           
                        end
            seven_ebit: begin
                            memo_zero = -(degree_mem) + sixty_ebit;      /* -(6 / 10) + 60 = 59.4 */
                            memo_posSmall = (degree_mem) + fifty_ebit;   /*  6 / 10 + 50 = 50.6 => SELECTED*/
                            
                            /* Selecting the lower of the two values */
		                    if (memo_zero >= memo_posSmall)
                                duty_cycle = memo_posSmall;
                            else 
                                duty_cycle = memo_zero;
                            
                        end
            eight_ebit: begin
                            memo_posSmall = -(degree_mem) + seventy_ebit;
                            memo_posMedium = (degree_mem) + sixty_ebit; 
                            
                            /* Selecting the lower of the two values */
		                    if (memo_posMedium >= memo_posSmall)
                                duty_cycle = memo_posSmall;
                            else 
                                duty_cycle = memo_posMedium;
                            
                        end
            nine_ebit: begin
                            memo_posMedium = -(degree_mem) + eighty_ebit;
                            memo_posBig = (degree_mem) + seventy_ebit; 
                            
                            /* Selecting the lower of the two values */
		                    if (memo_posMedium >= memo_posBig)
                                duty_cycle = memo_posBig;
                            else 
                                duty_cycle = memo_posMedium;
                            
                        end
            ten_ebit: begin
                            memo_posBig = -(degree_mem) + ninety_ebit;
                            memo_posHuge = (degree_mem) + eighty_ebit; 
                            
                            /* Selecting the lower of the two values */
		                    if (memo_posHuge >= memo_posBig)
                                duty_cycle = memo_posBig;
                            else 
                                duty_cycle = memo_posHuge;
                            
                        end
            eleven_ebit: begin
                            memo_posHuge = -(degree_mem) + hundred_ebit;
                            memo_posGigantic = (degree_mem) + ninety_ebit;
                            
                            /* Selecting the lower of the two values */
		                    if (memo_posHuge >= memo_posGigantic)
                                duty_cycle = memo_posGigantic;
                            else 
                                duty_cycle = memo_posHuge;
                            
                        end
        endcase
    end /* always end */
    
    /* Assigning the value of internal register to output */
    assign pwm_duty = duty_cycle;
    
endmodule
