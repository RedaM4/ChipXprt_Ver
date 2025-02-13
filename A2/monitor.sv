 timeunit 1ns;
timeprecision 1ns;
class Monitor#(parameter DEPTH=8, DATA_WIDTH=8);
     mailbox mon2scb;
    virtual fifo_int vif;
 transaction  tw,tr;
 //logic [7:0] rdata ; 
    function new(mailbox m2sr, virtual fifo_int vi);
       // this.monfifo = m2sw;
        this.mon2scb = m2sr;
        this.vif = vi;
    endfunction


    task run(bit debug=1);
         @(negedge vif.clk);
        forever begin
     
         
             @(posedge vif.clk);          
              tr = new();
              tr.data_in = vif.data_in ; 
              tr.rst_n =vif.rst_n;
              tr.wr_en= vif.wr_en;
              tr.rd_en = vif.rd_en ; 

                @(negedge vif.clk);
                tr.data_out = vif.data_out;
                tr.full = vif.full ; 
                tr.empty = vif.empty ; 

               // tr.rst_n = 
                mon2scb.put(tr);

               if (debug) begin
              $display("[MONITOR] 🧐 Captured Transaction: Data = %0c (0x%0h), Full = %0b, Empty = %0b", 
              tr.data_out, tr.data_out, tr.full, tr.empty);
                end
           

            
            


           

           if (debug) begin
          if (vif.wr_en ==0 && vif.rd_en ==0 && vif.rst_n==1) begin
            $display("[MONITOR]📌FE Captured Transaction: , Full = %0b, Empty = %0b", 
             vif.full, vif.empty);end

        
                end



      end

    endtask

endclass //monitor