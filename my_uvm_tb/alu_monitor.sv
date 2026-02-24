///////////////////////////////////////
// monitors the DUT and records as
// sequence items
///////////////////////////////////////
import cv32e40p_pkg::*;
class alu_monitor extends uvm_monitor;
  
  `uvm_component_utils(alu_monitor)
  
  virtual alu_if vif;
  uvm_analysis_port #(alu_transaction) analysis_port;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    analysis_port = new("analysis_port", this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif))
          `uvm_fatal("MON_NOVIF", "No virtual interface")
  endfunction
  
  task run_phase(uvm_phase phase);
    alu_transaction txn;
        if (!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif))
          `uvm_fatal("MON_NOVIF", "No virtual interface")
    forever begin
      @(posedge vif.monitor.clk);
      if (vif.monitor.cb_mon.enable_i) begin //not meant to be measured in this way as it is an output into the dut
        txn = alu_transaction::type_id::create("txn");
        
        // Capture ALL signals
        txn.operator       = vif.monitor.cb_mon.operator_i;
        txn.operand_a      = vif.monitor.cb_mon.operand_a_i;
        txn.operand_b      = vif.monitor.cb_mon.operand_b_i;
        txn.operand_c      = vif.monitor.cb_mon.operand_c_i;
        txn.vector_mode    = vif.monitor.cb_mon.vector_mode_i;
        txn.bmask_a        = vif.monitor.cb_mon.bmask_a_i;
        txn.bmask_b        = vif.monitor.cb_mon.bmask_b_i;
        txn.imm_vec_ext    = vif.monitor.cb_mon.imm_vec_ext_i;
        txn.is_clpx        = vif.monitor.cb_mon.is_clpx_i;
        txn.is_subrot      = vif.monitor.cb_mon.is_subrot_i;
        txn.clpx_shift     = vif.monitor.cb_mon.clpx_shift_i;
        txn.ex_ready       = vif.monitor.cb_mon.ex_ready_i;
        
        // Wait for result
        @(posedge vif.monitor.clk);
        analysis_port.write(txn);
      end
    end
  endtask
endclass
