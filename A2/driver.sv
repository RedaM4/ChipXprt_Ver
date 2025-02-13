   timeunit 1ns;
timeprecision 1ns;
class Driver#(parameter DEPTH=8, DATA_WIDTH=8);
    mailbox gen2drv;         // Mailbox to receive transactions
    virtual fifo_int vif;   
      transaction t;

function new(mailbox g2d, virtual fifo_int vi);
        this.gen2drv = g2d;
        this.vif = vi;
        // this.t = new();
    endfunction


task run(bit debug =1);
 $display("---------------------------------------------------------\n");
 
forever begin
    //$display("gen2drv.num(): %d",gen2drv.num());
   
    //$display("gen2drv.num(): %d",gen2drv.num());
    if (gen2drv.num()  >= 0) begin
           // $display("ttt");
          gen2drv.get(t); 
      @(negedge vif.clk);   
             vif.rst_n    = t.rst_n;
            vif.wr_en    = t.wr_en;
            vif.rd_en    = t.rd_en;
            vif.data_in  = t.data_in;
       
        if (debug) begin
                $display("[DRIVER] 📝 Driving Transaction: rst_n = %0b, wr_en = %0b, rd_en = %0b, data_in = 0x%0h", 
         vif.rst_n, vif.wr_en, vif.rd_en, vif.data_in);
            
            end
           // #10;
    end    
    
end


endtask

endclass