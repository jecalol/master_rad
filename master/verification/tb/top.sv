`include "fifo_test_pkg.sv"

module top;
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    import fifo_test_pkg::*;
	bit clk;
	bit rst_n;

    //Generate the clock signal 
	always begin 

		#10 clk=~clk;
	end
	
    //Insantiate the interface
    fifo_if fifo_vif(clk,rst_n);     
    //Insantiate the DUT and connect it to the interface
    master_module m_dut0 (fifo_vif.clk, fifo_vif.rst_n, fifo_vif.enable, fifo_vif.addr, fifo_vif.write,  fifo_vif.read, fifo_vif.wdata, fifo_vif.rdata, fifo_vif.resp);

    initial begin   
	rst_n =1'b0; 
 	#100;
	rst_n =1'b1;
	

    end    
    initial begin    
        uvm_config_db#(virtual fifo_if)::set(null,"*","fifo_vif", fifo_vif);  
        run_test();
    	

    end

    initial begin
	$recordfile("dump");
	$recordvars(top);
    end
endmodule 

