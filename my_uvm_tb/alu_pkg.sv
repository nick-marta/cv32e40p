// alu_pkg.sv - COMPLETE PACKAGE
package alu_pkg;
  import uvm_pkg::*;
  //`include "alu_test.sv"
  `include "uvm_macros.svh"
  `include "alu_transaction.sv"
  //`include "alu_interface.sv"
  `include "alu_driver.sv"
  `include "alu_monitor.sv"
  `include "alu_sequencer.sv"
  `include "alu_sequence.sv"
  // `include "alu_agent.sv"        // ← ADDED AGENT (FIX)
  // `include "testbench.sv"
endpackage
