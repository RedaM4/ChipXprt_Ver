class my_sequence extends uvm_sequence #(sequence_item);
     `uvm_object_utils(my_sequence)
sequence_item item ; 
function new(string name= "my_sequence");
    super.new(name);
    `uvm_info("SEQ", "Inside Constructor!", UVM_HIGH)
  endfunction

 task body();
    `uvm_info("SEQ", "Inside body task!", UVM_HIGH)
    
    item = sequence_item::type_id::create("item");
   

      start_item(item);
    //    if(!item.randomize())
    //    `uvm_error("ERROR","item randomaize error") ; 


       item.randomize();
     finish_item(item);

        
  endtask: body
endclass //sequence extends superClass