class router_tb extends uvm_env; //env
         `uvm_component_utils(router_tb)

   function new(string name = "router_tb",uvm_component parent);
            super.new(name, parent);
           `uvm_info(get_type_name(), "Inside Constructor!", UVM_LOW)
    endfunction //new()

    function void build_phase(uvm_phase phase);
    super.build_phase(phase);
               `uvm_info(get_type_name(), "Inside Build phase", UVM_HIGH)

    endfunction



endclass //touter_tb extends superClass