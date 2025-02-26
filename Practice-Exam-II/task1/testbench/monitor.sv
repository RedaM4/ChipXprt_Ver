class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)

 virtual piso_intf vif ; 
 sequence_item item ; 
 

   uvm_analysis_port #(sequence_item) monitor_port;

  
  //--------------------------------------------------------
  //Consitemuctor
  //--------------------------------------------------------
  function new(string name = "monitor", uvm_component parent);
    super.new(name, parent);
    `uvm_info("MONITOR_CLASS", "Inside Consitemuctor!", UVM_HIGH)
        piso_coverage = new();

  endfunction: new
  
  
  //--------------------------------------------------------
  //Build Phase
  //--------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("MONITOR_CLASS", "Build Phase!", UVM_HIGH)
    
    monitor_port = new("monitor_port", this);
    
    if(!(uvm_config_db #(virtual piso_intf)::get(this, "*", "vif", vif))) begin
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
      item = sequence_item::type_id::create("item");
// @(posedge vif.clk);

    @(negedge vif.clk);   
    forever begin
          
          @(posedge vif.clk);
           item.rst_n =vif.rst_n;
            item.data_i = vif.data_i;
            item.load =vif.load;


             @(negedge vif.clk);
               item.serial_o = vif.serial_o;
  
                        piso_coverage.sample();
      `uvm_info("MONITOR", "Sending !", UVM_LOW)
      monitor_port.write(item);
    end
        
  endtask: run_phase
  



//--------------------------------------------------------
    // Functional Coverage
    //--------------------------------------------------------
    

covergroup piso_coverage ;
coverpoint vif.rst_n { bins reset_bin = {0,1}  ; }
coverpoint vif.load { bins load_bin = {0,1}  ; }

coverpoint vif.data_i { 
    bins low_range = {[0:99]  };
    bins medium_range ={ [100:199] }; 
    bins high_range = {[200:255]  };
 }
cross vif.rst_n, vif.load, vif.data_i ; 



endgroup





endclass //mem_driver extends superClass