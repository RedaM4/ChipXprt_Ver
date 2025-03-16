class router_module_env extends uvm_env;
`uvm_component_utils(router_module_env)

    function new(string name = "router_module_env",uvm_component parent);
    super.new(name, parent);
    `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)

    endfunction //new()

router_reference ro_ref;
router_scb ro_scb  ;
hbus_monitor hbus_mon ;  

   function void build_phase(uvm_phase phase);
    super.build_phase(phase);
ro_ref = router_reference::type_id::create("ro_ref", this) ; 
ro_scb = router_scb::type_id::create("ro_scb", this) ; 
hbus_mon = hbus_monitor::type_id::create("hbus_mon", this) ; 
endfunction


 function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
// hbus_mon.item_collected_port.connect(ro_ref.hbus_in);


ro_ref.yapp_valid_port.connect(ro_scb.yapp_in) ; 


endfunction


endclass //router_module_env extends uvm_env