//`timescale 1ns/1ns
class mem_sequencer_item extends uvm_sequence_item;
    `uvm_object_utils(mem_sequencer_item)

  //--------------------------------------------------------
  //Instantiation
  //--------------------------------------------------------
   rand logic  read;
   rand logic  write;
   rand logic  [4:0] addr;
   rand logic  [7:0] data_in;
  
    logic [7:0] data_out; //output

  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "mem_sequencer_item");
    super.new(name);
    // seq_coverage = new();
  endfunction: new

//--------------------------------------------------------
    // Functional Coverage
    //--------------------------------------------------------
//     covergroup seq_coverage ;
//      coverpoint write;
//         coverpoint read;
//         coverpoint addr;
//         coverpoint data_in;
//         cross write, addr, data_in;

// endgroup








endclass //mem_sequencer_item extends superClass