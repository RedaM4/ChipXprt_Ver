class spi_slave_agent extends uvm_agent;
spi_slave_sequencer seqr ; 
spi_slave_driver drv;
spi_slave_monitor mon ; 

`uvm_component_utils_begin(spi_slave_agent)
`uvm_field_enum(uvm_active_passive_enum,is_active,UVM_ALL_ON)
`uvm_component_utils_end

   //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "spi_slave_agent", uvm_component parent);
    super.new(name, parent);
    `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
  endfunction: new


  //--------------------------------------------------------
  //Build Phase
  //--------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), "Build Phase!", UVM_HIGH)
    if (is_active == UVM_ACTIVE) begin
         seqr = yapp_tx_sequencer::type_id::create("seqr", this);
          drv = spi_slave_driver::type_id::create("drv", this);
    end

    mon = spi_slave_monitor::type_id::create("mon", this);
   
    
  endfunction: build_phase

  //--------------------------------------------------------
  //Connect Phase
  //--------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(), "Connect Phase!", UVM_HIGH)
     if (is_active == UVM_ACTIVE)
    drv.seq_item_port.connect(seqr.seq_item_export);
    
  endfunction: connect_phase

  //--------------------------------------------------------
  //start_of_simulation_phase
  //--------------------------------------------------------
  
function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Running Simulation", UVM_HIGH)
endfunction
endclass //spi_slave_agent extends uvm_agent