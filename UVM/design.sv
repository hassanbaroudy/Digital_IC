// Code your design here
/*module adder(
  input logic [3:0] a,
  input logic [3:0] b,
  input logic clk,
  output logic [4:0] c
);
  
  always @(posedge clk)
    begin
      c <=a+b;
      
    end
  
endmodule */

module MemoryModule (
  input logic [3:0] address,
  input logic [31:0] data_in,
  output logic [31:0] data_out,
  input logic op,
  input logic en,
  input logic clk,
  input logic rst,
  output logic valid_out);
  
  // Define internal memory array
  logic [31:0] memory [15:0];

  // Registers for data and valid output
  logic [31:0] data_reg;
  logic valid_reg;

  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      data_reg  <= 0;
      valid_reg <= 0;
    end else if (en) begin
      // Read or write operation based on operation bit
      if (op == 1'b1) begin
        // Write operation
        if (address >= 0 && address <= 15)
          memory[address] <= data_in;
      end else begin
        // Read operation
        if (address >= 0 && address <= 15) begin
          data_reg <= memory[address];
          valid_reg <= 1;
        end
      end
    end
  end
  // Assign data_out and valid_out outputs
  assign data_out = data_reg;
  assign valid_out = valid_reg;
endmodule