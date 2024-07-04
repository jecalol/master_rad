//------------------------------------------------------------------------------------------------------------
class fifo_env extends uvm_env;
    `uvm_component_utils(fifo_env)


   fifo_env_cfg m_env_cfg; 
   fifo_cfg cfg;
   virtual interface fifo_if fifo_vif;
   // agent
   fifo_agent m_agent; 
   fifo_monitor    m_monitor;
   fifo_scoreboard scbd;
   fifo_master_sequencer m_master_seqr;
  //ral
  fifo_reg_block  regmodel;   
  fifo_reg2bus    m_adapter;
  uvm_reg_predictor #(fifo_item) m_apb2reg_predictor;

    extern function new (string name, uvm_component parent);
    extern virtual function void build_phase (uvm_phase phase);
    extern virtual function void connect_phase (uvm_phase phase);
    extern virtual function void end_of_elaboration_phase (uvm_phase phase);
endclass : fifo_env

//------------------------------------------------------------------------------------------------------------
function fifo_env::new (string name, uvm_component parent);
    super.new(name, parent);
endfunction : new

//------------------------------------------------------------------------------------------------------------
function void fifo_env:: build_phase (uvm_phase phase);
    super.build_phase(phase);
    

	m_env_cfg=new();
	uvm_config_db#(fifo_cfg)::set(this,"*","cfg", cfg);  
 if(!uvm_config_db#(virtual fifo_if)::get(this, "", "fifo_vif", fifo_vif)) begin
      `uvm_fatal(get_type_name(), {"virtual interface must be set for:  fifo_vif"});
   end 
   if(!uvm_config_db#(fifo_env_cfg)::get(this, "", "m_env_cfg", m_env_cfg)) begin
     `uvm_fatal(get_type_name(), "Failed to get configuration object from config DB!")
   end
   
   // create system top env components
  m_agent  = fifo_agent::type_id::create("m_agent", this);
  cfg  = fifo_cfg::type_id::create("cfg", this);
  m_monitor  = fifo_monitor::type_id::create("m_monitor", this);
   scbd        =fifo_scoreboard::type_id::create("scbd", this);
   m_master_seqr   = fifo_master_sequencer::type_id::create ("m_master_seqr", this);
   	m_agent.cfg  = m_env_cfg.cfg; //connect agent cfg with cfg from env

  		regmodel = fifo_reg_block::type_id::create("regmodel", this);
        m_adapter   = fifo_reg2bus::type_id::create("m_adapter");
        m_apb2reg_predictor = uvm_reg_predictor#(fifo_item)::type_id::create("m_apb2reg_predictor", this);        
        regmodel.build();
	    regmodel.lock_model();
        uvm_config_db #(fifo_reg_block)::set(null, "*", "regmodel", regmodel);
        


endfunction : build_phase 

//------------------------------------------------------------------------------------------------------------ 
function void fifo_env:: connect_phase (uvm_phase phase);
    super.connect_phase(phase);


        m_agent.m_monitor.fifo_mon_analysis_port.connect (scbd.m_ap);
        m_apb2reg_predictor.map = regmodel.default_map;
        m_apb2reg_predictor.adapter = m_adapter;
        m_agent.m_monitor.fifo_mon_analysis_port.connect(m_apb2reg_predictor.bus_in);
		regmodel.add_hdl_path("top.m_dut0");

        regmodel.default_map.set_sequencer(m_agent.sequencer, m_adapter);
        regmodel.default_map.set_base_addr(8'h1);	
		
endfunction : connect_phase
//------------------------------------------------
function void fifo_env:: end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        regmodel.set_hdl_path_root(.path($sformatf("$root.%s", "top.m_dut0")));
        regmodel.STAT_REG.add_hdl_path('{
            '{$sformatf("fifo_reg_write"),1,4},
            '{$sformatf("fifo_underflow"),1,3},
            '{$sformatf("fifo_overflow"),1,2},
            '{$sformatf("fifo_full"),1,1},
            '{$sformatf("fifo_empty"),1,0}

        });
endfunction : end_of_elaboration_phase 
