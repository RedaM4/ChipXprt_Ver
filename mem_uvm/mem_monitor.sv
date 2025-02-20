//`timescale 1ns/1ns
class mem_monitor extends uvm_monitor;
     `uvm_component_utils(mem_monitor)

 virtual mem_intf vif ; 
 mem_sequencer_item item ; 
 

   uvm_analysis_port #(mem_sequencer_item) monitor_port;

  
  //--------------------------------------------------------
  //Consitemuctor
  //--------------------------------------------------------
  function new(string name = "mem_monitor", uvm_component parent);
    super.new(name, parent);
    `uvm_info("MONITOR_CLASS", "Inside Consitemuctor!", UVM_HIGH)
        mem_coverage = new();

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
      item = mem_sequencer_item::type_id::create("item");
// @(posedge vif.clk);

    @(negedge vif.clk);   
    forever begin
          
          @(posedge vif.clk);
              item.data_in = vif.data_in ; 
             // item.rst_n =vif.rst_n;
             item.addr=vif.addr ;
              item.write= vif.write;
              item.read = vif.read ;
             @(negedge vif.clk);
               item.data_out = vif.data_out;
  
             // if (item.write) 
                        mem_coverage.sample();
      `uvm_info("MONITOR", "Sending !", UVM_LOW)
      monitor_port.write(item);
    end
        
  endtask: run_phase
  



//--------------------------------------------------------
    // Functional Coverage
    //--------------------------------------------------------
    covergroup mem_coverage ;
      coverpoint vif.write {
          bins wr_zero = {0}; 
            bins wr_one= {1};  

          
           }

      coverpoint vif.read {
        bins rd_zero = {0};     
        bins rd_one= {1};  
          }


    coverpoint vif.addr {
        bins all_addr[] = {[0:31]};    
        // bins mid_range = {[8:15]};  
        // bins high_range = {[16:31]}; 
    }

    coverpoint vif.data_in{  
      bins zero = {0};  
      bins random_range = {[1:255]};}

      
   cross vif.write, vif.addr,vif.data_in;  
   cross vif.read, vif.addr;


endgroup





endclass //mem_driver extends superClass