/*-----------------------------------------------------------------
File name     : hw_top_dut.sv
Developers    : Kathleen Meade, Brian Dickinson
Created       : 01/04/11
Description   : lab06_vif hardware top module for acceleration
              : instantiates clock generator, interfaces and DUT
Notes         : From the Cadence "SystemVerilog Accelerated Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

module hw_top;

  // Clock and reset signals
  logic [31:0]  clock_period;
  logic         run_clock;
  logic         clock;
  logic         reset;

  // YAPP Interface to the DUT
  yapp_if in0(clock, reset);
/* clock_and_reset_if  (
    input  bit          clock,
    output bit          reset,
           bit          run_clock = 0, 
           logic [31:0] clock_period = 10 );*/

clock_and_reset_if clk_rst_if (
    .clock(clock),
    .reset(reset),
    .run_clock(run_clock),
    .clock_period(clock_period)
);

  hbus_if hbus(clock, reset);


channel_if chif0(clock,reset);
channel_if chif1(clock,reset);
channel_if chif2(clock,reset);



  // CLKGEN module generates clock
  clkgen clkgen (
    .clock(clock ),
    .run_clock(run_clock),
    .clock_period(clock_period)
  );




  yapp_router dut(
    .reset(reset),
    .clock(clock),
    .error(),
    // YAPP interface signals connection
    .in_data(in0.in_data),
    .in_data_vld(in0.in_data_vld),
    .in_suspend(in0.in_suspend),
    // Output Channels
    //Channel 0   
    .data_0(chif0.data),
    .data_vld_0(chif0.data_vld),
    .suspend_0(chif0.suspend),
    //Channel 1   
    .data_1(chif1.data),
    .data_vld_1(chif1.data_vld),
    .suspend_1(chif1.suspend),
    //Channel 2   
    .data_2(chif2.data),  
    .data_vld_2(chif2.data_vld),
    .suspend_2(chif2.suspend),
    // Host Interface Signals
    .haddr(hbus.haddr),
    .hdata(hbus.hdata_w),
    .hen(hbus.hen),
    .hwr_rd(hbus.hwr_rd));

  // initial begin
  //   reset <= 1'b0;
  //   @(negedge clock)
  //     #1 reset <= 1'b1;
  //   @(negedge clock)
  //     #1 reset <= 1'b0;
  // end

endmodule
