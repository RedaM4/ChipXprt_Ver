module spi_slave_mem (
  input  logic cs,      // Active–low chip select
  input  logic sclk,    // Serial clock
  input  logic mosi,    // Master Out, Slave In
  output logic miso     // Master In, Slave Out
);
  timeunit 1ns;
  timeprecision 1ns;

  byte mem [0:31];

  initial begin
    integer i;
    for (i = 0; i < 32; i = i + 1)
      mem[i] = 0;
  end

  task spi_get_byte(output byte result);
    integer i;
    begin
      result = 0;
      for (i = 7; i >= 0; i = i - 1) begin
        @(posedge sclk);
        result[i] = mosi;
      end
      @(negedge sclk);
    end
  endtask

  task spi_send_byte(input byte data);
    integer i;
    begin
      for (i = 7; i >= 0; i = i - 1) begin
        miso = data[i];
        @(negedge sclk);
      end
      @(posedge sclk); 
      #0.1;
      miso = 1'bz;
    end
  endtask


  byte data;
  byte cmd;
  logic [2:0] inst;
  logic [4:0] addr;

  initial begin
    // Default: tri–state MISO.
    miso = 1'bz;
    forever begin
      // Wait for a transaction to start (CS falling edge)
      wait(~cs);
      fork 
        spi_slave_operation;
        wait_for_end;
      join_any
      disable fork;
    end
  end



  task spi_slave_operation;
      spi_get_byte(cmd);
      inst = cmd[7:5];
      addr = cmd[4:0];
      case (inst)
        3'b001: begin
          // Tested working fine
          spi_get_byte(data);
          mem[addr] = data;
        end
        3'b010: begin // tested working fine
          data = mem[addr];
          spi_send_byte(data);
        end
        3'b011: begin // yet to be tested
          while (cs == 0) begin
            spi_get_byte(data);
            mem[addr] = data;
            if (addr < 31)
              addr = addr + 1;
            else
              break;
          end
        end
        3'b100: begin
          while (cs == 0) begin
            data = mem[addr];
            spi_send_byte(data);
            if (addr < 31)
              addr = addr + 1;
            else
              break;
          end
        end
        default: begin
        end
      endcase
  endtask


  task wait_for_end;
    wait(cs);
  endtask

endmodule
