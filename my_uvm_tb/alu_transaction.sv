// alu_transaction.sv
import cv32e40p_pkg::*;
class alu_transaction extends uvm_sequence_item;
  `uvm_object_utils(alu_transaction)
 
  // DUT inputs (randomizable)
  rand alu_opcode_e    operator;
  rand logic [31:0]    operand_a, operand_b, operand_c;
  rand logic [1:0]     vector_mode;
  rand logic [4:0]     bmask_a, bmask_b;
  rand logic [1:0]     imm_vec_ext;
  rand logic           enable, is_clpx, is_subrot, ex_ready;
  rand logic [1:0]     clpx_shift;
  
  // Expected result for checking
  logic [31:0]         expected_result;
  
  function new(string name = "alu_transaction");
    super.new(name);
  endfunction
  
  // Convert operator enum to string for debug
  function string op_to_string();
    case(operator)
      ALU_ADD: return "ADD";
      ALU_AND: return "AND";
      ALU_OR:  return "OR";
      ALU_XOR: return "XOR";
      ALU_SUB: return "SUB";
      default:  return "UNK";
    endcase
  endfunction
endclass
