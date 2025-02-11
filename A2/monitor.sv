 timeunit 1ns;
timeprecision 1ns;
class Monitor#(parameter DEPTH=8, DATA_WIDTH=8);
     mailbox mon2scb;
    virtual fifo_int vif;
 transaction #(DEPTH, DATA_WIDTH) t;
 //logic [7:0] rdata ; 
    function new(mailbox m2s, virtual fifo_int vi);
        this.mon2scb = m2s;
        this.vif = vi;
    endfunction


    task run(bit debug=1);
       
        forever begin
         @(negedge vif.clk);
          if (vif.rd_en) begin
             
              t = new();
                //t.address = vif.addr;
                t.data_out = vif.data_out;
                t.full = vif.full ; 
                t.empty = vif.empty ; 

               
                mon2scb.put(t);

                if (debug) begin
              $display("[MONITOR] 🧐 Captured Transaction: Data = %0c (0x%0h), Full = %0b, Empty = %0b", 
              t.data_out, t.data_out, t.full, t.empty);
                end
            
                   
           end

           if (debug) begin
          if (vif.wr_en ==0 && vif.rd_en ==0 && vif.rst_n==1) begin
            $display("[MONITOR]📌FE Captured Transaction: , Full = %0b, Empty = %0b", 
             vif.full, vif.empty);

        end
                end



      end

    endtask

endclass //monitor