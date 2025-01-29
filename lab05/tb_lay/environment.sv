// `ifndef ENVIRONMENT_SV
// `define ENVIRONMENT_SV

// `include "transaction.sv"
// `include "generator.sv"
// `include "driver.sv"
// `include "monitor.sv"
// `include "scoreboard.sv"
// `include "interface.sv"
   timeunit 1ns;
timeprecision 1ns;
class Environment;
    // Components of the testbench
    Generator gen;
    Driver drv;
    Monitor mon;
    Scoreboard scb;

    // Mailboxes for communication between components
    mailbox gen2drv, mon2scb, gen2scb;
    virtual mem_interf vif; // Virtual interface to connect to DUT

    // Constructor: Initializes mailboxes and components
    function new(virtual mem_interf vi);
        this.vif = vi;
        gen2drv = new(); // Generator -> Driver
        gen2scb = new(); // Generator -> Scoreboard
        mon2scb = new(); // Monitor -> Scoreboard

        gen = new(gen2drv, gen2scb);
        drv = new(gen2drv, vif);
        mon = new(mon2scb, vif);
        scb = new(gen2scb, mon2scb);
    endfunction

    // Task to start all testbench components
    task run();
        fork
            gen.run(); // Generator runs separately
        join_none; // Allow other components to keep running after Generator completes

        fork
            drv.run();
            mon.run();
            scb.run();
        join
    endtask
endclass

// `endif // ENVIRONMENT_SV
