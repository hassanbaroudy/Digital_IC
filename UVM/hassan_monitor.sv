class hassan_monitor extends uvm_monitor;
    
  virtual interface intf1 config_virtual;
  
  `uvm_component_utils(hassan_monitor)
  uvm_analysis_port#(hassan_sequence_item) hassan_analysis_port;
  hassan_sequence_item transaction;
  function new(string name = "hassan_monitor",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase );
    super.build_phase(phase);
    if(!uvm_config_db#(virtual intf1)::get(this,"","hassan_vif",config_virtual))
     `uvm_fatal(get_full_name(),"Error!")
    hassan_analysis_port = new("hassan_analysis_port",this);
    transaction = new("transaction");

    $display("build_phase_monitor");
  endfunction

  function void connect_phase(uvm_phase phase );
    super.connect_phase(phase);
    $display("connect_phase_monitor");
  endfunction

  task run_phase (uvm_phase phase );
    super.run_phase(phase);
    $display("run_phase_monitor");
   forever
    begin
      @(posedge config_virtual.clk);
     	 transaction.data_out = config_virtual.data_out;
      	 transaction.valid_out = config_virtual.valid_out;
         hassan_analysis_port.write(transaction);
      $display( transaction.data_out,transaction.valid_out);
    end
   
   // hassan_analysis_port.write(transaction);
  endtask
  
endclass