
`include "alu_pkg.sv"
`include "alu_interface.sv"
 import alu_pkg::*;
class alu_test extends uvm_test;
  `uvm_component_utils(alu_test)
  
  alu_driver     m_driver;
  alu_monitor    m_monitor;
  alu_sequencer  m_sequencer;
  virtual alu_if vif; //alu_if_inst(.clk(clk));
  //alu_if         vif;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Get interface from config_db
   // if (!uvm_config_db#(virtual alu_if.monitor)::get(this, "", "vif", vif))
   //   `uvm_fatal("TEST", "Interface not found in config_db")
    
    m_driver    = alu_driver::type_id::create("m_driver", this);
    m_monitor   = alu_monitor::type_id::create("m_monitor", this);
    m_sequencer = alu_sequencer::type_id::create("m_sequencer", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
    m_driver.vif = vif;
    m_monitor.vif = vif;
  endfunction
  
  task run_phase(uvm_phase phase);
    alu_add_sequence seq;
    
    phase.raise_objection(this);
    seq = alu_add_sequence::type_id::create("seq");
    seq.start(m_sequencer);
    phase.drop_objection(this);
  endtask
endclass
