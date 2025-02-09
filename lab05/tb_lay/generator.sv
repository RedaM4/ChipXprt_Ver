// `include "transaction.sv"
   timeunit 1ns;
timeprecision 1ns;
class Generator;
    mailbox gen2drv, gen2scb;
    transaction t,temp;
    function new(mailbox g2d, mailbox g2s);
        this.gen2drv = g2d;
        this.gen2scb = g2s;
    endfunction

    task run();
    
     t = new();
        repeat (5) begin
           t.control_knob = transaction::lower;
           t.randomize();
            
            // if (!t.randomize()) begin
            //     $display("[GENERATOR]  ERROR: Randomization Failed!");
            //     continue;
            // end
        //    transaction::add_address(t.address);

            temp = new() ; 
            temp.address = t.address ; 
            temp.data = t.data ; 

            gen2drv.put(temp);
            gen2scb.put(temp);

            $display("[GENERATOR]  Sent Address = %0d, Data = %0c", temp.address, temp.data);
        end

    


    endtask
endclass
