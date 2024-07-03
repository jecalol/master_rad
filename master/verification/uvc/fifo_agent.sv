`ifndef AGENT
`define AGENT

class fifo_agent extends uvm_agent;



      fifo_master_driver    driver;
      fifo_master_sequencer sequencer;
      fifo_monitor   m_monitor;
     virtual fifo_if fifo_vif;
     fifo_cfg cfg;

      `uvm_component_utils(fifo_agent)

    extern function new (string name, uvm_component parent);
    extern virtual function void build_phase (uvm_phase phase);
    extern virtual function void connect_phase (uvm_phase phase);
    
endclass : fifo_agent

//-------------------------------------------------------------------------------------------------------------
function fifo_agent::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction : new

//-------------------------------------------------------------------------------------------------------------
function void fifo_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db #(virtual fifo_if )::get(this, "", "fifo_vif", fifo_vif)) begin 
       `uvm_fatal("", "Failed to get virtual_interface !");
    end  


    if(cfg.c_is_active == UVM_ACTIVE) begin
      driver = fifo_master_driver::type_id::create("driver", this);
      sequencer = fifo_master_sequencer::type_id::create("sequencer", this);
    end

    m_monitor = fifo_monitor::type_id::create("m_monitor", this);

endfunction : build_phase

//-------------------------------------------------------------------------------------------------------------
function void fifo_agent::connect_phase(uvm_phase phase);

 super.connect_phase(phase); 

// connect ports 
  if (cfg.c_is_active == UVM_ACTIVE) begin 
     driver.seq_item_port.connect(sequencer.seq_item_export); 
  end 

// assign interface 
  if (cfg.c_is_active == UVM_ACTIVE) begin 
     driver.fifo_vif=fifo_vif; 
  end 

  m_monitor.fifo_vif = fifo_vif; 

// assign configuration 
  if (cfg.c_is_active == UVM_ACTIVE) begin 
    driver.cfg = cfg; 
    sequencer.cfg = cfg; 
  end 
  m_monitor.cfg = cfg; 

endfunction : connect_phase

`endif
