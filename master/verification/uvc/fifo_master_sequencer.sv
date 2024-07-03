// * * * Default sequencer * * *

class fifo_master_sequencer extends uvm_sequencer #(fifo_item);

   `uvm_component_utils(fifo_master_sequencer)
    fifo_cfg cfg;
   virtual fifo_if fifo_vif;
  fifo_reg_block  regmodel;   
    extern function new(string name, uvm_component parent);
    extern function void build_phase(uvm_phase phase);
endclass : fifo_master_sequencer
 
//-------------------------------------------------------------------------------------------------------------
function fifo_master_sequencer::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction : new

//-------------------------------------------------------------------------------------------------------------
function void fifo_master_sequencer::build_phase(uvm_phase phase);
    super.build_phase(phase);
 if(!uvm_config_db #(virtual fifo_if)::get(this, "", "fifo_vif", fifo_vif)) begin 
       `uvm_fatal("", "Failed to get virtual_interface !");
end
   if(!uvm_config_db #(fifo_reg_block)::get(this, "", "regmodel", regmodel)) begin 
       `uvm_fatal("", "Failed to get fifo_reg_block !");
end
endfunction : build_phase
