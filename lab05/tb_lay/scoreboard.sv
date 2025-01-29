// `include "transaction.sv"
   timeunit 1ns;
timeprecision 1ns;
class Scoreboard;
    mailbox gen2scb, mon2scb;
    int errors = 0;

    function new(mailbox g2s, mailbox m2s);
        this.gen2scb = g2s;
        this.mon2scb = m2s;
    endfunction

    task run();
        transaction expected, actual;
        forever begin
            gen2scb.get(expected);
            mon2scb.get(actual);

            if (expected.address == actual.address && expected.data == actual.data) begin
                $display("[SCOREBOARD] ✅ PASS: Address = %0d, Data = %0c", actual.address, actual.data);
            end else begin
                $display("[SCOREBOARD] ❌ ERROR: Address = %0d | Expected = %0c, Received = %0c",
                         actual.address, expected.data, actual.data);
                errors++;
            end
        end
    endtask
endclass

// `endif // SCOREBOARD_SV
