// /`timescale 1ns/1ns

class mem_test_seq extends uvm_sequence #(mem_sequencer_item);
   `uvm_object_utils(mem_test_seq)
   //  mem_sequencer_item reset_pkt;
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
    `uvm_info("TEST_SEQ", "Inside body task!", UVM_LOW)
    
    item = mem_sequencer_item::type_id::create("item");

    start_item(item);

     item.sample_coverage();
    finish_item(item);
       
  endtask: body


  
endclass: mem_test_seq

//uvm_sequencer_item

// class mem_test_seq extends mem_base_seq;
//   `uvm_object_utils(mem_test_seq)
  
//   mem_sequencer_item item;
  
//   //--------------------------------------------------------
//   //Constructor
//   //--------------------------------------------------------
//   function new(string name= "mem_test_seq");
//     super.new(name);
//     `uvm_info("TEST_SEQ", "Inside Constructor!", UVM_HIGH)
//   endfunction



//   //--------------------------------------------------------
//   //Body Task
//   //--------------------------------------------------------
//   task body();
//     `uvm_info("TEST_SEQ", "Inside body task!", UVM_LOW)
    
//     item = mem_sequencer_item::type_id::create("item");

//     start_item(item);

//      item.sample_coverage();
//     finish_item(item);
       
//   endtask: body
// //


// endclass //meme_sequence extends superClass