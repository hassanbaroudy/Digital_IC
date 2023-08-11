class hassan_env extends uvm_env;
  
  virtual interface intf1 config_virtual;
  virtual interface intf1 local_virtual;
  hassan_env h_env;
  
    `uvm_component_utils(hassan_env)
  hassan_sequence_item h_seq_item;
  hassan_agent h_agent;
  hassan_scoreboard h_scoreboard;
  hassan_subscriber h_subscriber;
  
    function new(string name = "hassan_env",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase );
 	 super.build_phase(phase);
   h_seq_item = hassan_sequence_item::type_id::create("h_seq_item");
   h_agent = hassan_agent::type_id::create("h_agent",this);  
   h_scoreboard = hassan_scoreboard::type_id::create("h_scoreboard",this); 
   h_subscriber = hassan_subscriber::type_id::create("h_subscriber",this); 
    if(!uvm_config_db#(virtual intf1)::get(this,"","hassan_vif",config_virtual))
      `uvm_fatal(get_full_name(),"Error!")
   local_virtual = config_virtual;
    uvm_config_db#(virtual intf1)::set(this,"h_agent","hassan_vif",local_virtual);
   $display("build_phase_test");
   $display("build_phase_env");
  endfunction

  function void connect_phase(uvm_phase phase );
  	super.connect_phase(phase);
  	$display("connect_phase_env");
    h_agent.hassan_analysis_port.connect(h_subscriber.hassan_analysis_imp);
  endfunction

  task run_phase (uvm_phase phase );
  	super.run_phase(phase);
  	$display("run_phase_env");
  endtask
  
endclass