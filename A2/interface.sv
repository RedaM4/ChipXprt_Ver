timeunit 1ns;
timeprecision 1ns;
interface fifo_int#(parameter DATA_WIDTH = 8, DEPTH=8 )(
   input logic clk
       );
      logic rst_n,wr_en,rd_en;
     logic [DATA_WIDTH -1:0] data_in;
     logic full,empty;
     logic [DATA_WIDTH-1:0]data_out;



endinterface