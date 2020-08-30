`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 07/28/2019 02:10:19 PM
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Original Create Date: 06/25/2019 06:38:27 AM
// Author: Rajiv Bishwokarma
// Email: rajivbishwokarma@outlook.com
// Module:  Fuzzification.v
//////////////////////////////////////////////////////////////////////////////////

/* 
Variables that represent membership function are of the following form:
Input fuzzy set membership function: memi_<fuzzy_set>
Ouptut fuzzy set memebership funciton: memo_<fuzzy_set>

Integer Code		Representation		Fuzzy Sets

 [1]		negGigantic:			Negative Gigantic
 [2]		negHuge:				Negative Huge
 [3]		negBig:					Negative Big
 [4]		negMedium:				Negative Medium
 [5]		negSmall:				Legative Small
 [6]		zero:					Zero
 [7]		posSmall:				Positive Small
 [8]		posMedium:				Positive Medium
 [9]		posBig:					Positive Big
 [10]		posHuge:				Positive Huge
 [11]		posGigantic:			Positive Gigantic
 
 */

module fuzzification(
    input clk,
    input [7:0] freq_crisp, 
    output [7:0] ptr_freq_fuzzy, 
    output [7:0] ptr_input_fuzzy_set_id, 
    output [7:0] ptr_negGigantic, 
    output [7:0] ptr_negHuge, 
    output [7:0] ptr_negBig, 
    output [7:0] ptr_negMedium, 
    output [7:0] ptr_negSmall, 
	output [7:0] ptr_zero, 
	output [7:0] ptr_posSmall, 
	output [7:0] ptr_posMedium, 
	output [7:0] ptr_posBig, 
	output [7:0] ptr_posHuge, 
	output [7:0] ptr_posGigantic 
    );
    
    reg [7:0] int_freq_fuzzy;
    reg [7:0] int_input_fuzzy_set_id; 
    reg [7:0] int_negGigantic;
    reg [7:0] int_negHuge; 
    reg [7:0] int_negBig;
    reg [7:0] int_negMedium; 
    reg [7:0] int_negSmall; 
	reg [7:0] int_zero; 
	reg [7:0] int_posSmall; 
	reg [7:0] int_posMedium; 
	reg [7:0] int_posBig; 
	reg [7:0] int_posHuge; 
	reg [7:0] int_posGigantic; 
    
    
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
    parameter twelve_ebit =   8'b00001100;
    parameter thirteen_ebit = 8'b00001101;
    parameter fourteen_ebit = 8'b00001110;
    parameter fifteen_ebit =  8'b00001111;
    parameter sixteen_ebit =  8'b00010000;
    parameter seventeen_ebit =8'b00010001;
    parameter eighteen_ebit = 8'b00010010;
    parameter nineteen_ebit = 8'b00010011;
    parameter twenty_ebit =   8'b00010100;
    
    /* Internal register to hold the crisp value of frequency  */
    reg [7:0] int_freq_crisp;
    
    always@ (posedge clk) begin
        int_freq_crisp <= freq_crisp;
        
        if (int_freq_crisp < zero_ebit) begin
            int_negGigantic <= one_ebit;
            
            /* Identifying the selected fuzzy set */
            int_input_fuzzy_set_id <= one_ebit;
            
            /* The input to rule base is calculated with MAX rule, direct assignment works as only one value exists */
            int_freq_fuzzy <= int_negGigantic;
            
            /* Set everything else to zero */
            int_negHuge <=     8'b00000000;
		    int_negBig <=      8'b00000000;
		    int_negMedium <=   8'b00000000;
		    int_negSmall <=    8'b00000000;
		    int_zero <=        8'b00000000;
		    int_posSmall <=    8'b00000000;
		    int_posMedium <=   8'b00000000;
		    int_posBig <=      8'b00000000;
		    int_posHuge <=     8'b00000000;
		    int_posGigantic <= 8'b00000000;
		    
            
        end else if ((int_freq_crisp >= zero_ebit) && (int_freq_crisp < two_ebit)) begin
            //int_negHuge <= freq_crisp  /* / two_ebit */;
            //int_negGigantic <= (two_ebit - int_freq_crisp) /* / two_ebit */;
            /* Instead of a division algorithm, a division by 2 LUT is created below. */
            case (freq_crisp)
                zero_ebit: begin
                                int_negHuge <= zero_ebit;       /*   0   / 2 = 0 */
                                int_negGigantic <= one_ebit;    /* (2-0) / 2 = 1 */
                           end
                one_ebit:  begin
                                int_negHuge <= one_ebit;     /* 1 / 2 = 1 */
                                int_negGigantic <= one_ebit;    /* (2-1) / 2 = 1 */
                           end
            endcase
            
            if (int_negHuge >= int_negGigantic) begin
                int_freq_fuzzy <= int_negHuge;
                int_input_fuzzy_set_id <= two_ebit;
            end else begin
                int_freq_fuzzy <= int_negGigantic;
                int_input_fuzzy_set_id <= one_ebit;
            end
            
            /* Set everything else to zero */
            int_negBig <=      8'b00000000;
		    int_negMedium <=   8'b00000000;
		    int_negSmall <=    8'b00000000;
		    int_zero <=        8'b00000000;
		    int_posSmall <=    8'b00000000;
		    int_posMedium <=   8'b00000000;
		    int_posBig <=      8'b00000000;
		    int_posHuge <=     8'b00000000;
		    int_posGigantic <= 8'b00000000;
		    
        end else if ((int_freq_crisp >= two_ebit) && (int_freq_crisp < four_ebit)) begin
            case (freq_crisp)
                two_ebit: begin
                                    /* int_negHuge <= (four_ebit - int_freq_crisp) / two_ebit ; */
                                    int_negHuge <= one_ebit;       /*   (4 - 2)  / 2 = 1 */
                                    
                                    /* int_negBig <=  (int_freq_crisp - two_ebit) / two_ebit ; */
                                    int_negBig <= zero_ebit;    /* (2 - 2) / 2 = 0 */
                           end
                three_ebit:  begin
                                    /* int_negHuge <= (four_ebit - int_freq_crisp) / two_ebit ; */
                                    int_negHuge <= zero_ebit;       /*   (4 - 3)  / 2 = 1 */
                                    
                                    /* int_negBig <=  (int_freq_crisp - two_ebit) / two_ebit ; */
                                    int_negBig <= one_ebit;    /* (3 - 2) / 2 = 0 */
                           end
            endcase
            
            if (int_negHuge >= int_negBig) begin
                int_freq_fuzzy <= int_negHuge;
                int_input_fuzzy_set_id <= two_ebit;
            end else begin
                int_freq_fuzzy <= int_negBig;
                int_input_fuzzy_set_id <= three_ebit;
            end
            
            /* Set everything else to zero */ 
            int_negGigantic <= 8'b00000000;
		    int_negMedium <=   8'b00000000;
		    int_negSmall <=    8'b00000000;
		    int_zero <=        8'b00000000;
		    int_posSmall <=    8'b00000000;
		    int_posMedium <=   8'b00000000;
		    int_posBig <=      8'b00000000;
		    int_posHuge <=     8'b00000000;
		    int_posGigantic <= 8'b00000000;
            
        end else if ((int_freq_crisp >= four_ebit) && (int_freq_crisp < six_ebit)) begin
        
            case (freq_crisp)
                four_ebit: begin
                                    /* int_negBig <= (six_ebit - int_freq_crisp) / two_ebit; */
                                    int_negBig <= one_ebit;       /*   (6 - 4)  / 2 = 1 (44 Hz should be negative big with 1 membership value) */
                                    
                                    /* int_negMedium <= (int_freq_crisp - 4) / two_ebit; */
                                    int_negMedium <= zero_ebit;    /* (4 - 2) / 2 = 1  (44 Hz should be negative medium with 0 membership value) */
                           end
                five_ebit:  begin
                                    /* int_negBig <= (six_ebit - int_freq_crisp) / two_ebit; */
                                    int_negBig <= zero_ebit;       /*   (6 - 5)  / 2 = 0.5 (45 Hz should be negative Big with 0 membership value) */
                                    
                                    /* int_negMedium <= (int_freq_crisp - 4) / two_ebit; */
                                    int_negMedium <= one_ebit;    /* (5 - 4) / 2 = 0.5 (44 Hz should be negative medium with 1 membership value) */
                           end
            endcase
            
            /* Selecting the maximum value */
            if (int_negBig >= int_negMedium) begin
                int_freq_fuzzy <= int_negBig;
                int_input_fuzzy_set_id <= three_ebit;
            end else begin
                int_freq_fuzzy <= int_negMedium;
                int_input_fuzzy_set_id <= four_ebit;
            end
            
            /* Set everything else to zero */
		    int_negGigantic <= 8'b00000000;
		    int_negHuge <=     8'b00000000;
		    int_negSmall <=    8'b00000000;
		    int_zero <=        8'b00000000;
		    int_posSmall <=    8'b00000000;
		    int_posMedium <=   8'b00000000;
		    int_posBig <=      8'b00000000;
		    int_posHuge <=     8'b00000000;
		    int_posGigantic <= 8'b00000000;
            
        end else if ((int_freq_crisp >= six_ebit) && (int_freq_crisp < eight_ebit)) begin
            
            case (freq_crisp)
                six_ebit: begin
                                    /* int_negMedium <= (six_ebit - int_freq_crisp) / two_ebit; */
                                    int_negMedium <= one_ebit;       /*   (6 - 6)  / 2 = 1 (46 Hz should be negative medium with 1 membership value) */
                                    
                                    /* int_negSmall <= (int_freq_crisp - six_ebit) / two_ebit; */
                                    int_negSmall <= zero_ebit;    /* (4 - 2) / 2 = 1  (46 Hz should be negative Small with 0 membership value) */
                           end
                seven_ebit:  begin
                                    /* int_negMedium <= (six_ebit - int_freq_crisp) / two_ebit; */
                                    int_negMedium <= zero_ebit;       /*   (6 - 7)  / 2 = 1 (47 Hz should be negative big with 0 membership value) */
                                    
                                    /* int_negSmall <= (int_freq_crisp - six_ebit) / two_ebit; */
                                    int_negSmall <= one_ebit;    /* (7 - 6) / 2 = 1  (47 Hz should be negative medium with 1 membership value) */
                           end
            endcase
        
            /* Selecting the maximum value */
		    if (int_negMedium >= int_negSmall) begin
			     int_freq_fuzzy <= int_negMedium;
			     int_input_fuzzy_set_id <= four_ebit;
		    end else begin
			     int_freq_fuzzy <= int_negSmall;
			     int_input_fuzzy_set_id <= five_ebit;
		    end


		    /* Set everything else to zero */
		    int_negGigantic <= 8'b00000000;
		    int_negHuge <=     8'b00000000;
		    int_negBig <=      8'b00000000;
		    int_zero <=        8'b00000000;
		    int_posSmall <=    8'b00000000;
		    int_posMedium <=   8'b00000000;
		    int_posBig <=      8'b00000000;
		    int_posHuge <=     8'b00000000;
	       	int_posGigantic <= 8'b00000000;
	       	
        end else if ((int_freq_crisp >= eight_ebit) && (int_freq_crisp < ten_ebit)) begin
            
            case (freq_crisp)
                eight_ebit: begin
                                    /* int_zero <= (int_freq_crisp - eight_ebit) / two_ebit; */
                                    int_zero <= zero_ebit;       /*   (8 - 8)  / 2 = 0 (48 Hz should be zero with 0 membership value) */
                                    
                                    /* int_negSmall <= (ten_ebit - int_freq_crisp) / two_ebit; */
                                    int_negSmall <= one_ebit;    /* (10 - 8) / 2 = 1  (48 Hz should be negative Small with 1 membership value) */
                           end
                nine_ebit:  begin
                                    /* int_zero <= (int_freq_crisp - eight_ebit) / two_ebit; */
                                    int_zero <= zero_ebit;       /*   (9 - 8)  / 2 = 1 (49 Hz should be negative medium with 0 membership value) */
                                    
                                    /* int_negSmall <= (ten_ebit - int_freq_crisp) / two_ebit; */
                                    int_negSmall <= one_ebit;    /* (10 - 9) / 2 = 1  (49 Hz should be negative Small with 0.5 membership value) */
                           end
            endcase
            
		    /* Selecting the maximum value */
		    if (int_zero >= int_negSmall) begin
			     int_freq_fuzzy <= int_zero;
			     int_input_fuzzy_set_id <= six_ebit;
		    end else begin
			     int_freq_fuzzy <= int_negSmall;
			     int_input_fuzzy_set_id <= five_ebit;
		    end


		    /* Set everything else to zero */
		    int_negGigantic <= 8'b00000000;
		    int_negHuge <=     8'b00000000;
		    int_negBig <=      8'b00000000;
		    int_negMedium <=   8'b00000000;
		    int_posSmall <=    8'b00000000;
		    int_posMedium <=   8'b00000000;
		    int_posBig <=      8'b00000000;
		    int_posHuge <=     8'b00000000;
		    int_posGigantic <= 8'b00000000;
		    
        end else if ((int_freq_crisp >= ten_ebit) && (int_freq_crisp < twelve_ebit)) begin
            
            case (freq_crisp)
                ten_ebit: begin
                                    /* int_zero <= (twelve_ebit - int_freq_crisp) / two_ebit; */
                                    int_zero <= one_ebit;       /*   (12 - 10)  / 2 = 1 (50 Hz should be zero with 1 membership value) */
                                    
                                    /* int_posSmall <= (int_freq_crisp - ten_ebit) / two_ebit; */
                                    int_posSmall <= zero_ebit;    /* (10 - 10) / 2 = 0  (50 Hz should be positive Small with 0 membership value) */
                           end
                eleven_ebit:  begin
                                    /* int_zero <= (twelve_ebit - int_freq_crisp) / two_ebit; */
                                    int_zero <= zero_ebit;       /*   (12 - 11)  / 2 = 0 (51 Hz should be zero with 0 membership value) */
                                    
                                    /* int_posSmall <= (int_freq_crisp - ten_ebit) / two_ebit; */
                                    int_posSmall <= one_ebit;    /* (11 - 10) / 2 = 1  (51 Hz should be positive Small with 1 membership value) */
                           end
            endcase
        
		    /* Selecting the maximum value */
		    if (int_zero >= int_posSmall) begin
			     int_freq_fuzzy <= int_zero;
			     int_input_fuzzy_set_id <= six_ebit;
		    end else begin
			     int_freq_fuzzy <= int_posSmall;
			     int_input_fuzzy_set_id <= seven_ebit;
		    end


		    /* Set everything else to zero */
		    int_negGigantic <= 8'b00000000;
		    int_negHuge <=     8'b00000000;
		    int_negBig <=      8'b00000000;
	        int_negMedium <=   8'b00000000;
		    int_negSmall <=    8'b00000000;
		    int_posMedium <=   8'b00000000;
            int_posBig <=      8'b00000000;
		    int_posHuge <=     8'b00000000;
		    int_posGigantic <= 8'b00000000;
		    
        end else if ((int_freq_crisp >= twelve_ebit) && (int_freq_crisp < fourteen_ebit)) begin
            
            case (freq_crisp)
                twelve_ebit: begin
                                    /* int_posMedium <= (int_freq_crisp - twelve_ebit) / two_ebit; */
                                    int_posMedium <= zero_ebit;       /*   (12 - 12)  / 2 = 0 (52 Hz should be positive medium with 0 membership value) */
                                    
                                    /* int_posSmall <= (fourteen_ebit - int_freq_crisp) / two_ebit; */
                                    int_posSmall <= one_ebit;    /* (14 - 12) / 2 = 1  (52 Hz should be positive Small with 1 membership value) */
                           end
                thirteen_ebit:  begin
                                    /* int_posMedium <= (int_freq_crisp - twelve_ebit) / two_ebit; */
                                    int_posMedium <= one_ebit;       /*   (13 - 12)  / 2 = 1 (53 Hz should be positive medium with 1 membership value) */
                                    
                                    /* int_posSmall <= (fourteen_ebit - int_freq_crisp) / two_ebit; */
                                    int_posSmall <= zero_ebit;    /* (14 - 13) / 2 = 0  (53 Hz should be positive Small with 0 membership value) */
                           end
            endcase
        
		    /* Selecting the maximum value */
		    if (int_posSmall >= int_posMedium) begin
			     int_freq_fuzzy <= int_posSmall;
			     int_input_fuzzy_set_id <= seven_ebit;
		    end else begin
			     int_freq_fuzzy <= int_posMedium;
			     int_input_fuzzy_set_id <= eight_ebit;
		    end


		    /* Set everything else to zero */
		    int_negGigantic <= 8'b00000000;
		    int_negHuge <=     8'b00000000;
		    int_negBig <=      8'b00000000;
		    int_negMedium <=   8'b00000000;
		    int_negSmall <=    8'b00000000;
		    int_zero <=        8'b00000000;
		    int_posBig <=      8'b00000000;
	        int_posHuge <=     8'b00000000;
            int_posGigantic <= 8'b00000000;
		    
        end else if ((int_freq_crisp >= fourteen_ebit) && (int_freq_crisp < sixteen_ebit)) begin
        
            case (freq_crisp)
                fourteen_ebit: begin
                                    /* int_posMedium <= (sixteen_ebit - int_freq_crisp) / two_ebit; */
                                    int_posMedium <= one_ebit;       /*   (16 - 14)  / 2 = 1 (54 Hz should be positive medium with 1 membership value) */
                                    
                                    /* int_posBig <= (int_freq_crisp - fourteen_ebit)   / two_ebit; */
                                    int_posBig <= zero_ebit;    /* (14 - 14) / 2 = 0  (54 Hz should be positive big with 0 membership value) */
                           end
                fifteen_ebit:  begin
                                    /* int_posMedium <= (sixteen_ebit - int_freq_crisp) / two_ebit; */
                                    int_posMedium <= zero_ebit;       /*   (16 - 15)  / 2 = 0 (55 Hz should be positive medium with 0 membership value) */
                                    
                                    /* int_posBig <= (int_freq_crisp - fourteen_ebit)   / two_ebit; */
                                    int_posBig <= one_ebit;    /* (15 - 14) / 2 = 1  (55 Hz should be positive big with 1 membership value) */
                           end
            endcase
        
		    /* Selecting the maximum value */
		    if (int_posMedium >= int_posBig) begin
			     int_freq_fuzzy <= int_posMedium;
			     int_input_fuzzy_set_id <= eight_ebit;
		    end else begin
			     int_freq_fuzzy <= int_posBig;
			     int_input_fuzzy_set_id <= nine_ebit;
		    end


		    /* Set everything else to zero */
		    int_negGigantic <= 8'b00000000;
            int_negHuge <=     8'b00000000;
            int_negBig <=      8'b00000000;
            int_negMedium <=   8'b00000000;
            int_negSmall <=    8'b00000000;
            int_zero <=        8'b00000000;
            int_posSmall <=    8'b00000000;
            int_posHuge <=     8'b00000000;
            int_posGigantic <= 8'b00000000;
		    
        end else if ((int_freq_crisp >= sixteen_ebit) && (int_freq_crisp < eighteen_ebit)) begin
            
            case (freq_crisp)
                sixteen_ebit: begin
                                    /* int_posMedium <= (sixteen_ebit - int_freq_crisp) / two_ebit; */
                                    int_posHuge <= zero_ebit;       /*   (16 - 14)  / 2 = 1 (56 Hz should be positive Huge with 0 membership value) */
                                    
                                    /* int_posBig <= (int_freq_crisp - fourteen_ebit)   / two_ebit; */
                                    int_posBig <= one_ebit;    /* (16 - 14) / 2 = 1  (56 Hz should be positive big with 1 membership value) */
                           end
                seventeen_ebit:  begin
                                    /* int_posMedium <= (sixteen_ebit - int_freq_crisp) / two_ebit; */
                                    int_posHuge <= one_ebit;       /*   (16 - 15)  / 2 = 0 (55 Hz should be positive medium with 0 membership value) */
                                    
                                    /* int_posBig <= (int_freq_crisp - fourteen_ebit)   / two_ebit; */
                                    int_posBig <= zero_ebit;    /* (15 - 14) / 2 = 1  (55 Hz should be positive big with 1 membership value) */
                           end
            endcase

		    /* Selecting the maximum value */
		    if (int_posHuge >= int_posBig) begin
			     int_freq_fuzzy <= int_posHuge;
			     int_input_fuzzy_set_id <= ten_ebit;
		    end else begin
			     int_freq_fuzzy <= int_posBig;
			     int_input_fuzzy_set_id <= nine_ebit;
		    end


		    /* Set everything else to zero */
		    int_negGigantic <= 8'b00000000;
            int_negHuge <=     8'b00000000;
            int_negBig <=      8'b00000000;
            int_negMedium <=   8'b00000000;
            int_negSmall <=    8'b00000000;
            int_zero <=        8'b00000000;
            int_posSmall <=    8'b00000000;
            int_posMedium <=   8'b00000000;
            int_posGigantic <= 8'b00000000;
		    
        end else if ((int_freq_crisp >= eighteen_ebit) && (int_freq_crisp < twenty_ebit)) begin
        
            case (freq_crisp)
                eighteen_ebit: begin
                                    /* int_posMedium <= (sixteen_ebit - int_freq_crisp) / two_ebit; */
                                    int_posHuge <= one_ebit;       /*   (18 - 16)  / 2 = 1 (58 Hz should be positive Huge with 1 membership value) */
                                    
                                    /* int_posBig <= (int_freq_crisp - fourteen_ebit)   / two_ebit; */
                                    int_posGigantic <= zero_ebit;    /* (18 - 16) / 2 = 1  (58 Hz should be positive Gigantic with 0 membership value) */
                           end
                nineteen_ebit:  begin
                                    /* int_posMedium <= (sixteen_ebit - int_freq_crisp) / two_ebit; */
                                    int_posHuge <= zero_ebit;       /*   (16 - 15)  / 2 = 0 (55 Hz should be positive medium with 0 membership value) */
                                    
                                    /* int_posBig <= (int_freq_crisp - fourteen_ebit)   / two_ebit; */
                                    int_posGigantic <= one_ebit;    /* (15 - 14) / 2 = 1  (55 Hz should be positive big with 1 membership value) */
                           end
            endcase

		    /* Selecting the maximum value */
		    if (int_posHuge >= int_posGigantic) begin
			     int_freq_fuzzy <= int_posHuge;
			     int_input_fuzzy_set_id <= ten_ebit;
		    end else begin
			     int_freq_fuzzy <= int_posGigantic;
			     int_input_fuzzy_set_id <= eleven_ebit;
		    end


		    /* Set everything else to zero */
		    int_negGigantic <= 8'b00000000;
            int_negHuge <=     8'b00000000;
            int_negBig <=      8'b00000000;
            int_negMedium <=   8'b00000000;
            int_negSmall <=    8'b00000000;
            int_zero <=        8'b00000000;
            int_posSmall <=    8'b00000000;
            int_posMedium <=   8'b00000000;
            int_posBig <= 8'b00000000;
            
        end else if (int_freq_crisp >= twenty_ebit) begin
            
            case (freq_crisp)
                twenty_ebit: begin
                                    /* int_posGigantic <= (int_freq_crisp - eighteen_ebit)   / two_ebit; */
                                    int_posGigantic <= one_ebit;    /* (20 - 18) / 2 = 1  (60 Hz should be positive Gigantic with 1 membership value) */
                           end
            endcase

		    /* Selecting the maximum value */
		    int_freq_fuzzy <= int_posGigantic;
		    int_input_fuzzy_set_id <= eleven_ebit;

		    /* Set everything else to zero */
		    int_negGigantic <= 8'b00000000;
            int_negHuge <=     8'b00000000;
            int_negBig <=      8'b00000000;
            int_negMedium <=   8'b00000000;
            int_negSmall <=    8'b00000000;
            int_zero <=        8'b00000000;
            int_posSmall <=    8'b00000000;
            int_posMedium <=   8'b00000000;
            int_posBig <=      8'b00000000;
            int_posHuge <=     8'b00000000;
            
        end        
    end /* always end */
    
    assign ptr_freq_fuzzy = int_freq_fuzzy; 
    assign ptr_input_fuzzy_set_id = int_input_fuzzy_set_id; 
    assign ptr_negGigantic = int_negGigantic; 
    assign ptr_negHuge = int_negHuge; 
    assign ptr_negBig = int_negBig; 
    assign ptr_negMedium = int_negMedium; 
    assign ptr_negSmall = int_negSmall;
	assign ptr_zero = int_zero; 
	assign ptr_posSmall = int_posSmall; 
	assign ptr_posMedium = int_posMedium;
	assign ptr_posBig = int_posBig; 
	assign ptr_posHuge = int_posHuge; 
	assign ptr_posGigantic = int_posGigantic;
endmodule
