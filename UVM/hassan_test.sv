class hassan_test extends uvm_test;
  
  virtual interface intf1 config_virtual;
  virtual interface intf1 local_virtual;
    
  `uvm_component_utils(hassan_test)
    hassan_env h_env;
    hassan_sequence h_sequence;
  function new(string name = "hassan_test",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase );
  	super.build_phase(phase);
    h_env = hassan_env::type_id::create("h_env",this);
    h_sequence = hassan_sequence::type_id::create("h_sequence");
    if(!uvm_config_db#(virtual intf1)::get(this,"","hassan_vif",config_virtual))
      `uvm_fatal(get_full_name(),"Error!")
    local_virtual = config_virtual;
    uvm_config_db#(virtual intf1)::set(this,"h_env","hassan_vif",local_virtual);
  	$display("build_phase_test");
  endfunction

  function void connect_phase(uvm_phase phase );
  	super.connect_phase(phase);
  	$display("connect_phase_test");
  endfunction

  task run_phase (uvm_phase phase );
  	super.run_phase(phase);
  	$display("run_phase_test");
    
    phase.raise_objection(this);
    h_sequence.start(h_env.h_agent.h_sequencer); 
	phase.drop_objection(this);
  endtask
endclass