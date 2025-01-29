// `include "transaction.sv"
// `include "interface.sv"
   timeunit 1ns;
timeprecision 1ns;
class Monitor;
    mailbox mon2scb;
    virtual mem_interf vif;
 transaction t;
    function new(mailbox m2s, virtual mem_interf vi);
        this.mon2scb = m2s;
        this.vif = vi;
    endfunction

    task run();
       
        forever begin
            @(posedge vif.clk);
            if (vif.read) begin
                t = new();
                t.address = vif.addr;
                t.data = vif.data_out;

                mon2scb.put(t);
                $display("[MONITOR] Captured: Address = %0d, Data = %0c", t.address, t.data);
            end
        end
    endtask
endclass

