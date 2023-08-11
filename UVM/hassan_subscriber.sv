class hassan_subscriber extends uvm_subscriber #(hassan_sequence_item) ;
  
  `uvm_component_utils(hassan_subscriber)
  hassan_sequence_item h_seq_item_sub;
  uvm_analysis_imp#(hassan_sequence_item,hassan_subscriber) hassan_analysis_imp;
 
covergroup hassan_group;
    RESET:   coverpoint h_seq_item_sub.rst; //{bins rst[] ={0,1}; } 
    ENABLE : coverpoint h_seq_item_sub.en; //{bins en[] ={0,1};}
    OPERTION:coverpoint h_seq_item_sub.op; //{bins op[] ={0,1}; } 
    VALID:   coverpoint h_seq_item_sub.valid_out; //{bins valid_out[] ={0,1}; }
    ADDRESS: coverpoint h_seq_item_sub.address; //{bins address[] ={[0:15]}; }
    DATA_IN: coverpoint h_seq_item_sub.data_in;
    DATA_OUT:coverpoint h_seq_item_sub.data_out;
  endgroup
  
  function new(string name = "hassan_subscriber",uvm_component parent = null);
    super.new(name,parent);
    hassan_group =new();
  endfunction
  
  function void build_phase(uvm_phase phase );
  	super.build_phase(phase);
  	$display("build_phase_subscriber");
    
    hassan_analysis_imp = new("hassan_analysis_imp",this);
  endfunction

  function void connect_phase(uvm_phase phase );
  	super.connect_phase(phase);
  	$display("connect_phase_subscriber");
  endfunction

  function void write(hassan_sequence_item t);
    $display("write function in the subscriber");
    this.h_seq_item_sub = t;
    hassan_group.sample(); 
  endfunction
  
  task run_phase (uvm_phase phase );
  	super.run_phase(phase);
    $display("run_phase_subscriber");
  endtask
  

endclass