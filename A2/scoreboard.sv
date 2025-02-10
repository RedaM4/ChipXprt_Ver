timeunit 1ns;
timeprecision 1ns;

class Scoreboard#(parameter DEPTH=8, DATA_WIDTH=8);
    mailbox gen2scb, mon2scb;
    int errors = 0;
    int rep;
    event done;

    function new(mailbox g2s, mailbox m2s, int num = 2);
        this.gen2scb = g2s;
        this.mon2scb = m2s;
        this.rep = num;
    endfunction

    task run();
        transaction expected, actual;
        $display("[SCOREBOARD] Starting Test with %0d transactions.", rep);

        while (rep > 0) begin
            // ✅ Wait for transactions to arrive
            wait (gen2scb.num() > 0 && mon2scb.num() > 0);

            gen2scb.get(expected);
            mon2scb.get(actual);

            // ✅ Enhanced Verification for All Signals
            if (expected.data_in == actual.data_out) begin
                $display("[SCOREBOARD] ✅ PASS -> Data Matched: data_in = 0x%0h, data_out = 0x%0h", actual.data_out, expected.data_in);
            end else begin
                $display("[SCOREBOARD] ❌ ERROR -> Mismatch!");
                $display("  Expected -> data_out = 0x%0h", expected.data_in);
                $display("  Actual   -> data_in  = 0x%0h", actual.data_out);
                errors++;
            end

            rep--;
            $display("[SCOREBOARD] Remaining Transactions: %0d", rep);
            $display("Queue Status: gen2scb = %0d, mon2scb = %0d", gen2scb.num(), mon2scb.num());

            if (rep == 0) begin
               // #10; // ✅ Ensures last transaction is fully processed
                 if (errors == 0) begin
            $display("[FINISH] 🟢🟢🟢 TEST PASSED! No Errors.");
        end else begin
            $display("[FINISH] ❌❌❌ TEST FAILED! Errors: %0d", errors);
        end
                     $finish ; 
                // -> done; // ✅ Notify the testbench
                // break;   // ✅ Exit the loop cleanly
            end
        end

        // ✅ Final check to print test result
      
    endtask
endclass