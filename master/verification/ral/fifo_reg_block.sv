class fifo_reg_block extends uvm_reg_block;
  `uvm_object_utils(fifo_reg_block)

	rand fifo_ctl_reg CTL_STAT;//RW
	rand fifo_mem_reg MEM_REG;//RO
	//ral_coverage cg;
    function new(string name="fifo_reg_block");
		super.new(name, UVM_NO_COVERAGE);
	endfunction
    extern virtual function void build();
	
	
endclass:fifo_reg_block
//--------------------------------------------------------------------
function void fifo_reg_block::build();
    CTL_STAT = fifo_ctl_reg::type_id::create("CTL_STAT");
    MEM_REG = fifo_mem_reg::type_id::create("MEM_REG");

    CTL_STAT.build();
    MEM_REG.build();

    CTL_STAT.configure(this);
    MEM_REG.configure(this);

    CTL_STAT.add_hdl_path_slice("CTL_STAT", 0, 8);      

 	default_map = create_map("default_map", 0,1, UVM_LITTLE_ENDIAN,0); // name, base, nBytes


    	default_map.add_reg(this.CTL_STAT, 8'h1, "RW",0);  // reg, offset, access
    	default_map.add_reg(this.MEM_REG, 8'h2, "RO",0);  // reg, offset, access
	default_map.set_auto_predict(1);
	default_map.set_check_on_read(1);
	lock_model();


endfunction: build
