`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 06/07/2019 03:40:23 PM
//////////////////////////////////////////////////////////////////////////////////


module top(
    input clk,
    input [7:0] bcd,
    output [7:0] duty
    );
    
    /* Digitized input frequency */
    wire [7:0] digital_freq;
    
    /* Input fuzzy frequency */
    wire [7:0] ptr_freq_fuzzy; 
    wire [7:0] ptr_input_fuzzy_set_id; 
    
    /* Input fuzzy sets */
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
    
    wire [7:0] output_fuzzy_set_id;
    wire [7:0] pwm_duty_cycle;
    
    reg process_control = 2'b00;
    
    /* 1. Digitize the BCD value that is received from the ADC */
    digitization digitization(
    .clk(clk),
    .input_bit(bcd),
    .freq(digital_freq)
    );
    
    /* 2. Fuzzify the input frequency */
    fuzzification fuzzification(
        .clk(clk),
        .freq_crisp(digital_freq),
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
    
    /* 3. Infer the output membership function based on the input membership function */
    rulebase inference_engine(
        .clk(clk),
        .input_fuzzy_set_id(ptr_input_fuzzy_set_id),
        .output_fuzzy_set_id(output_fuzzy_set_id)
    );
    
    /* 4. Defuzzify the fuzzy values into a crisp output */
    defuzzification defuzzification(
        .clk(clk),
        .output_fuzzy_set_id(output_fuzzy_set_id),
        .pwm_duty(pwm_duty_cycle)
    );
    
    assign duty = pwm_duty_cycle;
    
endmodule
