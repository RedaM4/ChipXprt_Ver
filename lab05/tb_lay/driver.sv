// `include "transaction.sv"
// `include "interface.sv"
   timeunit 1ns;
timeprecision 1ns;
class Driver;
    mailbox gen2drv;         // Mailbox to receive transactions
    virtual mem_interf vif;      // Interface to interact with DUT
  transaction t;
  logic [7:0]temp ; 
    // Constructor
    function new(mailbox g2d, virtual mem_interf vi);
        this.gen2drv = g2d;
        this.vif = vi;
    endfunction

    // Run task: Drives transactions to DUT
    task run();
      
        forever begin
           if(gen2drv.num() >0)begin
            gen2drv.get(t); // Blocking call to get a transaction
           //$display("hi - 1");
            //if(vif.write) begin   
            vif.write_mem(t.address, t.data);
            $display("[Driver] Write: Address = %0d, Data = %0c", t.address, t.data);
          vif.read_mem(t.address ,temp) ; 
            $display("[Driver] Read: Address = %0d, Data = %0c", t.address, t.data);

           end
            #10;
                             
            
           
           // end
        end
    endtask


endclass