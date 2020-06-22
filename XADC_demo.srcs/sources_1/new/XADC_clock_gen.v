`timescale 1ns / 1ps

module XADC_clock_gen(
// ------------ XADC CONNECTIONS ---------------

input wire [15 : 0] di_in,     
input wire [6 : 0] daddr_in,
input wire den_in,  
input wire dwe_in,               
output wire drdy_out,          
output wire [15 : 0] do_out,   
input wire dclk_in,            
input wire vp_in,              
input wire vn_in,              
input wire vauxp6,             
input wire vauxn6,             
output wire [4 : 0] channel_out,
output wire eoc_out,           
output wire alarm_out,         
output wire eos_out,           
output wire busy_out          

);
    



// ---------- XADC Instantiation from Wizard ---------------------
xadc_wiz_0 XADC_inst (
.di_in            ( 16'b0              ), // This is the clock for writing in the control register, we aren't writing so we make it zero constantly
.daddr_in         ( {2'b00,channel_out}), // ddadr configures channel_out
.den_in           ( eoc_out            ), // input wire den_in
.dwe_in           ( 1'b0               ), // input wire dwe_in
.drdy_out         ( drdy_out           ), // analog Data ready signal
.do_out           ( do_out             ), // output wire [15 : 0] do_out
.dclk_in          ( dclk_in            ), // input wire dclk_in
.vp_in            ( vp_in              ), // not used
.vn_in            ( vn_in              ), // not used
.vauxp6           ( vauxp6             ), // input wire vauxp6, instantiating Vaux6 as selected by channel_out
.vauxn6           ( vauxn6             ), // input wire vauxn6
.channel_out      ( channel_out        ), // selects ADC channel corresponding to Vaux6
.eoc_out          ( eoc_out            ), // output wire eoc_out
.alarm_out        ( alarm_out          ), // not used
.eos_out          ( eos_out            ), // output wire eos_out
.busy_out         ( busy_out           )  // output wire busy_out
);

endmodule
