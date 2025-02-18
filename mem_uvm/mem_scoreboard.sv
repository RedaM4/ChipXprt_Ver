//`timescale 1ns/1ns

class mem_scoreboard extends uvm_test;
    `uvm_component_utils(mem_scoreboard)
    
    uvm_analysis_imp #(mem_sequencer_item,mem_scoreboard) scoreboard_port;
    mem_sequencer_item transactions[$];
   mem_sequencer_item curr_trans;
   int mem[8] ; 
  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "mem_scoreboard", uvm_component parent);
    super.new(name, parent);
    `uvm_info("SCB_CLASS", "Inside Constructor!", UVM_HIGH)
  endfunction: new
  
  
  //--------------------------------------------------------
  //Build Phase
  //--------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("SCB_CLASS", "Build Phase!", UVM_HIGH)
   
    scoreboard_port = new("scoreboard_port", this);
    
  endfunction: build_phase
  
  
  //--------------------------------------------------------
  //Connect Phase
  //--------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("SCB_CLASS", "Connect Phase!", UVM_HIGH)
    
   
  endfunction: connect_phase
  
  
  //--------------------------------------------------------
  //Write Method
  //--------------------------------------------------------
  function void write(mem_sequencer_item item);
    transactions.push_back(item);
  endfunction: write 
  
  
  //--------------------------------------------------------
  //Run Phase
  //--------------------------------------------------------
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("SCB_CLASS", "Run Phase!", UVM_HIGH)
   // mem_sequencer_item curr_trans;
   
    forever begin
        
      if (curr_trans.write) begin
        mem[curr_trans.addr]=curr_trans.data_in ; 
      end


     
      wait((transactions.size() != 0));
      curr_trans = transactions.pop_front();
      compare(curr_trans);
      
    end

  endtask:run_phase
    

task  compare(mem_sequencer_item curr_trans);
     if (curr_trans.data_out == mem[curr_trans.addr]) begin
        $display("[SCOREBOARD] ✅ PASS -> Data Matched:" );
        $display("  Expected -> data_out = %d,address:%d",mem[curr_trans.addr],curr_trans.addr);
        $display("  Actual   -> data_out = %d,address:%d", curr_trans.data_out,curr_trans.addr);
    end else begin
      $display("[SCOREBOARD] ❌ ERROR -> Mismatch!");
      $display("  Expected -> data_out = %d,address:%d",mem[curr_trans.addr],curr_trans.addr);
      $display("  Actual   -> data_out = %d,address:%d", curr_trans.data_out,curr_trans.addr);
    end
    
     


endtask : compare

  









  
endclass //scoreboard extends uvm_scorboard