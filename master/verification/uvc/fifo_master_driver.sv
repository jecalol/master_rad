class fifo_master_driver extends uvm_driver #(fifo_item);
    
    //Register the driver class to the factory 
     `uvm_component_utils(fifo_master_driver)

    //Declare the virtual interface handle 
    virtual fifo_if fifo_vif;

    fifo_item req;
    fifo_cfg cfg;
    bit reset_flag = 0;
    extern function new(string name, uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task run_phase(uvm_phase phase);
    
    extern virtual task do_init();
    extern virtual task do_drive();
    
endclass : fifo_master_driver

//-------------------------------------------------------------------------------------------------------------
function fifo_master_driver::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction : new

//-------------------------------------------------------------------------------------------------------------
function void fifo_master_driver::build_phase(uvm_phase phase);
    super.build_phase(phase); 
    `uvm_info("build_phase","BUILD fifo_MASTER_DRIVER",UVM_HIGH);
   
    //Retrieve the interface from the config_db 
	if(!uvm_config_db#(virtual fifo_if)::get(this, "", "fifo_vif", fifo_vif)) begin
          `uvm_fatal("", "uvm_config_db::get failed")
       end

   
endfunction : build_phase

//-------------------------------------------------------------------------------------------------------------
task fifo_master_driver::run_phase(uvm_phase phase);

fork
	forever begin
		@(negedge fifo_vif.rst_n);
		do_init();
		reset_flag =1;
		wait( fifo_vif.rst_n == 1);
		@(posedge fifo_vif.clk);
	        reset_flag =0;
	end

       	forever begin
		if(fifo_vif.rst_n == 0) begin 
			do_init();

		end 
		else begin
			seq_item_port.get_next_item( req );
			repeat(req.delay) @(posedge fifo_vif.clk);
			wait(reset_flag == 0)
			do_drive();
			seq_item_port.item_done();
		end
	end 
	

join_none
endtask : run_phase

//-------------------------------------------------------------------------------------------------------------
task fifo_master_driver::do_init();

    fifo_vif.enable =0;
    fifo_vif.addr = 2'b00;
    fifo_vif.write = 0;
    fifo_vif.read= 0;
    fifo_vif.wdata =8'b00000000;
    fifo_vif.rdata =8'b00000000;
    @(posedge fifo_vif.clk);
    `uvm_info("Driver", "do_init task executed", UVM_LOW)
endtask : do_init

//-------------------------------------------------------------------------------------------------------------
task fifo_master_driver::do_drive();
    `uvm_info("Driver", "do_drive task is being executed", UVM_LOW)
	if(req.write==1)begin
 		fifo_vif.write <= req.write;
    		fifo_vif.addr  <= req.addr;
    		fifo_vif.wdata <=req.wdata;
    		fifo_vif.read <= req.read;

	end
	if(req.read==1)begin
 		fifo_vif.write <= req.write;
    		fifo_vif.addr  <= req.addr;
    		fifo_vif.read <= req.read;
   		fifo_vif.rdata <=req.rdata;
	end
   
    fifo_vif.enable <=1;
 	/*if(req.addr==2'b10)begin 
		for (int i=0;i<4;i++)begin 
    			fifo_vif.read <= req.read;
		end
	end else if (req.addr==2'b00) begin
		 fifo_vif.read <= req.read;
	end*/
   @(posedge fifo_vif.clk);
   fifo_vif.enable <=0;

endtask : do_drive
