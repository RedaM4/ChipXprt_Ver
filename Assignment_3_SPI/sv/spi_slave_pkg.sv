package spi_slave;

import uvm_pkg::*;
`include "uvm_macros.svh"
typedef uvm_config_db#(virtual spi_slave_intf) spi_slave_vif_config;

`include "spi_slave_sequence_item.sv"
`include "spi_slave_monitor.sv"
`include "spi_slave_sequencer.sv"
`include "spi_slave_seqs.sv"
`include "spi_slave_driver.sv"
`include "spi_slave_agent.sv"
`include "spi_slave_env.sv"


    
endpackage