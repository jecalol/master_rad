
//`include "uvm_pkg.sv"

package fifo_test_pkg;

    import uvm_pkg::*;
    import fifo_pkg::*;
    import fifo_env_pkg::*;
    
    `include "uvm_macros.svh" 
    `include "fifo_base_test.sv"
    `include "fifo_base_back_test.sv"
    `include "fifo_epty_uf_test.sv"
    `include "fifo_sanity_test.sv"
    `include "fifo_full_of_test.sv"
    `include "fifo_full_of_back_test.sv"
    `include "fifo_epty_uf_back_test.sv"
    `include "fifo_clr_back_test.sv"  
    `include "fifo_clr_test.sv"
    `include "fifo_rand_back_test.sv"
    `include "fifo_rand_test.sv"
    `include "mem_base_back_test.sv"
    `include "mem_rand_test.sv"
    `include "mem_rand_back_test.sv"
    `include "mem_base_test.sv"
endpackage 

//------------------------------------------------------------------------------------------------------------
