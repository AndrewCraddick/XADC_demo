`timescale 1ns / 1ps

module top_XADC(

input wire clock, // 100MHz
output wire [3:0] anode,                                                            
output wire [7:0] cathode,
input wire vauxp6,
input wire vauxn6
);

wire clk50MHz;                                                                  
wire refresh_clock;                                                                 
wire counter_clock; 
wire [11:0] twelve_bit_counter_value;                                                 
wire [3:0] ones;                                                                    
wire [3:0] tens;                                                                    
wire [3:0] hundreds;
wire [3:0] thousands;

wire [15 : 0] di_in;     
wire [6 : 0] daddr_in;
wire den_in;  
wire dwe_in;               
wire drdy_out;          
wire [15 : 0] do_out;   
//wire dclk_in,            
wire vp_in;              
wire vn_in;              
wire vauxp6;             
wire vauxn6;             
wire [4 : 0] channel_out;
wire eoc_out;           
wire alarm_out;         
wire eos_out;           
wire busy_out;
                                                               
                                                                                    
                                                                                    
//----------- Module Connections (Instantiations)  --------------------------                     
clock_divider #(4999) refreshclock_generator (  // #(number) overwrites global 'parameter' in clock_divider                            
.clock              ( clock                   ),                                   
.divided_clock      ( refresh_clock           ) // refresh_clock is 10kHz clock                        
);                                                                                   
                                                                                    
clock_divider #(0) XADC_clock_generator (                                   
.clock              ( clock                   ),                                      
.divided_clock      ( clk50MHz                 ) // counter_clock is 50MHz clock                         
);                                                                                 

XADC_clock_gen XADC_inst (
.di_in (di_in),      
.daddr_in (daddr_in),    
.den_in (den_in),              
.dwe_in (dwe_in),              
.drdy_out (drdy_out),           
.do_out (do_out),    
.dclk_in (clk50MHz),             
.vp_in (vp_in),              
.vn_in (vn_in),              
.vauxp6 (vauxp6),             
.vauxn6 (vauxn6),             
.channel_out (channel_out),
.eoc_out (eoc_out),            
.alarm_out (alarm_out),          
.eos_out  (eos_out),            
.busy_out (busy_out)           
);
                                                                                    
twelve_bit_Binary_to_BCD Convert_Binary_to_BCD (                                               
.clock              ( clock                   ),                                    
.twelve_bit_value   ( do_out [15:4]           ), // [7:0] value to display          
.ones               ( ones                    ), // [3:0]...                        
.tens               ( tens                    ),                                    
.hundreds           ( hundreds                ),
.thousands          ( thousands               )  // ... [3:0]                       
);                                                                                  

seven_seg_controller SSD_Controller (
.refresh_clock      ( refresh_clock           ),
.Ones               ( ones                    ),
.Tens               ( tens                    ),
.Hundreds           ( hundreds                ),
.anode              ( anode                   ),
.cathode            ( cathode                 )
);

       



endmodule
