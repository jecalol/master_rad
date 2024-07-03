
//`include "uvm_pkg.sv"

package fifo_test_pkg;

    import uvm_pkg::*;
    import fifo_pkg::*;
    import fifo_env_pkg::*;
    
    `include "uvm_macros.svh" 
    `include "fifo_base_test.sv"
    `include "fifo_epty_uf_test.sv"
    `include "fifo_full_of_test.sv"
endpackage 

//------------------------------------------------------------------------------------------------------------
