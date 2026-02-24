// alu_sequence.sv
import cv32e40p_pkg::*;
class alu_add_sequence extends uvm_sequence #(alu_transaction);
  `uvm_object_utils(alu_add_sequence)
 
  function new(string name = "alu_add_sequence");
    super.new(name);
  endfunction
  
  task body();
    repeat(100) begin  // Extended your single test to 100x!
      alu_transaction txn = alu_transaction::type_id::create("txn");
      
      start_item(txn);
      // YOUR ORIGINAL TEST: 3 + 5 = 8
      assert(txn.randomize() with {
        operator == ALU_ADD;
        operand_a == 32'h00000003;
        operand_b == 32'h00000008;
        operand_c == 32'h00000000;
        vector_mode == VEC_MODE32;
        enable == 1;
        ex_ready == 1;
        is_clpx == 0;
        is_subrot == 0;
      });
      `uvm_info("SEQ", $sformatf("Sending ADD: 0x%h + 0x%h", 
                   txn.operand_a, txn.operand_b), UVM_MEDIUM)
      finish_item(txn);
    end
  endtask
endclass

// Random sequence for coverage
class alu_random_sequence extends uvm_sequence #(alu_transaction);
  `uvm_object_utils(alu_random_sequence)
  
  function new(string name = "alu_random_sequence"); super.new(name); endfunction
  
  task body();
    repeat(1000) begin
      alu_transaction txn = alu_transaction::type_id::create("txn");
      start_item(txn);
      assert(txn.randomize() with { operator inside {ALU_ADD, ALU_AND, ALU_OR, ALU_XOR, ALU_SUB}; });
      finish_item(txn);
    end
  endtask
endclass
