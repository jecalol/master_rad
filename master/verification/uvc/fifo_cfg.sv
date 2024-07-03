class fifo_cfg extends uvm_object;  


  uvm_active_passive_enum c_is_active;
    bit                   has_coverage;

  virtual fifo_if fifo_vif;
  `uvm_object_utils_begin(fifo_cfg)
    `uvm_field_enum (uvm_active_passive_enum, c_is_active, UVM_ALL_ON)
    `uvm_field_int  (has_coverage,                       UVM_ALL_ON)
  `uvm_object_utils_end
    


    
    extern function new(string name = "fifo_cfg");
    

   function void set_default_config();
	c_is_active= UVM_ACTIVE;
	has_coverage =1;
   endfunction 

endclass : fifo_cfg

//-------------------------------------------------------------------------------------------------------------
function fifo_cfg::new(string name = "fifo_cfg");
    super.new(name);
endfunction : new
