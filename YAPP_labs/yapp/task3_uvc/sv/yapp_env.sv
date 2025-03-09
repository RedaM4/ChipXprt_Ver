class yapp_env extends uvm_env;
       `uvm_component_utils(yapp_env)

   yapp_tx_agent agnt ; 
  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "yapp_env", uvm_component parent);
    super.new(name, parent);
    `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
  endfunction: new


  //--------------------------------------------------------
  //Build Phase
  //--------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), "Build Phase!", UVM_HIGH)
    
    agnt = yapp_tx_agent::type_id::create("agnt", this);
    // scb = scoreboard::type_id::create("scb", this);
    
  endfunction: build_phase

  //--------------------------------------------------------
  //start_of_simulation_phase
  //--------------------------------------------------------
function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Running Simulation", UVM_HIGH)
endfunction
endclass //yapp_env extends uvm_env