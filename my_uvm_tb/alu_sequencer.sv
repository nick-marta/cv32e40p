// alu_sequencer.sv
typedef uvm_sequencer #(alu_transaction) _alu_sequencer;

class alu_sequencer extends _alu_sequencer;
  `uvm_component_utils(alu_sequencer)
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
endclass
