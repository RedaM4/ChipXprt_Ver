class router_mcsequencer extends uvm_sequencer;
  `uvm_component_utils(router_mcsequencer)


yapp_tx_sequencer  yapp_seqr ; 
hbus_master_sequencer hbus_seqr ; 

  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "router_mcsequencer", uvm_component parent);
    super.new(name, parent);
    `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
  endfunction: new

  
endclass //router_mcsequencer extends uvm_sequencer