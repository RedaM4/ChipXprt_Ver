module piso_shift_reg(
  input  logic       clk,
  input  logic       rst_n,
  input  logic       load,
  input  logic [7:0] data_i,
  output logic       serial_o
);
  typedef enum logic [1:0] {IDLE, SHIFTING, START_SHIFTING} state_t;
  state_t state;
  logic [7:0] shift_reg;
  logic [3:0] count;
  
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      state     <= IDLE;
      shift_reg <= 8'b0;
      count     <= 0;
    end else begin
      case (state)
        IDLE: begin
          if (load) begin
            shift_reg <= data_i;
            count     <= 8;
            state     <= START_SHIFTING;
          end
        end
        START_SHIFTING: begin 
            state <= SHIFTING;
        end
        SHIFTING: begin
          if (count != 1) begin
            shift_reg <= shift_reg >> 1;
            count     <= count - 1;
          end else if(load) begin 
            shift_reg <= data_i;
            count     <= 8;
            state <= START_SHIFTING;          
          end
          else  state <= IDLE;
        end
      endcase
    end
  end
  
  assign serial_o = (state == SHIFTING) ? shift_reg[0] : 1'b1;
endmodule
