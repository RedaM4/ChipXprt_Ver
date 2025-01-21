interface mem_intf;
    
timeunit 1ns;
timeprecision 1ns;

    logic read;
    logic write;
    logic [4:0] addr;
    logic [7:0] data_in;
    logic [7:0] data_out;

endinterface //interfacename mem_intf;


