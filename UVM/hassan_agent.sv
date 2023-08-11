class hassan_agent extends uvm_agent;
  
  virtual interface intf1 config_virtual;
  virtual interface intf1 local_virtual;
    
  `uvm_component_utils(hassan_agent)
  uvm_analysis_port#(hassan_sequence_item) hassan_analysis_port;
  hassan_driver h_driver;
  hassan_monitor h_monitor;
  hassan_sequencer h_sequencer;

  function new(string name = "hassan_agent",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase );
    super.build_phase(phase);
   h_driver = hassan_driver::type_id::create("h_driver",this); 
   h_monitor = hassan_monitor::type_id::create("h_monitor",this); 
   h_sequencer = hassan_sequencer::type_id::create("h_sequencer",this);
   if(!uvm_config_db#(virtual intf1)::get(this,"","hassan_vif",config_virtual))
      `uvm_fatal(get_full_name(),"Error!")
   local_virtual = config_virtual;
    uvm_config_db#(virtual intf1)::set(this,"h_driver","hassan_vif",local_virtual);
    uvm_config_db#(virtual intf1)::set(this,"h_monitor","hassan_vif",local_virtual);
    
   $display("build_phase_test");
   $display("build_phase_env");
   $display("build_phase_agent");
    
    hassan_analysis_port = new("hassan_analysis_port",this);
    
  endfunction

  function void connect_phase(uvm_phase phase );
    super.connect_phase(phase);
    $display("connect_phase_agent");
     
    h_monitor.hassan_analysis_port.connect(this.hassan_analysis_port);
    $display("connection of analysis ports between monitor and agent");
    
    h_driver.seq_item_port.connect(h_sequencer.seq_item_export);

  endfunction

  task run_phase (uvm_phase phase );
    super.run_phase(phase);
    $display("run_phase_agent");
  endtask
endclass