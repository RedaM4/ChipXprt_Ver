// /`timescale 1ns/1ns


class mem_base_seq extends uvm_sequence;
  `uvm_object_utils(mem_base_seq)
  
  mem_sequencer_item base_seq;
  
  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name= "mem_base_seq");
    super.new(name);
    `uvm_info("BASE_SEQ", "Inside Constructor!", UVM_HIGH)
  endfunction
  
  
  //--------------------------------------------------------
  //Body Task
  //--------------------------------------------------------
  task body();
    `uvm_info("BASE_SEQ", "Inside body task!", UVM_HIGH)
    
    base_seq = mem_sequencer_item::type_id::create("base_seq");
   
  
    for (int i =0 ;i<32 ;i++ ) begin
      start_item(base_seq);
     
        base_seq.addr = i; 
        base_seq.data_in = i;
        base_seq.read = 0;
        base_seq.write = 1;

finish_item(base_seq);
// #10;
  end
// just for testing
    for (int i =0 ;i<32 ;i++ ) begin

          start_item(base_seq);
    base_seq.addr = i; 
        base_seq.data_in = 0;
        base_seq.read = 1;
        base_seq.write = 0;

finish_item(base_seq);
    end
        
  endtask: body
  
  
endclass: mem_base_seq




class mem_test_seq extends mem_base_seq ;
   `uvm_object_utils(mem_test_seq)
   //  mem_sequencer_item base_seq;
  mem_sequencer_item item;

  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
 function new(string name= "mem_test_seq");
    super.new(name);
    `uvm_info("TEST_SEQ", "Inside Constructor!", UVM_HIGH)
  endfunction



  //--------------------------------------------------------
  //Body Task
  //--------------------------------------------------------
  task body();
    `uvm_info("TEST_SEQ", "Inside body task!", UVM_HIGH)
    
    item = mem_sequencer_item::type_id::create("item");

      for (int i =0 ;i<32 ;i++ ) begin
          start_item(item);
        
            item.addr = i; 
            item.data_in = 0;
            item.read = 0;
            item.write = 1;

    finish_item(item);
    // #10;
      end



    repeat(10000)begin
    start_item(item);
    item.randomize();
     //item. seq_coverage.sample();
    //   item.read = 0;
    // item.write = 1;
       $display("[mem_seq]  Actual   -> ---------, address = %0d | Write = %0b | Read = %0b | data_in : %0d\n", 
              item.addr, item.write, item.read, item.data_in);
  

     finish_item(item);
       end

//  for (int i =0 ;i<32 ;i++ ) begin

//           start_item(item);
//     item.addr = i; 
//         item.data_in = 0;
//         item.read = 1;
//         item.write = 0;

// finish_item(item);
//     end

  endtask: body


  
endclass: mem_test_seq
