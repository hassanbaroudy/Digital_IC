class hassan_sequence_item extends uvm_sequence_item;
  `uvm_object_utils(hassan_sequence_item)
  function new(string name = "hassan_sequence_item");
    super.new(name);
  endfunction
  
  /*rand logic [3:0] a;
  rand logic [3:0] b;
  logic [4:0] c;*/
  
  randc logic [3:0] address;
  rand logic [31:0] data_in;
  logic [31:0] data_out;
  rand logic op;
  rand logic en;
  rand logic rst;
  logic valid_out;
  
endclass