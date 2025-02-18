// /`timescale 1ns/1ns

class mem_base_seq extends uvm_sequence;
   `uvm_object_utils(mem_base_seq)
     mem_sequencer_item reset_pkt;

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
    
    reset_pkt = mem_sequencer_item::type_id::create("reset_pkt");
   // start_item(reset_pkt);
    
    //reset_pkt.randomize() with {reset==1;};
        start_item(reset_pkt);
        reset_pkt.control_knob = mem_sequencer_item::wr_zero ; 
        reset_pkt.randomize() ; 
    finish_item(reset_pkt);

   
    
   // finish_item(reset_pkt);
        
  endtask: body
  
  
endclass: mem_base_seq

//uvm_sequencer_item

class mem_test_seq extends mem_base_seq;
  `uvm_object_utils(mem_test_seq)
  
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

    start_item(item);
    item.control_knob = mem_sequencer_item::wr_rand ; 
    item.randomize();
    finish_item(item);
       
  endtask: body



endclass //meme_sequence extends superClass