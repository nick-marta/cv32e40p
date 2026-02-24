
////////////////////////////////////////
// resonsible for driving mthe DUT
// uses db config to get a handle to the 
// virtual interface
/////////////////////////////////////////
class alu_driver extends uvm_driver #(alu_transaction);
  `uvm_component_utils(alu_driver)
  
  virtual alu_if vif;  // Monitor clocking for sampling
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif))
      `uvm_fatal("DRV_NOVIF", "No virtual interface")
  endfunction
  
 
    
  task run_phase(uvm_phase phase);
    alu_transaction txn;
        if (!uvm_config_db#(virtual alu_if)::get(this, "", "vif", vif))
      `uvm_fatal("DRV_NOVIF", "No virtual interface")
    forever begin
      seq_item_port.get_next_item(txn);
      
      // Drive inputs 
      vif.driver.cb.operator_i      <= txn.operator;
      vif.driver.cb.enable_i        <= 1'b1;
      vif.driver.cb.operand_a_i     <= txn.operand_a;
      vif.driver.cb.operand_b_i     <= txn.operand_b;
      vif.driver.cb.operand_c_i     <= txn.operand_c;
      vif.driver.cb.vector_mode_i   <= VEC_MODE32;  // Your scalar mode
      vif.driver.cb.bmask_a_i       <= txn.bmask_a;
      vif.driver.cb.bmask_b_i       <= txn.bmask_b;
      vif.driver.cb.imm_vec_ext_i   <= txn.imm_vec_ext;
      vif.driver.cb.is_clpx_i       <= txn.is_clpx;
      vif.driver.cb.is_subrot_i     <= txn.is_subrot;
      vif.driver.cb.clpx_shift_i    <= txn.clpx_shift;
      vif.driver.cb.ex_ready_i      <= txn.ex_ready;
      
      // Wait 1 cycle (your original timing)
      @(posedge vif.driver.clk);
      
      // Deassert enable (your original timing)
      vif.driver.cb.enable_i <= 1'b0;
      
      // Sample outputs after 1 more cycle
      @(posedge vif.driver.clk);
      txn.expected_result = txn.operand_a + txn.operand_b;  // ADD reference
      
      // Get response from monitor
     seq_item_port.item_done();
    end
  endtask
endclass
