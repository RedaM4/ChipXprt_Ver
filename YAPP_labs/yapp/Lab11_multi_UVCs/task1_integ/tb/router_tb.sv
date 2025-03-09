class router_tb extends uvm_env; //env
         `uvm_component_utils(router_tb)
yapp_env env ; 
channel_env chan0,chan1,chan2 ; 
hbus_env hbus;
clock_and_reset_env clk_rst_env ; 
   function new(string name = "router_tb",uvm_component parent);
            super.new(name, parent);
           `uvm_info(get_type_name(), "Inside Constructor!", UVM_LOW)
    endfunction //new()

    function void build_phase(uvm_phase phase);
    super.build_phase(phase);
               `uvm_info(get_type_name(), "Inside Build phase", UVM_HIGH)
    env = yapp_env::type_id::create("env", this);

    chan0 = channel_env::type_id::create("chan0", this);
    chan1 = channel_env::type_id::create("chan1", this);
    chan2 = channel_env::type_id::create("chan2", this);
  uvm_config_int::set(this, "chan0", "channel_id", 0);
    uvm_config_int::set(this, "chan1", "channel_id", 1);
    uvm_config_int::set(this, "chan2", "channel_id", 2);   


        hbus = hbus_env::type_id::create("hbus", this);
    uvm_config_int::set(this, "hbus", "num_masters", 1);   
    uvm_config_int::set(this, "hbus", "num_slaves", 0);   

        clk_rst_env = clock_and_reset_env::type_id::create("clk_rst_env", this);

 
    endfunction


  //--------------------------------------------------------
  //start_of_simulation_phase
  //--------------------------------------------------------
function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Running Simulation", UVM_HIGH)
endfunction

endclass //touter_tb extends superClass