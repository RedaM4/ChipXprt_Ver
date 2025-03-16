class router_tb extends uvm_env; //env
         `uvm_component_utils(router_tb)
yapp_env env ; 
channel_env chan0,chan1,chan2 ; 
hbus_env hbus;
clock_and_reset_env clk_rst_env ; 
router_mcsequencer routermseqr; 

router_module_env ro_env ; 
// router_scb ro_scb ; 

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

  routermseqr = router_mcsequencer::type_id::create("routermseqr",this);
  ro_env = router_module_env::type_id::create("ro_env",this);

    endfunction


    //--------------------------------------------------------
  //Connect Phase
  //--------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(), "Connect Phase!", UVM_HIGH)

routermseqr.hbus_seqr = hbus.masters[0].sequencer ; 
routermseqr.yapp_seqr = env.agnt.seqr ; 

env.agnt.mon.item_collected_port.connect(ro_env.ro_ref.yapp_in);
hbus.masters[0].monitor.item_collected_port.connect(ro_env.ro_ref.hbus_in);

chan0.rx_agent.monitor.item_collected_port.connect(ro_env.ro_scb.chan0_in);
chan1.rx_agent.monitor.item_collected_port.connect(ro_env.ro_scb.chan1_in);
chan2.rx_agent.monitor.item_collected_port.connect(ro_env.ro_scb.chan2_in);


  endfunction: connect_phase





  //--------------------------------------------------------
  //start_of_simulation_phase
  //--------------------------------------------------------
function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Running Simulation", UVM_HIGH)
endfunction

endclass //touter_tb extends superClass