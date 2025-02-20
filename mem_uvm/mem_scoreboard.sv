//`timescale 1ns/1ns

class mem_scoreboard extends uvm_test;
    `uvm_component_utils(mem_scoreboard)
    
    uvm_analysis_imp #(mem_sequencer_item,mem_scoreboard) scoreboard_port;
    mem_sequencer_item transactions[$];
   mem_sequencer_item curr_trans;
   int mem[32] ; 
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
  //  mem_sequencer_item curr_trans;

      //   for (int i = 0; i < 32; i++) begin
      //     mem[i] = 0; 
      // end

   
   curr_trans = new ; 
    forever begin
        
     
      wait((transactions.size() != 0));
      curr_trans = transactions.pop_front();
      `uvm_info("SCOREBOARD", "Receiving !", UVM_LOW)
      $display("[SCOREBOARD]  Actual   -> data_out = %0d, address = %0d | Write = %0b | Read = %0b | data_in : %0d\n", 
              curr_trans.data_out, curr_trans.addr, curr_trans.write, curr_trans.read,curr_trans.data_in);      
       

        if (curr_trans.write ==1 && curr_trans.read ==1) begin
           `uvm_info("SCB_CLASS", "read and write so (ignore)", UVM_HIGH)
        end else

        if (curr_trans.write ==1) begin
          `uvm_info("SCB_CLASS", "add to the array", UVM_HIGH)
                mem[curr_trans.addr]=curr_trans.data_in ; 
                `uvm_info("SCB_WRITING", " receiving read !", UVM_LOW)
              end

        else if ( curr_trans.read ==1) begin
                compare();
                `uvm_info("SCB_READING", " receiving read !", UVM_LOW)
        end // `uvm_info("SCB_IDLE", " receiving read !", UVM_LOW)
   
      


    

    end

  endtask:run_phase
    

task  compare( );
     if (curr_trans.data_out == mem[curr_trans.addr]  ) begin
  `uvm_info("COMPARE", $sformatf("✅Transaction Passed! ACT=%0d, EXP=%0d", curr_trans.data_out , mem[curr_trans.addr]), UVM_HIGH)        
       
    end else begin
     `uvm_error("COMPARE", $sformatf("🔴Transaction failed! ACT=%0d, EXP=%0d", curr_trans.data_out , mem[curr_trans.addr]))
           
      // $display("  Expected -> data_out = %0d,address:%0d",mem[curr_trans.addr],curr_trans.addr);
      // $display("  Actual   -> data_out = %0d,address:%0d", curr_trans.data_out,curr_trans.addr);
      //show() ; 
    end
    
     
endtask : compare

  task  show();
    $display("[SCOREBOARD]  Expected -> data_out = %0d, address = %0d | Write = %0b | Read = %0b", 
              mem[curr_trans.addr], curr_trans.addr, curr_trans.write, curr_trans.read);
    $display("[SCOREBOARD]  Actual   -> data_out = %0d, address = %0d | Write = %0b | Read = %0b | data_in : %0d\n", 
              curr_trans.data_out, curr_trans.addr, curr_trans.write, curr_trans.read,curr_trans.data_in);



  endtask //












  
endclass //scoreboard extends uvm_scorboard