
// `include "uvm_macros.svh"


// import uvm_pkg::*;

module  dut(dut_if dif);    

// always @(posedge dif.clk) begin
//  `uvm_info("DUT: ",$sformatf("we have recieveed cmd=%d, addr=%d, data=%d ",dif.cmd, dif.addr, dif.data)  );
// end

 always @(posedge dif.clk) begin
    
@(posedge dif.clk);  // ✅ Wait for clock edge
            `uvm_info("DUT", $sformatf("Received cmd=%d, addr=%d, data=%d", 
                                       dif.cmd, dif.addr, dif.data), UVM_HIGH);
 end
endmodule