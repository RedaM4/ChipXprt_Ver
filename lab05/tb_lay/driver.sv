// `include "transaction.sv"
// `include "interface.sv"
   timeunit 1ns;
timeprecision 1ns;
class Driver;
    mailbox gen2drv;         // Mailbox to receive transactions
    virtual mem_interf vif;      // Interface to interact with DUT
  transaction t;
    // Constructor
    function new(mailbox g2d, virtual mem_interf vi);
        this.gen2drv = g2d;
        this.vif = vi;
    endfunction

    // Run task: Drives transactions to DUT
    task run();
      
        forever begin
            gen2drv.get(t); // Blocking call to get a transaction

            vif.addr <= t.address;
            vif.data_in <= t.data;
            vif.write <= 1;
            #10;
            vif.write <= 0;

            $display("[DRIVER] Writing Address = %0d, Data = %0c", t.address, t.data);
        end
    endtask
endclass