class hassan_sequence extends uvm_sequence;
  
  `uvm_object_utils(hassan_sequence)
  hassan_sequence_item h_sequence_item;
  
  function new (string name="hassan_sequence");       //construction
	super.new(name);
  endfunction
  
  task pre_body;
    h_sequence_item = hassan_sequence_item::type_id::create("h_sequence_item");
  endtask
  
  task body;
     begin
    	start_item(h_sequence_item);
       void' (h_sequence_item.randomize()with{rst == 1;}) ;
      //$display(h_sequence_item.a,h_sequence_item.b);
    	finish_item(h_sequence_item);
    end
    repeat(16)
    begin
    	start_item(h_sequence_item);
      void' (h_sequence_item.randomize()with{en == 1;op ==1;rst == 0;}) ;
      //$display(h_sequence_item.a,h_sequence_item.b);
    	finish_item(h_sequence_item);
    end
    
    repeat(16)
    begin
    	start_item(h_sequence_item);
      void' (h_sequence_item.randomize()with{en == 1;op ==0;rst ==0;}) ;
      //$display(h_sequence_item.a,h_sequence_item.b);
    	finish_item(h_sequence_item);
    end
  endtask
  
endclass