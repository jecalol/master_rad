class fifo_item extends uvm_sequence_item; 
    
   rand bit enable;
   rand bit write;
   rand bit read;
   rand bit [7:0] wdata;
   rand bit [1:0] addr;
   rand bit [31:0] delay;
    bit [7:0] rdata;
    bit resp;
   `uvm_object_utils_begin (fifo_item)
	`uvm_field_int(enable, UVM_ALL_ON)
  	`uvm_field_int(write, UVM_ALL_ON)
	`uvm_field_int(read, UVM_ALL_ON)
  	`uvm_field_int(wdata, UVM_ALL_ON)
	`uvm_field_int(addr, UVM_ALL_ON)
	`uvm_field_int(delay, UVM_ALL_ON)
  	
   `uvm_object_utils_end
 	extern function new(string name = "fifo_item"); 
	constraint wr_rd_c {soft  write != read;  }
	constraint delay_c { delay< 10;}
   	constraint w_addr3_c {if(addr == 2'b11) (wdata[5] ==0);(wdata[6] ==0);(wdata[7] ==0); } //to be updated


endclass : fifo_item

function fifo_item::new(string name = "fifo_item");
    super.new(name);
endfunction : new
