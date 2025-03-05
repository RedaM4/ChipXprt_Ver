//`timescale 1ns/1ns

class scoreboard  extends uvm_scoreboard;
     `uvm_component_utils(scoreboard)

uvm_analysis_imp #(sequence_item,scoreboard) scoreboard_port;
    sequence_item transactions[$];
//  virtual dut_if vif ; 
 sequence_item actual ; 
 
 //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
    `uvm_info("SCB", "Inside Constructor!", UVM_HIGH)
  endfunction: new
  
  
  //--------------------------------------------------------
  //Build Phase
  //--------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("SCB", "Build Phase!", UVM_HIGH)
        scoreboard_port = new("scoreboard_port", this);

    // if(!(uvm_config_db #(virtual dut_if)::get(this, "", "vif", vif))) begin
    //   `uvm_error("SCB", "Failed to get VIF from config DB!")
    // end
    
  endfunction: build_phase
  
  
  //--------------------------------------------------------
  //Connect Phase
  //--------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("SCB", "Connect Phase!", UVM_HIGH)
        // scoreboard_port = new("scoreboard_port", this);

  endfunction: connect_phase
  
  
  //--------------------------------------------------------
  //Write Method
  //--------------------------------------------------------
  function void write(sequence_item item);
    transactions.push_back(item);
  endfunction: write 
  
  
  //--------------------------------------------------------
  //Run Phase
  //--------------------------------------------------------
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("SCB", "Inside Run Phase!", UVM_HIGH)
   // clear();
    forever begin
    
 wait((transactions.size() != 0));
      actual = transactions.pop_front();

//expected.sum = actual.a + actual.b ; 


  `uvm_info("SCB", $sformatf(" a= %d, b= %d, sum= %d, expected=%d", 
                                       actual.a, actual.b, actual.sum, actual.a + actual.b), UVM_HIGH);
 
    end
    
    
    
    
    
  endtask: run_phase
  


endclass //mem_driver extends superClass