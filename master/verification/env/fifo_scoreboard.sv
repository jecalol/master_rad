`uvm_analysis_imp_decl(_master)
//------------------------------------------------------------------------------------------------------------
class fifo_scoreboard extends uvm_scoreboard;

    //Add scoreboard to factory
      `uvm_component_utils (fifo_scoreboard)
      fifo_item req;
	//fifo_covergroup ms_cg;
   //ref model 
      bit [7:0]  refr_fifo[$];
      bit [7:0]  refw_fifo[$];
      bit [7:0]  ref_ctrl_start= 00000001; 
     virtual fifo_if fifo_vif;
    fifo_reg_block  regmodel;  
    int polling_duration=2;
    int polling_interval=10; 
    int cnt=0;
     uvm_analysis_imp_master #(fifo_item, fifo_scoreboard) m_ap;


    
    extern function new(string name = "", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
     extern function void write_master (fifo_item req);
    extern task run_phase (uvm_phase phase);
    extern function void phase_ready_to_end(uvm_phase phase);
  
endclass

//------------------------------------------------------------------------------------------------------------
function fifo_scoreboard::new(string name = "", uvm_component parent);
    super.new(name,parent);
  //ms_cg = new("ms_cg",parent);

endfunction

//------------------------------------------------------------------------------------------------------------
function void fifo_scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual fifo_if )::get(this, "", "fifo_vif", fifo_vif)) begin 
       `uvm_fatal("", "Failed to get virtual_interface !");
    end

      m_ap= new("m_ap", this);
  

	 if(!uvm_config_db#(fifo_reg_block)::get(this, "", "regmodel", regmodel)) begin
	     `uvm_fatal(get_type_name(), "Failed to get configuration object from config DB!")
	   end
endfunction    

//------------------------------------------------------------------------------------------------------------
 function void fifo_scoreboard::write_master (fifo_item req);
bit [7:0] temp;
`uvm_info("SCOREBOARD", "write", UVM_LOW)
	if (req.read) begin 
	//ms_cg.r_cg.sample(req.read,req.addr,req.resp); 
		cnt =cnt-1;
		regmodel.MEM_REG.depth.predict(cnt);
	  if (req.addr == 0) begin 
		if(refw_fifo.size()== 0) begin  
		  	ref_ctrl_start[3] =1; 
			regmodel.STAT_REG.fifo_underflow.predict(1);
		
		end 
		else begin 
			ref_ctrl_start[2] =0;
			regmodel.STAT_REG.fifo_overflow.predict(0);
			refr_fifo.push_back(req.rdata); 
			regmodel.MEM_REG.last_out.predict(req.rdata);
			`uvm_info("ms_scoreboard - write", $sformatf("Data read = %0h", req.rdata), UVM_LOW)
		end 
	  end 

	  if (req.addr == 1) begin 
			`uvm_info("ctl_stat", $sformatf("ctl = %h", req.rdata), UVM_LOW)
			`uvm_info("ref_ctrl_start", $sformatf("ref_ctrl_start = %h", ref_ctrl_start), UVM_LOW)
		if (!(req.rdata[0] ===ref_ctrl_start[0])) begin  `uvm_error("ctl_start","error with empty bit") end 
		if (!(req.rdata[1] ===ref_ctrl_start[1])) begin  `uvm_error("ctl_start","error with full bit") end
		if (!(req.rdata[2] ===ref_ctrl_start[2])) begin  `uvm_error("ctl_start","error with overflow status indication") end
		if (!(req.rdata[3] ===ref_ctrl_start[3])) begin  `uvm_error("ctl_start","error with FIFO underflow status indication")end 
		if (!(req.rdata[4] ===ref_ctrl_start[4])) begin  `uvm_error("ctl_start","error with FIFO clr")end 
			
	 end
	end
	if (req.write) begin
	//ms_cg.w_cg.sample(req.wdata,req.addr); 
		cnt =cnt+1;
		regmodel.MEM_REG.depth.predict(cnt);
	  if (req.addr == 0  || req.addr == 1 || req.addr == 2) begin 
		if(ref_ctrl_start[3] ==1) begin 
			ref_ctrl_start[3] =0;
			regmodel.STAT_REG.fifo_underflow.predict(0);
		end
	 	if(refw_fifo.size()== 16) begin 
			ref_ctrl_start[2] =1;
			regmodel.STAT_REG.fifo_overflow.predict(1);
		end else begin

                 if(refw_fifo.size()== 0) ref_ctrl_start[0] =0; 
			regmodel.STAT_REG.fifo_empty.predict(0);
		`uvm_info("", $sformatf("Data writen = %0h", req.wdata), UVM_LOW)
     			refw_fifo.push_back(req.wdata);
			regmodel.MEM_REG.last_in.predict(req.wdata);
			if(refw_fifo.size()== 16) begin 
				ref_ctrl_start[1] =1;
			regmodel.STAT_REG.fifo_full.predict(1);
			end

	        end
	  end  
	  if (req.addr == 3) begin 
		if(req.wdata[4]==1) begin 
		refw_fifo.delete();
		refr_fifo.delete();
		ref_ctrl_start= 00000001;
		regmodel.STAT_REG.predict(00000001);
	 end 
	 end
	end
endfunction
//------------------------------------------------------------------------------------------------------------
function void fifo_scoreboard::phase_ready_to_end(uvm_phase phase);
 if (phase.get_name() != "run") return;
 if (refr_fifo.size() != 0) begin

  `uvm_fatal ("phase_ready_to_end","queue not empty")
 end
endfunction


       
task fifo_scoreboard:: run_phase (uvm_phase phase);
	bit [7:0] expcteddata, recveddata; 
fork
	forever begin 
	  `uvm_info("SCOREBOARD", "run task, for reset", UVM_LOW)
		@(negedge fifo_vif.rst_n == 0) begin	 	
		refw_fifo.delete();
		refr_fifo.delete();
		ref_ctrl_start= 00000001;
		regmodel.STAT_REG.predict(00000001);
	end 
	end 
	forever begin
	  `uvm_info("SCOREBOARD", "run task", UVM_LOW)
		  wait (refr_fifo.size()>0 && refw_fifo.size()>0);
		if(refw_fifo.size()== 16) begin 
				ref_ctrl_start[1] =0;
			regmodel.STAT_REG.fifo_full.predict(0);
			end
		
		 expcteddata=refw_fifo.pop_front(); 
		if(refw_fifo.size()== 0) begin 
				ref_ctrl_start[0] =1;
			regmodel.STAT_REG.fifo_empty.predict(1);
			end
		    // Compare 
		    if (expcteddata == recveddata) begin
		        `uvm_info("SCOREBOARD", "Data match", UVM_LOW)
		    end else begin
		        `uvm_error("SCOREBOARD", $sformatf(" EEROR expected= %0h, receved= %0h", expcteddata, recveddata))
		    end



	end
join_none
endtask
