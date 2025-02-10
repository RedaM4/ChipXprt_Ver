   timeunit 1ns;
timeprecision 1ns;
class Driver#(parameter DEPTH=8, DATA_WIDTH=8);
    mailbox gen2drv;         // Mailbox to receive transactions
    virtual fifo_int vif;   
      transaction #(DEPTH, DATA_WIDTH)t;

function new(mailbox g2d, virtual fifo_int vi);
        this.gen2drv = g2d;
        this.vif = vi;
    endfunction


task run(bit debug =1);
 $display("---------------------------------------------------------\n");
forever begin
    if (gen2drv.num()  > 0) begin
          gen2drv.get(t); 
        @(negedge vif.clk);
             vif.rst_n    = t.rst_n;
            vif.wr_en    = t.wr_en;
            vif.rd_en    = t.rd_en;
            vif.data_in  = t.data_in;
       
        if (debug == 1) begin
                $display("[DRIVER] Driving Transaction: rst_n = %0b, wr_en = %0b, rd_en = %0b, data_in = 0x%0h", 
         vif.rst_n, vif.wr_en, vif.rd_en, vif.data_in);
            #10;
            end

    end    




end


endtask

endclass