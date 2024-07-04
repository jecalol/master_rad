class fifo_reg_block extends uvm_reg_block;
  `uvm_object_utils(fifo_reg_block)

	rand fifo_ctl_reg STAT_REG;//RW
	rand fifo_mem_reg MEM_REG;//RO
	//ral_coverage cg;
    function new(string name="fifo_reg_block");
		super.new(name, UVM_NO_COVERAGE);
	endfunction
    extern virtual function void build();
	
	
endclass:fifo_reg_block
//--------------------------------------------------------------------
function void fifo_reg_block::build();
    STAT_REG = fifo_ctl_reg::type_id::create("STAT_REG");
    MEM_REG = fifo_mem_reg::type_id::create("MEM_REG");

    STAT_REG.build();
    MEM_REG.build();

    STAT_REG.configure(this);
    MEM_REG.configure(this);

    STAT_REG.add_hdl_path_slice("STAT_REG", 0, 8);      


 	default_map = create_map("default_map", 0,1, UVM_LITTLE_ENDIAN); // name, base, nBytes

    	default_map.add_reg(this.STAT_REG, 8'h1, "RW",0);  // reg, offset, access
    	default_map.add_reg(this.MEM_REG, 8'h2, "RO",0);  // reg, offset, access
	default_map.set_auto_predict(1);
	default_map.set_check_on_read(1);
	lock_model();


endfunction: build
