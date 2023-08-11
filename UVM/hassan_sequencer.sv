class hassan_sequencer extends uvm_sequencer #(hassan_sequence_item) ;
   
    `uvm_component_utils(hassan_sequencer)
  function new(string name = "hassan_sequencer",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
    function void build_phase(uvm_phase phase );
      super.build_phase(phase);
      $display("build_phase_sequencer");
    endfunction

    function void connect_phase(uvm_phase phase );
      super.connect_phase(phase);
      $display("connect_phase_sequencer");
    endfunction

    task run_phase (uvm_phase phase );
      super.run_phase(phase);
      $display("run_phase_sequencer");
    endtask
  
endclass