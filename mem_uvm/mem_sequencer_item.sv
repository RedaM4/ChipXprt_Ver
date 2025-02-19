//`timescale 1ns/1ns
class mem_sequencer_item extends uvm_sequence_item;
    `uvm_object_utils(mem_sequencer_item)

  //--------------------------------------------------------
  //Instantiation
  //--------------------------------------------------------
   logic  read;
    logic  write;
    logic  [4:0] addr;
    logic  [7:0] data_in;
  
    logic [7:0] data_out; //output


//--------------------------------------------------------
    // Functional Coverage
    //--------------------------------------------------------
    covergroup mem_coverage ;
      coverpoint write {
          bins wr_bin[] = {0, 1};  }

      coverpoint read {
        bins rd_bin[] = {0, 1};       }


    coverpoint addr {
        bins low_range = {[0:7]};    
        bins mid_range = {[8:15]};  
        bins high_range = {[16:31]}; 
    }

    coverpoint data_in{  
      bins zero = {0};  
      bins random_range = {[1:25]};}

      
   // cross write, addr,data_in;  
   // cross read, addr;


endgroup




  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "mem_sequencer_item");
    super.new(name);
    mem_coverage = new();
  endfunction: new



  //--------------------------------------------------------
    // Sample Coverage
    //--------------------------------------------------------
    task sample_coverage();
        mem_coverage.sample();
    endtask



endclass //mem_sequencer_item extends superClass