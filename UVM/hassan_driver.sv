class hassan_driver extends uvm_driver #(hassan_sequence_item) ;
  
  virtual interface intf1 config_virtual;
  hassan_sequence_item h_sequence_item;
  `uvm_component_utils(hassan_driver)
  function new(string name = "hassan_driver",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase );
   super.build_phase(phase);
   if(!uvm_config_db#(virtual intf1)::get(this,"","hassan_vif",config_virtual))
     `uvm_fatal(get_full_name(),"Error!")
   $display("build_phase_driver");
  endfunction

  function void connect_phase(uvm_phase phase );
   super.connect_phase(phase);
   $display("connect_phase_driver");
  endfunction

  task run_phase (uvm_phase phase );
   super.run_phase(phase);
   $display("run_phase_driver");
    forever begin 
      seq_item_port.get_next_item(h_sequence_item);
       @(posedge config_virtual.clk);
				config_virtual.rst <= h_sequence_item.rst;                                     		   config_virtual.address <= h_sequence_item.address;

      if(h_sequence_item.en == 1 && h_sequence_item.op == 1) begin
     		   	config_virtual.op <= h_sequence_item.op;                    		     	config_virtual.en <= h_sequence_item.en;
      		    config_virtual.data_in <= h_sequence_item.data_in;
      end
      else if(h_sequence_item.en == 1 && h_sequence_item.op == 0) begin
        	   	config_virtual.op <= h_sequence_item.op;                    		     	config_virtual.en <= h_sequence_item.en;
      end
      #1 seq_item_port.item_done();
    end
  endtask




endclass