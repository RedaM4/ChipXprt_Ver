class base_test extends uvm_test;   
         `uvm_component_utils(base_test)

    router_tb rtb ; 
 


    function new(string name = "base_test",uvm_component parent);
            super.new(name, parent);
`uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)

    endfunction //new()

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
             
         `uvm_info(get_type_name(), "Inside Build phase", UVM_HIGH)
               rtb = router_tb::type_id::create("rtb",this);
            // rtb = new("rtb",this);
    endfunction



function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
endfunction


endclass //base_test extends superClass