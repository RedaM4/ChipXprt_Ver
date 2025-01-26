timeunit 1ns;
timeprecision 1ns;
interface mem_interf(input logic clk);

  // Interface signals
  logic read;
  logic write; 
  logic [4:0] addr;
  logic [7:0] data_in;
  logic [7:0] data_out;
  
  // modport for testbench
  modport tb  ( input data_out, clk,  
                output data_in, addr, read, write,
                import read_mem, write_mem);

  // modport for design under test (Memory)
  modport mem ( output data_out, 
                input  clk, data_in, addr, read, write );
  

  // SV task to write data byte wdata at given address waddr
  task write_mem (input [4:0] waddr, input [7:0] wdata, input debug = 0);
    @(negedge clk);
    write <= 1;
    read  <= 0;
    addr  <= waddr;
    data_in  <= wdata;
    @(negedge clk);
    write <= 0;
    if (debug == 1)
      $display("Write - Address:%d  Data:%h", waddr, wdata);
  endtask
  
  // SV task to read data byte from memory using address raddr and store it in rdata
  task read_mem (input [4:0] raddr, output [7:0] rdata, input debug = 0);
     @(negedge clk);
     write <= 0;
     read  <= 1;
     addr  <= raddr;
     @(negedge clk);
     read <= 0;
     rdata = data_out;
     if (debug == 1) 
       $display("Read  - Address:%d  Data:%h", raddr, rdata);
  endtask
  
endinterface