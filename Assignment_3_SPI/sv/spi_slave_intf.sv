interface spi_slave_intf#(input clk);

logic cs,mosi,miso ; 
    
logic [7:0] byte_0 ; 

// import uvm_pkg::*;
// `include "uvm_macros.svh"

task spi_slave_write(input bit [2:0] ins, bit [4:0] addr, bit [7:0] data[] );
  bit [7:0] byte_0;
  byte_0 = {ins, addr};

  cs = 0;

  for (int i = 0; i < 8; i++) begin
    @(negedge clk);
    mosi <= byte_0[i];
  end

  for (int i = 0; i < data.size(); i++) begin
    for (int j = 7; j >= 0; j++) begin
      @(negedge clk);
      mosi <= data[i][j];
    end
  end

  cs = 1;
endtask

task spi_slave_read(output bit [2:0] ins, output bit [4:0] addr, output bit [7:0] data[]);
  bit [7:0] byte_0;
  cs =0;


  for (int i = 0; i < 8; i++) begin
    @(negedge clk);
    byte_0[i] = miso;
  end

  {ins, addr} = byte_0;

  for (int i = 0; cs=1; i++) begin
    for (int j = 7; j >= 0; j--) begin
      @(negedge clk);
      data[i][j] = miso;
    end
  end
  cs = 1;

endtask


endinterface //spi_slave_intf();
