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
        for (int i = 0; i < 32; i++) begin
          mem[i] = 0; 
      end

   
   curr_trans = new ; 
    forever begin
        
     
      wait((transactions.size() != 0));
      curr_trans = transactions.pop_front();

        if (curr_trans.write ==1) begin
                mem[curr_trans.addr]=curr_trans.data_in ; 
              end
  if ( curr_trans.read ==1) begin
          compare(curr_trans);
  end
      
    end

  endtask:run_phase
    

task  compare(mem_sequencer_item curr_trans);
     if (curr_trans.data_out == mem[curr_trans.addr]  ) begin
        $display("[SCOREBOARD] ✅ PASS -> Data Matched:" );
        // $display("  Expected -> data_out = %0d,address:%0d",mem[curr_trans.addr],curr_trans.addr);
        // $display("  Actual   -> data_out = %0d,address:%0d", curr_trans.data_out,curr_trans.addr);
    end else begin
      $display("[SCOREBOARD] ❌ ERROR -> Mismatch!");
      // $display("  Expected -> data_out = %0d,address:%0d",mem[curr_trans.addr],curr_trans.addr);
      // $display("  Actual   -> data_out = %0d,address:%0d", curr_trans.data_out,curr_trans.addr);
      show() ; 
    end
    
     


endtask : compare

  task  show();
    $display("[SCOREBOARD]  Expected -> data_out = %0d, address = %0d | Write = %0b | Read = %0b", 
              mem[curr_trans.addr], curr_trans.addr, curr_trans.write, curr_trans.read);
    $display("[SCOREBOARD]  Actual   -> data_out = %0d, address = %0d | Write = %0b | Read = %0b | data_in : %0d\n", 
              curr_trans.data_out, curr_trans.addr, curr_trans.write, curr_trans.read,curr_trans.data_in);



  endtask //









  
endclass //scoreboard extends uvm_scorboard