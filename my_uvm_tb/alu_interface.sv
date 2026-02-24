// alu_interface.sv
//////////////////////////////////////
// connects uvm stimulus and monitor
// to the RTL
//////////////////////////////////////
interface alu_if (input logic clk);
 import cv32e40p_pkg::*;
  // All your original DUT signals
  alu_opcode_e    operator_i;
  logic           enable_i;
  logic  [31:0]   operand_a_i, operand_b_i, operand_c_i;
  logic  [1:0]    vector_mode_i;
  logic  [4:0]    bmask_a_i, bmask_b_i;
  logic  [1:0]    imm_vec_ext_i;
  logic           is_clpx_i, is_subrot_i;
  logic  [1:0]    clpx_shift_i;
  logic           ex_ready_i;
  
  logic  [31:0]   result_o;
  logic           comparison_result_o;
  logic           ready_o;
  
  clocking cb @(posedge clk);
    // Driver drives these
    output operator_i, enable_i, operand_a_i, operand_b_i, operand_c_i;
    output vector_mode_i, bmask_a_i, bmask_b_i, imm_vec_ext_i;
    output is_clpx_i, is_subrot_i, clpx_shift_i, ex_ready_i;
    // Monitor samples these
    input  result_o, comparison_result_o, ready_o;
  endclocking
  
   clocking cb_mon @(posedge clk);
    // Driver drives these
    input operator_i, enable_i, operand_a_i, operand_b_i, operand_c_i;
    input vector_mode_i, bmask_a_i, bmask_b_i, imm_vec_ext_i;
    input is_clpx_i, is_subrot_i, clpx_shift_i, ex_ready_i;
    // Monitor samples these
    input  result_o, comparison_result_o, ready_o;
  endclocking
  
  
    modport driver (clocking cb, input clk);
      modport monitor (clocking cb_mon, input clk);
endinterface
