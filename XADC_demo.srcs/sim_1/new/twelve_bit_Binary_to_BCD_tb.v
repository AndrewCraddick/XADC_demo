`timescale 1ns / 1ps

module twelve_bit_Binary_to_BCD_tb();

reg clock = 0;
reg [11:0] twelve_bit_value;
wire [3:0] ones;
wire [3:0] tens;
wire [3:0] hundreds;
wire [3:0] thousands;

twelve_bit_Binary_to_BCD UUT (clock, twelve_bit_value, ones, tens, hundreds, thousands);

always #1 clock = ~clock;
initial begin
   twelve_bit_value = 0;
   # 25 twelve_bit_value = 10;
   # 300 twelve_bit_value = 248;
   # 300 twelve_bit_value = 1139;
end

endmodule
