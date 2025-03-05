class router_tb extends uvm_env; //env
         `uvm_component_utils(router_tb)
yapp_env env ; 
   function new(string name = "router_tb",uvm_component parent);
            super.new(name, parent);
           `uvm_info(get_type_name(), "Inside Constructor!", UVM_LOW)
    endfunction //new()

    function void build_phase(uvm_phase phase);
    super.build_phase(phase);
               `uvm_info(get_type_name(), "Inside Build phase", UVM_HIGH)
    env = yapp_env::type_id::create("env", this);

    endfunction


  //--------------------------------------------------------
  //start_of_simulation_phase
  //--------------------------------------------------------
function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Running Simulation", UVM_HIGH)
endfunction

endclass //touter_tb extends superClass