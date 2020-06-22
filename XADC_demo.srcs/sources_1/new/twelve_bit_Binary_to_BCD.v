`timescale 1ns / 1ps

module twelve_bit_Binary_to_BCD(
  input clock,
  input [11:0] twelve_bit_value,

  output reg [3:0] ones = 0,
  output reg [3:0] tens = 0,
  output reg [3:0] hundreds = 0,
  output reg [3:0] thousands = 0
  );

//----------------- INITIALIZING PORT DATA VALUES --------------------
reg [3:0] i = 0;
reg [27:0] shift_register = 0;
/* temporary registers that keep output values unchanged
   until final BCD value is ready */
reg [3:0] temp_ones = 0;
reg [3:0] temp_tens = 0;
reg [3:0] temp_hundreds = 0;
reg [3:0] temp_thousands = 0;
// store [7:0] 8-bit value here until [7:0] 8-bit value changes
reg[11:0] OLD_twelve_bit_value = 0;

// ----------- BCD CONVERSION PROCESS ---------------------------
always @(posedge clock)
begin
// Enter 'if' statement if eight_bit_value CHANGES, checked using != operator
   if (i == 0 & (OLD_twelve_bit_value != twelve_bit_value)) begin
   /* != is logical INEQUALITY, returns true (1) if OLD 8-bit value
      does NOT equal 8-bit value, false (0) otherwise */
      shift_register = 27'b0; // initialize shift register to 0
      // assign the current eight_bit_value to the OLD_eight_bit_value
      OLD_twelve_bit_value = twelve_bit_value;
      // put 8-bit counter value into bottom 8 bits of the shift register
      shift_register [11:0] = twelve_bit_value;
      // define the temporary registers as part of the shift_register
      temp_ones = shift_register[15:12];
      temp_tens = shift_register[19:16];
      temp_hundreds = shift_register[23:20];
      temp_thousands = shift_register[27:24];
      // begin the conversion process leading to next 'if' statement
      i = i+1;      
   end
   if (i<13 & i>0) begin
      // check if temporary ones, tens or hundreds are greater than or equal to 5
      if (temp_ones >= 5) temp_ones = temp_ones + 3;
      if (temp_tens >= 5) temp_tens = temp_tens + 3;
      if (temp_hundreds >= 5) temp_hundreds = temp_hundreds + 3;
      if (temp_thousands >= 5) temp_thousands = temp_thousands + 3;
      // put ones, tens and hundreds into shift register (top 12 bits)
      shift_register [23:12] = {temp_thousands, temp_hundreds, temp_tens, temp_ones};
      // then shift left by 1
      shift_register = shift_register << 1;
      // now set the new values to temporary hundreds, tens and ones again
      temp_ones = shift_register[15:12];
      temp_tens = shift_register[19:16];
      temp_hundreds = shift_register[23:20];
      temp_thousands = shift_register[27:24];
      i = i + 1;
   end
   if (i == 13) begin
      i = 0; // reset i to zero
      // assign temporary values to the actual outputs after BCD conversion done
      ones = temp_ones;
      tens = temp_tens;
      hundreds = temp_hundreds;
      thousands = temp_thousands;
      shift_register [27:12] = 0;
   end
// Remember: all = signs means these steps execute sequentially in time     
end    
endmodule