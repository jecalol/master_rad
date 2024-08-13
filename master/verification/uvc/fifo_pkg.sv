//`ifndef fifo_PKG_SV
//`define fifo_PKG_SV

//------------------------------------------------------------------------------------------------------------
`include "uvm_macros.svh"

package fifo_pkg;
    import uvm_pkg::*;
   // import ral_pkg::*;
   `include "../ral/fifo_reg.sv"
   `include "../ral/fifo_reg_block.sv"

  `include "fifo_item.sv"
   `include "../ral/fifo_reg2bus.sv"

  `include "fifo_cfg.sv"
  `include "fifo_master_sequencer.sv"
  `include "fifo_master_sequence_lib.sv"
  `include "fifo_backdoor_sequnece_lib.sv"
  `include "fifo_master_driver.sv"
  `include "fifo_monitor.sv"
  `include "fifo_agent.sv"



endpackage 

//`endif //fifo_PKG_SV
