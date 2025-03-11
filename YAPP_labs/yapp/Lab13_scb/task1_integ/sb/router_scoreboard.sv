class router_scb extends uvm_scoreboard;
`uvm_component_utils(router_scb)

`uvm_analysis_imp_decl(_yapp)
`uvm_analysis_imp_decl(_chan0)
`uvm_analysis_imp_decl(_chan1)
`uvm_analysis_imp_decl(_chan2)

uvm_analysis_imp_yapp#(yapp_packet,router_scb) yapp_in ;
uvm_analysis_imp_chan0#(channel_packet,router_scb) chan0_in;
uvm_analysis_imp_chan1#(channel_packet,router_scb) chan1_in;
uvm_analysis_imp_chan2#(channel_packet,router_scb)chan2_in;

    function new(string name = "router_scb",uvm_component parent);
    super.new(name, parent);
    `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)

yapp_in = new("yapp_in",this) ; 

chan0_in = new("chan0_in",this) ; 
chan1_in = new("chan1_in",this) ; 
chan2_in = new("chan2_in",this) ; 
    endfunction //new()

// yapp_packet actual[$];




yapp_packet expect_chan0[$];
yapp_packet expect_chan1[$];
yapp_packet expect_chan2[$];

// yapp_packet expect_yapp[$];



int received_packet_counter , wrong_packet_counter, matched_packet_counter ;  

// function void write(yapp_packet packet);
// actual_chan0.push_back(packet);  

// endfunction

function void write_yapp(yapp_packet packet);
yapp_packet pkt;
$cast(pkt,packet.clone()) ; 
 received_packet_counter++ ; 
 case (packet.addr)
        0: expect_chan0.push_back(packet); 
        1: expect_chan1.push_back(packet); 
        2: expect_chan2.push_back(packet);
    endcase


endfunction



function void write_chan0(input  channel_packet cp);
yapp_packet yp ; 
yp = expect_chan0.pop_front() ; 
if (comp_equal(yp,cp)) begin
 matched_packet_counter++ ;    
end 
else begin
wrong_packet_counter++ ; 
end
endfunction

function void write_chan1(input  channel_packet cp);
yapp_packet yp ; 
yp = expect_chan1.pop_front() ; 
if (comp_equal(yp,cp)) begin
 matched_packet_counter++ ;    
end 
else begin
wrong_packet_counter++ ; 
end
endfunction

function void write_chan2(input  channel_packet cp);
yapp_packet yp ; 
yp = expect_chan2.pop_front() ; 
if (comp_equal(yp,cp)) begin
 matched_packet_counter++ ;    
end 
else begin
wrong_packet_counter++ ; 
end
endfunction

// function void ref_model(yapp_packet actual);
//           actual = transactions.pop_front();    
// endfunction






//  //--------------------------------------------------------
//   //Run Phase
//   //--------------------------------------------------------
//   task void run_phase (uvm_phase phase);
//     super.run_phase(phase);
//     `uvm_info("SCB_CLASS", "Run Phase!", UVM_HIGH)


//   endtask   



    








     function bit comp_equal (input yapp_packet yp, input channel_packet cp);
      // returns first mismatch only
      if (yp.addr != cp.addr) begin
        `uvm_error("PKT_COMPARE",$sformatf("Address mismatch YAPP %0d Chan %0d",yp.addr,cp.addr))
        return(0);
      end
      if (yp.length != cp.length) begin
        `uvm_error("PKT_COMPARE",$sformatf("Length mismatch YAPP %0d Chan %0d",yp.length,cp.length))
        return(0);
      end
      foreach (yp.payload [i])
        if (yp.payload[i] != cp.payload[i]) begin
          `uvm_error("PKT_COMPARE",$sformatf("Payload[%0d] mismatch YAPP %0d Chan %0d",i,yp.payload[i],cp.payload[i]))
          return(0);
        end
      if (yp.parity != cp.parity) begin
        `uvm_error("PKT_COMPARE",$sformatf("Parity mismatch YAPP %0d Chan %0d",yp.parity,cp.parity))
        return(0);
      end
      return(1);
   endfunction

function void report_phase(uvm_phase phase);
    super.report_phase(phase);
`uvm_info("SCB_Rep",$sformatf("\nReceieved: %d,Wrong: %d, Matched: %d \n", received_packet_counter, wrong_packet_counter, matched_packet_counter),UVM_HIGH)
    
    
endfunction

endclass //router_scb extends uvm_scoreboard