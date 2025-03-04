class base_test extends uvm_test;   
         `uvm_component_utils(base_test)

    router_tb tb ; 
    // yapp_env env ;
    // yapp_tx_agent agnt;
    // yapp_tx_sequencer seqr;
        // yapp_5_packets seq;
        // yapp_5_packets seq2;


    function new(string name = "base_test",uvm_component parent);
            super.new(name, parent);
`uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)

    endfunction //new()

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
        uvm_config_wrapper::set(this, "tb.env.agnt.seqr.run_phase","default_sequence",yapp_5_packets::get_type());   
        // uvm_config_wrapper::set(this, "tb.env.agnt.seqr.run_phase","default_sequence",short_yapp_packet::get_type());   

               tb = router_tb::type_id::create("tb",this);
   
         `uvm_info(get_type_name(), "Inside Build phase", UVM_HIGH)

uvm_config_int::set( this, "*", "recording_detail",1);

    endfunction  

function void check_phase(uvm_phase phase);
check_config_usage();

endfunction


function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
endfunction


endclass //base_test extends superClass




class short_packet_test extends base_test;
          `uvm_component_utils(short_packet_test)

    function new(string name = "short_packet_test",uvm_component parent);
            super.new(name, parent);
`uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)

    endfunction //new()

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    set_type_override_by_type(yapp_packet::get_type(),short_yapp_packet::get_type() );
        uvm_config_wrapper::set(this, "tb.env.agnt.seqr.run_phase","default_sequence",yapp_5_packets::get_type());   
         `uvm_info(get_type_name(), "Inside Build phase", UVM_HIGH)
         //ssss



uvm_config_int::set( this, "*", "recording_detail",1);

    endfunction  

endclass //short_packet_test extends base_test




class set_config_test extends base_test;
          `uvm_component_utils(set_config_test)

    function new(string name = "set_config_test",uvm_component parent);
            super.new(name, parent);
`uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)

    endfunction //new()

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(uvm_active_passive_enum)::set(this, "yapp_env.yapp_tx_agent", "is_active", UVM_PASSIVE);

           //  tb = router_tb::type_id::create("tb",this);
    set_type_override_by_type(yapp_packet::get_type(),short_yapp_packet::get_type() );
        uvm_config_wrapper::set(this, "tb.env.agnt.seqr.run_phase","default_sequence",yapp_5_packets::get_type());   
         `uvm_info(get_type_name(), "Inside Build phase", UVM_HIGH)

uvm_config_int::set( this, "*", "recording_detail",1);

    endfunction  

endclass //short_packet_test extends base_test
