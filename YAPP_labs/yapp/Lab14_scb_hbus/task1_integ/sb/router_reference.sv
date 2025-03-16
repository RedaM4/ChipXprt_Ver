class router_reference extends uvm_component;
  `uvm_component_utils(router_reference)

uvm_analysis_port #(yapp_packet) yapp_valid_port;


  `uvm_analysis_imp_decl(_hbus)
  `uvm_analysis_imp_decl(_yapp)

  uvm_analysis_imp_hbus#(hbus_transaction, router_reference) hbus_in;
  uvm_analysis_imp_yapp#(yapp_packet, router_reference) yapp_in;

  function new(string name = "router_reference", uvm_component parent);
    super.new(name, parent);
    `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
    
    yapp_in = new("yapp_in", this);
    hbus_in = new("hbus_in", this);
    yapp_valid_port = new("yapp_valid_port", this);
  endfunction

  int maxpktsize = 0, router_en = 0;
  int dropped_size = 0, dropped_enable = 0, dropped_address = 0;
  
  // function void write_hbus(hbus_transaction ht);
  //   maxpktsize = ht.maxpktsize;
  //   router_en = ht.router_en;
  // endfunction


// int maxpktsize=0 , router_en=0 ; 

function void write_hbus(hbus_transaction tr);

    case (tr.haddr)
      'h1000: begin
        maxpktsize = tr.hdata[5:0]; 
        `uvm_info("REF_CLASS", $sformatf("Updated maxpktsize: %0d", maxpktsize), UVM_LOW)
      end
      'h1001: begin
        router_en = tr.hdata[0];  
        `uvm_info("REF_CLASS", $sformatf("Updated router_en: %0d", router_en), UVM_LOW)
      end
    endcase

endfunction: write_hbus




  yapp_packet yapp_q[$];

  function void write_yapp(yapp_packet packet);
    if (!router_en) begin
        dropped_enable++;
        return;
    end

    if (packet.length > maxpktsize) begin
        dropped_size++;
        return;
    end

    if (packet.addr > 3) begin
        dropped_address++;
        return;
    end

    yapp_q.push_back(packet);  // Store in queue
    yapp_valid_port.write(packet); // Send to scoreboard
  endfunction
endclass
