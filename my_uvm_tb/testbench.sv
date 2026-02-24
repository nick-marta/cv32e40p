// hdl_top.sv - Your original structure preserved
//`include "alu_interface.sv"
//`include "alu_pkg.sv"
`include "alu_test.sv"
module cv32e40p_alu_tb();
  import cv32e40p_pkg::*;
  import uvm_pkg::*;
  import alu_pkg::*;
  
  logic clk, rst_n;
  alu_if alu_if_inst(.clk(clk));
  
  // YOUR ORIGINAL DUT - 100% unchanged!
  cv32e40p_alu dut (
    .clk                (clk),
    .rst_n              (rst_n),
    .enable_i           (alu_if_inst.enable_i),
    .operator_i         (alu_if_inst.operator_i),
    .operand_a_i        (alu_if_inst.operand_a_i),
    .operand_b_i        (alu_if_inst.operand_b_i),
    .operand_c_i        (alu_if_inst.operand_c_i),
    .vector_mode_i      (alu_if_inst.vector_mode_i),
    .bmask_a_i          (alu_if_inst.bmask_a_i),
    .bmask_b_i          (alu_if_inst.bmask_b_i),
    .imm_vec_ext_i      (alu_if_inst.imm_vec_ext_i),
    .is_clpx_i          (alu_if_inst.is_clpx_i),
    .is_subrot_i        (alu_if_inst.is_subrot_i),
    .clpx_shift_i       (alu_if_inst.clpx_shift_i),
    .result_o           (alu_if_inst.result_o),
    .comparison_result_o(alu_if_inst.comparison_result_o),
    .ready_o            (alu_if_inst.ready_o),
    .ex_ready_i         (alu_if_inst.ex_ready_i)
  );
  
  // YOUR ORIGINAL CLOCK - exactly 2ns period
  always #1 clk = ~clk;
  
  // YOUR ORIGINAL RESET
  initial begin
    clk = 0;
    uvm_config_db#(virtual alu_if)::set(uvm_root::get(), "", "vif", alu_if_inst);
    run_test("alu_test");
  end
  

  // YOUR ORIGINAL VCD
  initial begin
   // uvm_config_db#(virtual alu_if)::set(uvm_root::get(), "", "vif", alu_if_inst);

    //uvm_config_db#(virtual alu_if)::set(null, "uvm_test_top", "vif", alu_if_inst);
    //uvm_config_db#(virtual alu_if.driver)::set(null, "uvm_test_top", "vif", alu_if_inst_dr);
    $dumpfile("dump.vcd");
    $dumpvars();
  end
endmodule
