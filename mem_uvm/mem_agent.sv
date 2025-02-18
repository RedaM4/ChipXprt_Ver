//`timescale 1ns/1ns

class mem_agent extends uvm_agent;
    `uvm_component_utils(mem_agent)

   mem_driver drv ;
   mem_monitor mon ;
   mem_sequencer seqr ; 



  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "mem_agent", uvm_component parent);
    super.new(name, parent);
    `uvm_info("AGENT_CLASS", "Inside Constructor!", UVM_HIGH)
  endfunction: new
  
  
  //--------------------------------------------------------
  //Build Phase
  //--------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("AGENT_CLASS", "Build Phase!", UVM_HIGH)
    
    drv = mem_driver::type_id::create("drv", this);
    mon = mem_monitor::type_id::create("mon", this);
    seqr = mem_sequencer::type_id::create("seqr", this);
    
  endfunction: build_phase
  
  
  //--------------------------------------------------------
  //Connect Phase
  //--------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("AGENT_CLASS", "Connect Phase!", UVM_HIGH)
    
    drv.seq_item_port.connect(seqr.seq_item_export);
    
  endfunction: connect_phase
  
  
  //--------------------------------------------------------
  //Run Phase
  //--------------------------------------------------------
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    
  endtask: run_phase
endclass //mem_agent extends superClass