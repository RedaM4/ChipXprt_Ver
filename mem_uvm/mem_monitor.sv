//`timescale 1ns/1ns
class mem_monitor extends uvm_monitor;
     `uvm_component_utils(mem_monitor)

 virtual mem_intf vif ; 
 mem_sequencer_item item ; 
 

   uvm_analysis_port #(mem_sequencer_item) monitor_port;

  
  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "mem_monitor", uvm_component parent);
    super.new(name, parent);
    `uvm_info("MONITOR_CLASS", "Inside Constructor!", UVM_HIGH)
  endfunction: new
  
  
  //--------------------------------------------------------
  //Build Phase
  //--------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("MONITOR_CLASS", "Build Phase!", UVM_HIGH)
    
    monitor_port = new("monitor_port", this);
    
    if(!(uvm_config_db #(virtual mem_intf)::get(this, "*", "vif", vif))) begin
      `uvm_error("MONITOR_CLASS", "Failed to get VIF from config DB!")
    end
    
  endfunction: build_phase
  
  //--------------------------------------------------------
  //Connect Phase
  //--------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("MONITOR_CLASS", "Connect Phase!", UVM_HIGH)
    
  endfunction: connect_phase
  
  
  
 
  
  

  //--------------------------------------------------------
  //Run Phase
  //--------------------------------------------------------
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("MONITOR_CLASS", "Inside Run Phase!", UVM_HIGH)
    
    forever begin
      item = mem_sequencer_item::type_id::create("item");
      
      //wait(!vif.reset);
      
      //sample inputs
      @(posedge vif.clk);
      if (vif.read) begin
        item.data_out = vif.data_out;
      end
  
      
      // send item to scoreboard
      monitor_port.write(item);
    end
        
  endtask: run_phase
  




endclass //mem_driver extends superClass