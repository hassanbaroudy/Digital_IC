class hassan_scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(hassan_scoreboard)
  uvm_tlm_analysis_fifo#(hassan_sequence_item) hassan_analysis_fifo;
  uvm_analysis_export#(hassan_sequence_item) hassan_analysis_export;
  hassan_sequence_item transaction;
  logic [31:0] memory_array [15:0];
  
  function new(string name = "hassan_scoreboard",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase );
  super.build_phase(phase);
  $display("build_phase_scoreboard");
    hassan_analysis_fifo =new("hassan_analysis_fifo",this);
    hassan_analysis_export =new("hassan_analysis_export",this);
  endfunction

  function void connect_phase(uvm_phase phase );
  super.connect_phase(phase);
  $display("connect_phase_scoreboard");
    hassan_analysis_export.connect(this.hassan_analysis_fifo.analysis_export);
  endfunction

  task run_phase (uvm_phase phase );
  super.run_phase(phase);
  $display("run_phase_scoreboard");
    hassan_analysis_fifo.get_peek_export.get(transaction);
    
    
  endtask
  
endclass






