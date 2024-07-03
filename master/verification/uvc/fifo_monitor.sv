class fifo_monitor extends uvm_monitor; 
   
  

   `uvm_component_utils(fifo_monitor)

     virtual fifo_if fifo_vif;
    fifo_item req;
    uvm_analysis_port#(fifo_item)   fifo_mon_analysis_port;
    fifo_cfg cfg;
	

    extern function new (string name, uvm_component parent);
    extern virtual function void build_phase (uvm_phase phase);
    extern virtual task  run_phase(uvm_phase phase);  
    
endclass // fifo_monitor

//-------------------------------------------------------------------------------------------------------------//-------------------------------------------------------------------------------------------------------------
function fifo_monitor::new (string name, uvm_component parent);
    super.new(name, parent);
   
    req = fifo_item::type_id::create("req");

    fifo_mon_analysis_port = new("fifo_mon_analysis_port", this);
  
endfunction   

//-------------------------------------------------------------------------------------------------------------
function void fifo_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    

    if(!uvm_config_db#(virtual fifo_if)::get(this, "", "fifo_vif", fifo_vif)) begin
      `uvm_fatal(get_type_name(),"NOVIF: call to uvm_config_db get method failed\n");
    end

 
  if(!uvm_config_db #(fifo_cfg)::get(this, "", "cfg", cfg)) begin 
       `uvm_fatal("", "Failed to get configuration object !");
    end

endfunction

//-------------------------------------------------------------------------------------------------------------
task fifo_monitor::run_phase(uvm_phase phase);

  super.run_phase(phase);
forever begin
     @ (negedge fifo_vif.clk);

	
	
  if (fifo_vif.enable ==1) begin 

	if (fifo_vif.write ==1)begin 
        req.write = fifo_vif.write;
        req.read = fifo_vif.read;  
        req.addr = fifo_vif.addr;
        req.wdata = fifo_vif.wdata;
        req.resp= fifo_vif.resp; 
	`uvm_info("moiotr", "write is beging sent", UVM_LOW)      
	end else if(fifo_vif.read==1) begin 
        req.read = fifo_vif.read; 
        req.write = fifo_vif.write; 
        req.rdata = fifo_vif.rdata;
        req.resp= fifo_vif.resp; 
        req.addr = fifo_vif.addr;
	`uvm_info("monitor","read is begin sent", UVM_LOW)
	end       
        `uvm_info(get_type_name(), $sformatf("Monitor collected trans %s", req.sprint()), UVM_LOW)
        fifo_mon_analysis_port.write(req);
    end
	
  end 
	 
endtask
