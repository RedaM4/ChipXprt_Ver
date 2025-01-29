// `include "transaction.sv"
   timeunit 1ns;
timeprecision 1ns;
class Generator;
    mailbox gen2drv, gen2scb;
    transaction t;
    function new(mailbox g2d, mailbox g2s);
        this.gen2drv = g2d;
        this.gen2scb = g2s;
    endfunction

    task run();
    
     t = new();
        repeat (5) begin
           t.control_knob = transaction::lower;
           

            if (!t.randomize()) begin
                $display("[GENERATOR]  ERROR: Randomization Failed!");
                continue;
            end

            //transaction::add_address(t.address);

            gen2drv.put(t);
            gen2scb.put(t);

            $display("[GENERATOR]  Sent Address = %0d, Data = %0c", t.address, t.data);
        end
    endtask
endclass
