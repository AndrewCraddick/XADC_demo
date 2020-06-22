`timescale 1ns / 1ps


module top_XADC_tb(

);

wire [15 : 0] di_in;
wire [6 : 0] daddr_in;
wire den_in;
wire dwe_in;
wire drdy_out;
wire [15 : 0] do_out;
reg dclk_in;
wire vp_in;
wire vn_in;
wire vauxp6;
wire vauxn6;
wire [4 : 0] channel_out;
wire eoc_out;
wire alarm_out;
wire eos_out;
wire busy_out;

initial  begin
    dclk_in = 1'b0;
    forever #10 dclk_in = ~dclk_in;
end 


top_XADC UUT (
  .di_in(16'b0),              // input wire [15 : 0] di_in
  .daddr_in({2'b00,channel_out}), // input wire [6 : 0] daddr_in
  .den_in(eoc_out),            // input wire den_in
  .dwe_in(1'b0),            // input wire dwe_in
  .drdy_out(drdy_out),        // output wire drdy_out
  .do_out(do_out),            // output wire [15 : 0] do_out
  .dclk_in(dclk_in),          // input wire dclk_in
  .vp_in(vp_in),              // input wire vp_in
  .vn_in(vn_in),              // input wire vn_in
  .vauxp6(vauxp6),            // input wire vauxp6
  .vauxn6(vauxn6),            // input wire vauxn6
  .channel_out(channel_out),  // output wire [4 : 0] channel_out
  .eoc_out(eoc_out),          // output wire eoc_out
  .alarm_out(alarm_out),      // output wire alarm_out
  .eos_out(eos_out),          // output wire eos_out
  .busy_out(busy_out)        // output wire busy_out
);

   
endmodule
