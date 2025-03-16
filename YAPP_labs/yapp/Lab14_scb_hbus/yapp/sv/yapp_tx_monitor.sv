class yapp_tx_monitor extends uvm_monitor#(yapp_packet);
  `uvm_component_utils(yapp_tx_monitor)
   virtual interface yapp_if vif;
     uvm_analysis_port #(yapp_packet) item_collected_port;

  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "yapp_tx_monitor", uvm_component parent);
    super.new(name, parent);
    `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
        item_collected_port = new("item_collected_port", this);

  endfunction 
  
    //--------------------------------------------------------
  //Connect Phase
  //--------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(), "Connect Phase!", UVM_HIGH)
    if (!yapp_vif_config::get(this,"","vif", vif))
    `uvm_error("NOVIF","vif not set")  
  endfunction: connect_phase


  //--------------------------------------------------------
  //Run Phase
  //--------------------------------------------------------
  
yapp_packet pkt;

  // Count packets collected
  int num_pkt_col;

  // UVM run() phase
  task run_phase(uvm_phase phase);
    // Look for packets after reset
    @(posedge vif.reset)
    @(negedge vif.reset)
    `uvm_info(get_type_name(), "Detected Reset Done", UVM_MEDIUM)
    forever begin 
      // Create collected packet instance
      pkt = yapp_packet::type_id::create("pkt", this);

      // concurrent blocks for packet collection and transaction recording
      fork
        // collect packet
        vif.collect_packet(pkt.length, pkt.addr, pkt.payload, pkt.parity);
        // trigger transaction at start of packet
        @(posedge vif.monstart) void'(begin_tr(pkt, "Monitor_YAPP_Packet"));
      join

      pkt.parity_type = (pkt.parity == pkt.calc_parity()) ? GOOD_PARITY : BAD_PARITY;
      // End transaction recording
      end_tr(pkt);
      `uvm_info(get_type_name(), $sformatf("Packet Collected :\n%s", pkt.sprint()), UVM_LOW)
      num_pkt_col++;
            item_collected_port.write(pkt);  //-------------------changed

    end

  endtask : run_phase

  // UVM report_phase
  function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report: YAPP Monitor Collected %0d Packets", num_pkt_col), UVM_LOW)
  endfunction : report_phase

  //--------------------------------------------------------
  //start_of_simulation_phase
  //--------------------------------------------------------
function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Running Simulation", UVM_HIGH)
endfunction
endclass //yapp_tx_monitor extends superClass