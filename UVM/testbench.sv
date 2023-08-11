// Code your testbench here
// or browse Examples
`include "hassan_package.sv"  

interface intf1(input logic clk);  
   logic  en; 	
   logic [3:0]  address;
   logic [31:0]  data_in;
   logic [31:0]  data_out;
   logic op;
   logic rst;
   logic  valid_out;
endinterface

module top;
  
  `include "design.sv"
  import uvm_pkg::*; //why I imported it again?
  import pack1::*;
  logic clk;
  
  intf1 interface_1(clk);
  
    MemoryModule DUT(
    .address(interface_1.address),  
    .data_in(interface_1.data_in),
    .data_out(interface_1.data_out),
    .op(interface_1.op),
    .en(interface_1.en),
    .clk(interface_1.clk),
    .rst(interface_1.rst),
    .valid_out(interface_1.valid_out)
  );
  
  initial
    begin
      $dumpfile("dump.vcd"); 
      $dumpvars;
    end
  initial
    begin
      clk=1;
    end
  initial
    begin
      uvm_config_db #(virtual intf1)::set(null,"uvm_test_top","hassan_vif",interface_1);
      run_test("hassan_test");
    end 
    always	#5 clk = ~clk;
   	
    

endmodule
